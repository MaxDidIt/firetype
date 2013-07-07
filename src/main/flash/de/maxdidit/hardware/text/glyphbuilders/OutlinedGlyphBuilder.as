package de.maxdidit.hardware.text.glyphbuilders
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.PathConnector;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class OutlinedGlyphBuilder extends SimpleGlyphBuilder
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _outlineThickness:Number;
		private var _pathConnector:PathConnector;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function OutlinedGlyphBuilder(triangulator:ITriangulator, outlineThickness:Number)
		{
			super(triangulator);
			this._outlineThickness = outlineThickness;
			_pathConnector = new PathConnector();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function buildGlyph(paths:Vector.<Vector.<Vertex>>, originalPaths:Vector.<Vector.<Vertex>>):HardwareGlyph
		{
			var result:HardwareGlyph = super.buildGlyph(paths, originalPaths);
			//var result:HardwareGlyph = new HardwareGlyph();
			//result.vertices = new Vector.<Vertex>();
			//result.indices = new Vector.<uint>();
			
			const pl:uint = originalPaths.length;
			for (var i:uint = 0; i < pl; i++)
			{
				var path:Vector.<Vertex> = originalPaths[i];
				buildOutline(result, path);
			}
			
			return result;
		}
		
		private function buildOutline(result:HardwareGlyph, path:Vector.<Vertex>):void
		{
			var outlineBase:Vector.<Vertex> = new Vector.<Vertex>();
			var outlineVertices:Vector.<Vertex> = new Vector.<Vertex>();
			var minDistanceIndices:Vector.<uint> = new Vector.<uint>();
			
			var l:uint = path.length;
			
			//copy original vertices into outlineVertices
			var sumCrossProduct:Number = 0;
			outlineBase.length = l;
			for (var i:int = 0; i < l; i++)
			{
				var vertexA:Vertex = path[i];
				var vertexB:Vertex = path[(i + 1) % l];
				
				sumCrossProduct += vertexA.nX * vertexB.nY - vertexA.nY * vertexB.nX;
				
				vertexB = new Vertex(vertexA.x, vertexA.y);
				
				vertexB.nX = -vertexA.nX;
				vertexB.nY = -vertexA.nY;
				
				vertexB.index = 1;
				
				outlineBase[l - 1 - i] = vertexB;
			}
			
			outlineVertices.length = l;
			for (i = 0; i < l; i++)
			{
				vertexA = path[i];
				vertexB = new Vertex(vertexA.x, vertexA.y);
				
				vertexB.nX = vertexA.nX;
				vertexB.nY = vertexA.nY;
				
				vertexB.index = 1;
				
				outlineVertices[i] = vertexB;
			}
			
			var distanceProgress:Number = 0;
			
			//trace("----");
			
			while (distanceProgress < _outlineThickness)
			{
				var minDistance:Number = calculateMinDistance(_outlineThickness - distanceProgress, outlineVertices, minDistanceIndices);
				outlineVertices = insetVertices(minDistance, outlineVertices);
				outlineVertices = createNextVertexLayer(minDistance, outlineVertices, minDistanceIndices);
				
				distanceProgress += minDistance;
				//trace(distanceProgress);
			}
			
			// connect outlines
			if (sumCrossProduct < 0)
			{
				_pathConnector.connectPaths(outlineVertices, outlineBase);
				triangulator.triangulatePath(outlineVertices, result.indices, result.vertices.length);
			}
			else
			{
				_pathConnector.connectPaths(outlineBase, outlineVertices);
				triangulator.triangulatePath(outlineBase, result.indices, result.vertices.length);
				outlineVertices = outlineBase;
			}
			
			// copy outline vertices
			l = outlineVertices.length;
			var k:int = result.vertices.length;
			result.vertices.length += l;
			for (i = 0; i < l; i++)
			{
				result.vertices[k++] = outlineVertices[i];
			}
		}
		
		private function insetVertices(distance:Number, outlineVertices:Vector.<Vertex>):Vector.<Vertex>
		{
			var insetVertices:Vector.<Vertex> = new Vector.<Vertex>(outlineVertices.length);
			
			const outlineLength:uint = outlineVertices.length;
			
			// Inset
			for (var outlineIndex:uint = 0; outlineIndex < outlineLength; outlineIndex++)
			{
				var vertexA:Vertex = outlineVertices[outlineIndex];
				var vertexB:Vertex = outlineVertices[(outlineIndex + 1) % outlineLength];
				
				// calculate distance along normal that the vertex should be moved
				var baX:Number = vertexB.y - vertexA.y;
				var baY:Number = -(vertexB.x - vertexA.x);
				var baL:Number = Math.sqrt(baX * baX + baY * baY);
				baX /= baL;
				baY /= baL;
				
				var cosAlpha:Number = (baX * vertexA.nX + baY * vertexA.nY);
				var scale:Number = distance / -cosAlpha;
				
				if (isNaN(scale))
				{
					scale = 0;
				}
				
				// create new vertex
				var newVertex:Vertex = new Vertex(vertexA.x + vertexA.nX * scale, vertexA.y + vertexA.nY * scale);
				
				newVertex.nX = vertexA.nX;
				newVertex.nY = vertexA.nY;
				
				insetVertices[outlineIndex] = newVertex;
			}
			
			return insetVertices;
		}
		
		private function createNextVertexLayer(distance:Number, outlineVertices:Vector.<Vertex>, minDistanceIndices:Vector.<uint>):Vector.<Vertex>
		{
			const insetLength:uint = outlineVertices.length - minDistanceIndices.length;
			var insetVertices:Vector.<Vertex> = new Vector.<Vertex>(insetLength);
			
			const outlineLength:uint = outlineVertices.length;
			const indicesLength:uint = minDistanceIndices.length;
			
			var insetIndex:uint = 0;
			var indexIndex:uint = 0;
			
			// remove intersection vertices
			for (var outlineIndex:uint = 0; outlineIndex < outlineLength; outlineIndex++)
			{
				var vertexA:Vertex = outlineVertices[outlineIndex];
				
				// create new vertex
				var newVertex:Vertex = new Vertex(vertexA.x, vertexA.y);
				
				// test if vertex is an intersection				
				newVertex.nX = vertexA.nX;
				newVertex.nY = vertexA.nY;
				
				newVertex.index = 1;
				
				if (indexIndex < indicesLength && minDistanceIndices[indexIndex] == outlineIndex)
				{
					// calculate new normal
					var vertexB:Vertex = outlineVertices[(outlineIndex + 2) % outlineLength];
					
					// calculate distance along normal that the vertex should be moved
					var baX:Number = vertexB.x - vertexA.x;
					var baY:Number = vertexB.y - vertexA.y;
					var baL:Number = Math.sqrt(baX * baX + baY * baY);
					baX /= baL;
					baY /= baL;
					var vertexC:Vertex = outlineVertices[outlineIndex == 0 ? outlineLength - 1 : outlineIndex - 1];
					
					var caX:Number = vertexC.x - vertexA.x;
					var caY:Number = vertexC.y - vertexA.y;
					var caL:Number = Math.sqrt(caX * caX + caY * caY);
					caX /= caL;
					caY /= caL;
					
					newVertex.nX = baX + caX;
					newVertex.nY = baY + caY;
					var nL:Number = Math.sqrt(newVertex.nX * newVertex.nX + newVertex.nY * newVertex.nY);
					newVertex.nX /= nL;
					newVertex.nY /= nL;
					
					outlineIndex++; // skip next vertex
					indexIndex++;
				}
				
				insetVertices[insetIndex % insetLength] = newVertex;
				insetIndex++;
			}
			
			return insetVertices;
		}
		
		private function calculateMinDistance(initialMinDistance:Number, outlineVertices:Vector.<Vertex>, minDistanceIndices:Vector.<uint>):Number
		{
			var minDistance:Number = initialMinDistance;
			
			minDistanceIndices.length = 0;
			
			//trace("------");
			
			const l:uint = outlineVertices.length;
			for (var i:uint = 0; i < l; i++)
			{
				var vertexA:Vertex = outlineVertices[i];
				var vertexB:Vertex = outlineVertices[(i + 1) % l];
				
				var intersection:Vertex = calculateIntersection(vertexA, vertexB);
				var distance:Number = calculateDistanceToEdge(intersection, vertexA, vertexB);
				
				//trace(i + "- " + distance);
				
				if (distance >= 0)
				{
					if (minDistance == distance)
					{
						minDistanceIndices.push(i);
					}
					else if (distance <= minDistance)
					{
						minDistance = distance;
						minDistanceIndices.length = 1;
						minDistanceIndices[0] = i;
					}
				}
			}
			
			return minDistance;
		}
		
		private function calculateDistanceToEdge(intersection:Vertex, vertexA:Vertex, vertexB:Vertex):Number
		{
			const abX:Number = vertexB.x - vertexA.x;
			const abY:Number = vertexB.y - vertexA.y;
			const abL:Number = Math.sqrt(abX * abX + abY * abY);
			
			if (abL == 0)
			{
				return 0;
			}
			
			const cosAlpha:Number = (vertexA.nX * abX + vertexA.nY * abY) / abL;
			const sinAlpha:Number = Math.sin(Math.acos(cosAlpha)); // Ew!
			
			// hypotenuse
			const hX:Number = intersection.x - vertexA.x;
			const hY:Number = intersection.y - vertexA.y;
			const lengthHypotenuse:Number = Math.sqrt(hX * hX + hY * hY);
			
			const lengthOpposite:Number = sinAlpha * lengthHypotenuse;
			
			const crossProduct:Number = abX * hY - abY * hX;
			
			return crossProduct > 0 ? lengthOpposite : -lengthOpposite;
		}
		
		private function calculateIntersection(vertexA:Vertex, vertexB:Vertex):Vertex
		{
			const nBynBx:Number = vertexB.nY / vertexB.nX;
			const t:Number = (vertexB.y + nBynBx * (vertexA.x - vertexB.x) - vertexA.y) / (vertexA.nY - nBynBx * vertexA.nX);
			
			return new Vertex(vertexA.x + vertexA.nX * t, vertexA.y + vertexA.nY * t);
		}
	
	}

}