package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.list.CircularLinkedList;
	import de.maxdidit.list.elements.UnsignedIntegerListElement;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareGlyph 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var vertexBuffer:VertexBuffer3D;
		private var indexBuffer:IndexBuffer3D;
		
		private var numTriangles:uint;
		
		private var transform:Matrix3D;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareGlyph() 
		{
			transform = new Matrix3D();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get position():Vector3D
		{
			return transform.position;
		}
		
		public function set position(value:Vector3D):void
		{
			transform.position = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function initialize(paths:Vector.<Vector.<Vertex>>, context3d:Context3D):void
		{
			//var path:Vector.<Vertex> = connectAllPaths(paths);
			
			var indices:Vector.<uint> = new Vector.<uint>(); 
			var vertexData:Vector.<Number> = new Vector.<Number>(); 
			
			const l:uint = paths.length;
			var indexOffset:uint = 0;
			for (var i:uint = 0; i < l; i++)
			{
				var path:Vector.<Vertex> = paths[i];
				
				triangulatePath(path, indices, indexOffset);
				indexOffset += path.length;
				
				createVertexData(path, vertexData);
			}
			
			vertexBuffer = context3d.createVertexBuffer(vertexData.length / 3, 3);
			vertexBuffer.uploadFromVector(vertexData, 0, vertexData.length / 3);
			
			indexBuffer = context3d.createIndexBuffer(indices.length);
			indexBuffer.uploadFromVector(indices, 0, indices.length);
			
			numTriangles = indices.length / 3;
		}
		
		public function render(context3d:Context3D, viewProjection:Matrix3D):void
		{
			var finalTransform:Matrix3D = new Matrix3D();
			finalTransform.append(transform);
			finalTransform.append(viewProjection);
			
			context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX, 0, finalTransform, true );
			context3d.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			context3d.drawTriangles(indexBuffer, 0, numTriangles);
		}
		
		private function createVertexData(path:Vector.<Vertex>, result:Vector.<Number>):void
		{
			const l:uint = path.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var index:uint = i * 3;
				var vertex:Vertex = path[i];
				
				result.push(vertex.x, vertex.y, 0);
			}
		}
		
		private function triangulatePath(path:Vector.<Vertex>, result:Vector.<uint>, indexOffset:uint):void
		{			
			const l:uint = path.length;
			
			// create index array
			var availableIndices:CircularLinkedList = new CircularLinkedList();
			for (var i:uint = 0; i < l; i++)
			{
				availableIndices.addElement(new UnsignedIntegerListElement(i));
			}
			
			// ear clipping algorithm
			
			var currentVertex:Vertex;
			var previousVertex:Vertex;
			var nextVertex:Vertex;
			
			var currentIndex:UnsignedIntegerListElement = availableIndices.firstElement as UnsignedIntegerListElement;
			
			while (availableIndices.numElements >= 3)
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
				
				if (crossProduct <= 0)
				{
					// iterate
					currentIndex = currentIndex.next as UnsignedIntegerListElement;
					
					continue;
				}
				
				if (containsAnyPointFromPath(path, previousVertex, currentVertex, nextVertex, currentIndex.next.next as UnsignedIntegerListElement, currentIndex.previous as UnsignedIntegerListElement))
				{
					// iterate
					currentIndex = currentIndex.next as UnsignedIntegerListElement;
					
					continue;
				}
				
				// add triangle to result
				result.push((currentIndex.previous as UnsignedIntegerListElement).value + indexOffset);
				result.push(currentIndex.value + indexOffset);
				result.push((currentIndex.next as UnsignedIntegerListElement).value + indexOffset);
				
				// remove current index
				availableIndices.removeElement(currentIndex);
				
				currentIndex = availableIndices.firstElement as UnsignedIntegerListElement;
			}
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
			
			const v0_x:Number = vertexC.x - vertexA.x;
			const v0_y:Number = vertexC.y - vertexA.y;
			
			const v1_x:Number = vertexB.x - vertexA.x;
			const v1_y:Number = vertexB.y - vertexA.y;
			
			const v2_x:Number = currentVertex.x - vertexA.x;
			const v2_y:Number = currentVertex.y - vertexA.y;
			
			const dot00:Number = v0_x * v0_x + v0_y * v0_y;
			const dot01:Number = v0_x * v1_x + v0_y * v1_y;
			const dot02:Number = v0_x * v2_x + v0_y * v2_y;
			const dot11:Number = v1_x * v1_x + v1_y * v1_y;
			const dot12:Number = v1_x * v2_x + v1_y * v2_y;
			
			const inverseDenominator:Number = 1 / (dot00 * dot11 - dot01 * dot01);
			const u:Number = inverseDenominator * (dot11 * dot02 - dot01 * dot12);
			const v:Number = inverseDenominator * (dot00 * dot12 - dot01 * dot02);
			
			return (u > 0) && (v > 0) && (u + v < 1);
		}
	}

}