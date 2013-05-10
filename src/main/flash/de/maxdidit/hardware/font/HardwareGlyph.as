package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
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
		
		public function initialize(paths:Vector.<Vector.<Vertex>>, context3d:Context3D, triangulator:ITriangulator):void
		{
			//var path:Vector.<Vertex> = connectAllPaths(paths);
			
			var indices:Vector.<uint> = new Vector.<uint>(); 
			var vertexData:Vector.<Number> = new Vector.<Number>(); 
			
			const l:uint = paths.length;
			var indexOffset:uint = 0;
			for (var i:uint = 0; i < l; i++)
			{
				var path:Vector.<Vertex> = paths[i];
				
				triangulator.triangulatePath(path, indices, indexOffset);
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
	}

}