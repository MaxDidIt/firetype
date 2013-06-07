package de.maxdidit.hardware.font.triangulation
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.list.CircularLinkedList;
	import de.maxdidit.list.elements.UnsignedIntegerListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class EarClippingTriangulator implements ITriangulator
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function EarClippingTriangulator()
		{
		
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function triangulatePath(path:Vector.<Vertex>, result:Vector.<uint>, indexOffset:uint):uint
		{
			const l:uint = path.length;
			var numTriangles:uint = 0;
			
			// create index array
			var smallestX:Number = Number.MAX_VALUE;
			var smallestY:Number = Number.MAX_VALUE;
			var smallestI:uint = 0;
			var availableIndices:CircularLinkedList = new CircularLinkedList();
			for (var i:uint = 0; i < l; i++)
			{
				if (path[i].x < smallestX)
				{
					smallestX = path[i].x;
					smallestI = i;
				}
				else if (path[i].x == smallestX)
				{
					if (path[i].y < smallestY)
					{
						smallestY = path[i].y;
						smallestI = i;
					}
				}
				
				//trace(path[i].x.toFixed(2) + "  \t" + path[i].y.toFixed(2));
				availableIndices.addElement(new UnsignedIntegerListElement(i));
			}
			
			// determine whether the polygon is clockwise or counter-clockwise
			var j:uint = smallestI == 0 ? l - 1 : smallestI - 1;
			var k:uint = (smallestI + 1) % l;
			
			var currentVertex:Vertex = path[j];
			var previousVertex:Vertex = path[smallestI];
			var nextVertex:Vertex = path[k];
			
			var determinant:Number = (currentVertex.x * nextVertex.y + previousVertex.x * currentVertex.y + previousVertex.y * nextVertex.x);
			determinant -= (previousVertex.y * currentVertex.x + currentVertex.y * nextVertex.x + previousVertex.x * nextVertex.y);
			var clockwise:Boolean = determinant > 0;
			
			// ear clipping algorithm
			
			var currentIndex:UnsignedIntegerListElement = availableIndices.firstElement as UnsignedIntegerListElement;
			
			//var iterations:uint = 0; // fail safe to prevent infinite loops
			while (availableIndices.numElements > 3) // && iterations < 1500)
			{
				currentVertex = path[currentIndex.value];
				previousVertex = path[(currentIndex.previous as UnsignedIntegerListElement).value];
				nextVertex = path[(currentIndex.next as UnsignedIntegerListElement).value];
				
				var toPreviousX:Number = previousVertex.x - currentVertex.x;
				var toPreviousY:Number = previousVertex.y - currentVertex.y;
				
				var toNextX:Number = nextVertex.x - currentVertex.x;
				var toNextY:Number = nextVertex.y - currentVertex.y;
				
				// test if current vertex is part of convex hull
				var crossProduct:Number = toPreviousX * toNextY - toPreviousY * toNextX;
				
				if (clockwise)
				{
					if (crossProduct <= 0)
					{
						// iterate
						currentIndex = currentIndex.next as UnsignedIntegerListElement;
						//iterations++;
						continue;
					}
				}
				else
				{
					if (crossProduct >= 0)
					{
						// iterate
						currentIndex = currentIndex.next as UnsignedIntegerListElement;
						//iterations++;
						continue;
					}
				}
				
				if (containsAnyPointFromPath(path, previousVertex, currentVertex, nextVertex, currentIndex.next.next as UnsignedIntegerListElement, currentIndex.previous as UnsignedIntegerListElement))
				{
					// iterate
					currentIndex = currentIndex.next as UnsignedIntegerListElement;
					//iterations++;
					continue;
				}
				
				// add triangle to result
				result.push((currentIndex.previous as UnsignedIntegerListElement).value + indexOffset);
				result.push(currentIndex.value + indexOffset);
				result.push((currentIndex.next as UnsignedIntegerListElement).value + indexOffset);
				
				numTriangles++;
				
				// remove current index
				availableIndices.removeElement(currentIndex);
				
				currentIndex = availableIndices.firstElement as UnsignedIntegerListElement;
				//iterations = 0;
			}
			
			// add the last triangle
			result.push((currentIndex.previous as UnsignedIntegerListElement).value + indexOffset);
			result.push(currentIndex.value + indexOffset);
			result.push((currentIndex.next as UnsignedIntegerListElement).value + indexOffset);
			
			numTriangles++;
			
			return numTriangles;
		}
		
		private function containsAnyPointFromPath(path:Vector.<Vertex>, vertexA:Vertex, vertexB:Vertex, vertexC:Vertex, startElement:UnsignedIntegerListElement, endElement:UnsignedIntegerListElement):Boolean
		{
			var currentElement:UnsignedIntegerListElement = startElement;
			
			while (currentElement != endElement)
			{
				var currentVertex:Vertex = path[currentElement.value];
				
				
				if (isInsideTriangle(currentVertex, vertexA, vertexB, vertexC))
				{
					return true;
				}
				
				currentElement = currentElement.next as UnsignedIntegerListElement;
			}
			
			return false;
		}
		
		private function isInsideTriangle(currentVertex:Vertex, vertexA:Vertex, vertexB:Vertex, vertexC:Vertex):Boolean
		{
			// source: http://www.blackpawn.com/texts/pointinpoly/
			// test if currentVertex coincides with one of the triangle vertices.
			if (currentVertex.x == vertexA.x && currentVertex.y == vertexA.y)
			{
				return false;
			}
			
			if (currentVertex.x == vertexB.x && currentVertex.y == vertexB.y)
			{
				return false;
			}
			
			if (currentVertex.x == vertexC.x && currentVertex.y == vertexC.y)
			{
				return false;
			}
			
			const v1_x:Number = currentVertex.x - vertexB.x;
			const v1_y:Number = currentVertex.y - vertexB.y;
			
			const vBC_x:Number = vertexC.x - vertexB.x;
			const vBC_y:Number = vertexC.y - vertexB.y;
			
			if (v1_x * vBC_y + v1_y * vBC_x == 0)
			{
				var projection:Number = (v1_x * vBC_x + v1_y * vBC_y) / (vBC_x * vBC_x + vBC_y * vBC_y);
				if (projection > 0 && projection < 1)
				{
					return true;
				}
			}
			
			const v2_x:Number = currentVertex.x - vertexA.x;
			const v2_y:Number = currentVertex.y - vertexA.y;
			
			const vAC_x:Number = vertexC.x - vertexA.x;
			const vAC_y:Number = vertexC.y - vertexA.y;
			
			const vAB_x:Number = vertexB.x - vertexA.x;
			const vAB_y:Number = vertexB.y - vertexA.y;
			
			const dot00:Number = vAC_x * vAC_x + vAC_y * vAC_y;
			const dot01:Number = vAC_x * vAB_x + vAC_y * vAB_y;
			const dot02:Number = vAC_x * v2_x + vAC_y * v2_y;
			const dot11:Number = vAB_x * vAB_x + vAB_y * vAB_y;
			const dot12:Number = vAB_x * v2_x + vAB_y * v2_y;
			
			const inverseDenominator:Number = 1 / (dot00 * dot11 - dot01 * dot01);
			const u:Number = inverseDenominator * (dot11 * dot02 - dot01 * dot12);
			const v:Number = inverseDenominator * (dot00 * dot12 - dot01 * dot02);
			
			return (u >= 0) && (v >= 0) && (u + v < 1);
		}
	}

}