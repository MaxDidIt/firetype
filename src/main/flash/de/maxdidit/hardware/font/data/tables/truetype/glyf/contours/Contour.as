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
		
		public function retrievePath(vertexDistance:uint, expectedClockwise:Boolean = true):Vector.<Vertex>
		{
			var path:Vector.<Vertex> = new Vector.<Vertex>();
			if (!_segments)
			{
				return path;
			}
			
			const l:uint = _segments.length;
			for (var i:uint = 0; i < l; i++)
			{
				_segments[i].addVerticesToList(path, vertexDistance, expectedClockwise == _clockWise);
			}
			
			// add holes
			const h:uint = _holes.length;
			for (i = 0; i < h; i++)
			{
				var holePath:Vector.<Vertex> = _holes[i].retrievePath(vertexDistance, !expectedClockwise);
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
			_holes.sort(sortByUpperBoundary);
		}
		
		private function sortByUpperBoundary(contourA:Contour, contourB:Contour):Number
		{
			return contourB.boundingBox.top - contourA.boundingBox.top;
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
			var biggestXElement:VertexListElement = startElement;
			do
			{
				var currentVertex:Vertex = currentElement.vertex;
				if (currentVertex.x > biggestXElement.vertex.x)
				{
					biggestXElement = currentElement;
				}
				else if (currentVertex.x == biggestXElement.vertex.x)
				{
					if (currentVertex.y > biggestXElement.vertex.y)
					{
						biggestXElement = currentElement;
					}
				}
				
				currentElement = currentElement.next as VertexListElement;
			} while (startElement != currentElement);
			
			currentVertex = biggestXElement.vertex;
			var previousVertex:Vertex = (biggestXElement.previous as VertexListElement).vertex;
			var nextVertex:Vertex = (biggestXElement.next as VertexListElement).vertex;
			
			var determinant:Number = (currentVertex.x * nextVertex.y + previousVertex.x * currentVertex.y + previousVertex.y * nextVertex.x);
			determinant -= (previousVertex.y * currentVertex.x + currentVertex.y * nextVertex.x + previousVertex.x * nextVertex.y);
			_clockWise = determinant > 0;
		}
		
		private function findBiggestXIndex(path:Vector.<Vertex>):uint
		{
			const l:uint = path.length;
			
			var biggestI:uint = 0;
			var biggestX:Number = Number.MIN_VALUE;
			var biggestY:Number = Number.MIN_VALUE;
			
			for (var i:uint = 0; i < l; i++)
			{
				var vertex:Vertex = path[i];
				
				if (vertex.x > biggestX)
				{
					biggestX = vertex.x;
					biggestY = Number.MIN_VALUE;
					biggestI = i;
				}
				else if (vertex.x == biggestX)
				{
					if (vertex.y > biggestY)
					{
						biggestY = vertex.y;
						biggestI = i;
					}
				}
			}
			
			return biggestI;
		}
		
		private function connectPaths(pathA:Vector.<Vertex>, pathB:Vector.<Vertex>):Vector.<Vertex>
		{
			var result:Vector.<Vertex> = new Vector.<Vertex>();
			
			// find shortest distance between vertices
			const lA:uint = pathA.length;
			const lB:uint = pathB.length;
			
			var a:uint = 0;
			var validA:uint = 0;
			var biggestB:uint = findBiggestXIndex(pathB);
			
			var vertexB:Vertex = pathB[biggestB];
			var biggestX:Number = vertexB.x;
			
			var currentDistance:Number;
			var smallestDistance:Number = Number.MAX_VALUE;
			
			while (a < lA)
			{
				var vertexA:Vertex = pathA[a];
				if (vertexA.x <= biggestX)
				{
					a++;
					continue;
				}
				
				var AB_x:Number = vertexB.x - vertexA.x;
				var AB_y:Number = vertexB.y - vertexA.y;
				currentDistance = AB_x * AB_x + AB_y * AB_y;
				
				if (!intersectsAllRelevantPaths(vertexA, vertexB, pathA) && currentDistance <= smallestDistance)
				{
					validA = a;
					smallestDistance = currentDistance;
				}
				
				a++;
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
			const vAB_x:Number = vertexB.x - vertexA.x;
			const vAB_y:Number = vertexB.y - vertexA.y;
			
			const vCD_x:Number = vertexD.x - vertexC.x;
			const vCD_y:Number = vertexD.y - vertexC.y;
			
			var s:Number = vertexA.y + vAB_y * (vertexC.x - vertexA.x) / vAB_x - vertexC.y;
			s /= vCD_y - vCD_x * vAB_y / vAB_x;
			
			return s > 0 && s < 1;
		}
	}

}