package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PathConnector 
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PathConnector() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
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
		 
		public function connectPaths(pathA:Vector.<Vertex>, pathB:Vector.<Vertex>):void
		{
			// find shortest distance between vertices 
			const lA:uint = pathA.length; 
			const lB:uint = pathB.length;
			
			if (lA == 0)
			{
				if (lB == 0)
				{
					return;
				}
				
				pathA.length = lB;
				for (var i:uint = 0; i < lB; i++)
				{
					pathA[i] = pathB[i];
				}
				
				return;
			}
			
			if (lB == 0)
			{
				return;
			}
			 
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
			
			var newLength:uint = lA + lB + 2;
			pathA.length = newLength;
			
			var sL:uint = lA - validA;
			
			for (i = 0; i < sL; i++)
			{
				var oldIndex:uint = lA - i - 1;
				var newIndex:uint = newLength - i - 1;
				pathA[newIndex] = pathA[oldIndex];
			}
			 
			 //fill from bridge vertex in B till end
			var index:uint = validA + 1;
			for (i = biggestB; i < lB; i++) 
			{
				pathA[index++] = pathB[i];
			} 
			 
			// fill from beginning to bridge vertex in B 
			for (i = 0; i <= biggestB; i++) 
			{ 
				pathA[index++] = pathB[i];
			}
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