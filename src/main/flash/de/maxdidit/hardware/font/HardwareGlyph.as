package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.list.CircularLinkedList;
	import de.maxdidit.list.elements.UnsignedIntegerListElement;
	import de.maxdidit.math.AxisAlignedBoundingBox;
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
		
		private var _vertexOffset:uint;
		private var _indexOffset:uint;
		
		private var _numTriangles:uint;
		
		private var _index:uint;
		
		// bounding box
		
		private var _boundingBox:AxisAlignedBoundingBox;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareGlyph()
		{
			_boundingBox = new AxisAlignedBoundingBox();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// vertexOffset
		
		public function get vertexOffset():uint
		{
			return _vertexOffset;
		}
		
		public function set vertexOffset(value:uint):void
		{
			_vertexOffset = value;
		}
		
		// indexOffset
		
		public function get indexOffset():uint
		{
			return _indexOffset;
		}
		
		public function set indexOffset(value:uint):void
		{
			_indexOffset = value;
		}
		
		// numTriangles
		
		public function get numTriangles():uint
		{
			return _numTriangles;
		}
		
		public function set numTriangles(value:uint):void
		{
			_numTriangles = value;
		}
		
		// bounding box
		
		public function get boundingBox():AxisAlignedBoundingBox
		{
			return _boundingBox;
		}
		
		public function set boundingBox(value:AxisAlignedBoundingBox):void
		{
			_boundingBox = value;
		}
		
		// index
		
		public function get index():uint 
		{
			return _index;
		}
		
		public function set index(value:uint):void 
		{
			_index = value;
		}
	
		///////////////////////
		// Member Functions
		///////////////////////
	
	}

}