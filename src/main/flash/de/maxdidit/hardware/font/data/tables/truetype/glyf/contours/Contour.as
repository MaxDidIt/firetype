package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours
{
	import de.maxdidit.list.CircularLinkedList;
	import de.maxdidit.math.AxisAlignedBoundingBox;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Contour
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _vertices:CircularLinkedList;
		private var _segments:Vector.<IPathSegment>;
		
		private var _boundingBox:AxisAlignedBoundingBox;
		private var _clockWise:Boolean;
		private var _holes:Vector.<Contour>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Contour()
		{
			_holes = new Vector.<Contour>();
			_boundingBox = new AxisAlignedBoundingBox();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get segments():Vector.<IPathSegment>
		{
			return _segments;
		}
		
		public function set segments(value:Vector.<IPathSegment>):void
		{
			_segments = value;
		}
		
		public function get vertices():CircularLinkedList
		{
			return _vertices;
		}
		
		public function set vertices(value:CircularLinkedList):void
		{
			_vertices = value;
			calculateBoundingBox();
			calculateDirection();
		}
		
		public function get boundingBox():AxisAlignedBoundingBox 
		{
			return _boundingBox;
		}
		
		public function get clockWise():Boolean 
		{
			return _clockWise;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function contains(contour:Contour):Boolean
		{
			var contourBB:AxisAlignedBoundingBox = contour.boundingBox;
			
			if (contourBB.left < _boundingBox.left)
			{
				return false;
			}
			
			if (contourBB.right > _boundingBox.right)
			{
				return false;
			}
			
			if (contourBB.top > _boundingBox.top)
			{
				return false;
			}
			
			if (contourBB.bottom < _boundingBox.bottom)
			{
				return false;
			}
			
			return true;
		}
		
		public function retrievePath(subdivision:uint):Vector.<Vertex>
		{
			var path:Vector.<Vertex> = new Vector.<Vertex>();
			
			const l:uint = _segments.length;
			for (var i:uint = 0; i < l; i++)
			{
				_segments[i].addVerticesToList(path, subdivision);
			}
			
			// add holes
			const h:uint = _holes.length;
			for (i = 0; i < h; i++)
			{
				var holePath:Vector.<Vertex> = _holes[i].retrievePath(subdivision);
				path = connectPaths(path, holePath);
			}
			
			return path;
		}
		
		public function addHole(hole:Contour):void 
		{
			_holes.push(hole);
		}
		
		public function sortHoles():void
		{
			_holes.sort(compareHole);
		}
		
		private function compareHole(contourA:Contour, contourB:Contour):Number 
		{
			return contourB.boundingBox.right - contourA.boundingBox.right;
		}
		
		private function calculateBoundingBox():void
		{
			var firstElement:VertexListElement = _vertices.firstElement as VertexListElement;
			var currentElement:VertexListElement = firstElement;
			var vertex:Vertex;
			
			var minX:Number = Number.MAX_VALUE;
			var minY:Number = Number.MAX_VALUE;
			
			var maxX:Number = Number.MIN_VALUE;
			var maxY:Number = Number.MIN_VALUE;
			
			do
			{
				vertex = currentElement.vertex;
				
				minX = vertex.x < minX ? vertex.x : minX;
				minY = vertex.y < minY ? vertex.y : minY;
				
				maxX = vertex.x > maxX ? vertex.x : maxX;
				maxY = vertex.y > maxY ? vertex.y : maxY;
				
				currentElement = currentElement.next as VertexListElement;
			} while (firstElement != currentElement);
			
			_boundingBox.left = minX;
			_boundingBox.bottom = minY;
			
			_boundingBox.right = maxX;
			_boundingBox.top = maxY;
		}
		
		private function calculateDirection():void 
		{
			var startElement:VertexListElement = _vertices.firstElement as VertexListElement;
			var currentElement:VertexListElement = startElement as VertexListElement;
			
			var result:Number = 0;
			
			do
			{
				var currentVertex:Vertex = currentElement.vertex;
				var nextVertex:Vertex = (currentElement.next as VertexListElement).vertex;
				
				result += ((nextVertex.x - currentVertex.x) * (currentVertex.y + nextVertex.y));
				
				currentElement = currentElement.next as VertexListElement;
			} while (startElement != currentElement);
			
			_clockWise = result > 0;
		}
		
		private function connectPaths(pathA:Vector.<Vertex>, pathB:Vector.<Vertex>):Vector.<Vertex>
		{
			var result:Vector.<Vertex> = new Vector.<Vertex>();
			
			// find shortest distance between vertices
			const lA:uint = pathA.length;
			const lB:uint = pathB.length;
			
			var validA:uint = 0;
			var biggestB:uint = 0;
			
			var biggestX:Number = Number.MIN_VALUE;
			var biggestY:Number = Number.MIN_VALUE;
			for (var b:uint = 0; b < lB; b++)
			{
				var vertexB:Vertex = pathB[b];
				
				if (vertexB.x > biggestX)
				{
					biggestX = vertexB.x;
					biggestY = Number.MIN_VALUE;
					biggestB = b;
				}
				else if (vertexB.x == biggestX)
				{
					if (vertexB.y > biggestY)
					{
						biggestY = vertexB.y;
						biggestB = b;
					}
				}
			}
			
			vertexB = pathB[biggestB];
			while (validA < lA)
			{
				var vertexA:Vertex = pathA[validA];
				if (vertexA.x <= biggestX)
				{
					validA++;
					continue;
				}
				
				if (!intersectsAllRelevantPaths(vertexA, vertexB, pathA))
				{
					break;
				}
				
				validA++;
			}
			
			// fill result
			// fill up to bridge vertex in A
			for (var i:uint = 0; i <= validA; i++)
			{
				result.push(pathA[i]);
			}
			
			// fill from bridge vertex in B till end
			for (i = biggestB; i < lB; i++)
			{
				result.push(pathB[i]);
			}
			
			// fill from beginning to bridge vertex in B
			for (i = 0; i <= biggestB; i++)
			{
				result.push(pathB[i]);
			}
			
			// fill from bridge vertex in A till end
			for (i = validA; i < lA; i++)
			{
				result.push(pathA[i]);
			}
			
			return result;
		}
		
		private function intersectsAllRelevantPaths(vertexA:Vertex, vertexB:Vertex, pathA:Vector.<Vertex>):Boolean 
		{
			intersectsPath(new Vertex(1, 1), new Vertex(-1, -1), new Vertex(-1, 1), new Vertex(1, -1));
			intersectsPath(new Vertex(-1, 1), new Vertex(1, -1), new Vertex(1, 1), new Vertex(-1, -1));
			
			const l:uint = pathA.length;
			for (var i:uint = 0; i < l; i++)
			{
				var vertexC:Vertex = pathA[i];
				var vertexD:Vertex = pathA[(i + 1) % l];
				if (intersectsPath(vertexA, vertexB, vertexC, vertexD) && //
					intersectsPath(vertexC, vertexD, vertexA, vertexB))
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function intersectsPath(vertexA:Vertex, vertexB:Vertex, vertexC:Vertex, vertexD:Vertex):Boolean 
		{
			var vertexAB:Vertex = new Vertex(vertexB.x - vertexA.x, vertexB.y - vertexA.y);
			var vertexCD:Vertex = new Vertex(vertexD.x - vertexC.x, vertexD.y - vertexC.y);
			
			var s:Number = vertexA.y + vertexAB.y * (vertexC.x - vertexA.x) / vertexAB.x - vertexC.y;
			s /= vertexCD.y - vertexCD.x * vertexAB.y / vertexAB.x;
			
			return s > 0 && s < 1;
		}
	}

}