package de.maxdidit.hardware.text.renderer 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.hardware.text.cache.TextColorMap;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareTextRenderer implements IHardwareTextRenderer 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const MAX_VERTEXBUFFER_BYTES:uint = (256 << 9) << 9;
		public static const MAX_INDEXBUFFER_BYTES:uint = (128 << 9) << 9;
		
		///////////////////////
		// Member Fields
		/////////////////////// 
		 
		protected var _vertexData:Vector.<Number> = new Vector.<Number>(); 
		protected var _indexData:Vector.<uint> = new Vector.<uint>(); 
		 
		protected var _buffersDirty:Boolean = true; 
		protected var _vertexBuffer:VertexBuffer3D;
		protected var _indexBuffer:IndexBuffer3D; 
		 
		protected var _triangulator:ITriangulator;
		protected var _context3d:Context3D; 
		 
		// shader 
		 
		protected var vertexAssembly:AGALMiniAssembler = new AGALMiniAssembler(); 
		protected var fragmentAssembly:AGALMiniAssembler = new AGALMiniAssembler(); 
		protected var programPair:Program3D; 
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareTextRenderer($context3d:Context3D, $triangulator:ITriangulator) 
		{
			_triangulator = $triangulator; 
			_context3d = $context3d; 
			
			// init shaders 
			vertexAssembly.assemble(Context3DProgramType.VERTEX, vertexShaderCode); 
			fragmentAssembly.assemble(Context3DProgramType.FRAGMENT, fragmentShaderCode); 
			 
			programPair = _context3d.createProgram(); 
			programPair.upload(vertexAssembly.agalcode, fragmentAssembly.agalcode); 
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get triangulator():ITriangulator 
		{ 
			return _triangulator; 
		} 
		 
		public function set triangulator(value:ITriangulator):void 
		{ 
			_triangulator = value; 
		}
		
		protected function get fieldsPerVertex():uint
		{
			throw new Error("fieldsPerVertex has not been implemented yet. Please extend HardwareTextRenderer and implement this property.");
		}
		
		protected function get vertexShaderCode():String
		{
			throw new Error("vertexShaderCode has not been implemented yet. Please extend HardwareTextRenderer and implement this property.");
		}
		
		protected function get fragmentShaderCode():String
		{
			throw new Error("fragmentShaderCode has not been implemented yet. Please extend HardwareTextRenderer and implement this property.");
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		protected function addToVertexData(paths:Vector.<Vector.<Vertex>>, numVertices:uint):void 
		{
			throw new Error("addToVertexData has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
		protected function addToIndexData(indices:Vector.<uint>, numVertices:uint):void
		{
			throw new Error("addToIndexData has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
		protected function fitsIntoVertexBuffer(paths:Vector.<Vector.<Vertex>>):Boolean 
		{ 
			throw new Error("fitsIntoVertexBuffer has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
		protected function fitsIntoIndexBuffer(numberOfNewIndices:uint):Boolean 
		{ 
			throw new Error("fitsIntoIndexBuffer has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
		/* INTERFACE de.maxdidit.hardware.text.renderer.IHardwareTextRenderer */
		
		public function addPathsToRenderer(paths:Vector.<Vector.<Vertex>>):HardwareGlyph
		{
			// test if vertices would fit 
			if (!fitsIntoVertexBuffer(paths))
			{
				return null;
			}
			
			// triangulate paths 
			var vertexOffset:uint = _vertexData.length / fieldsPerVertex;
			var indexOffset:uint = _indexData.length;
			
			var localIndexOffset:uint = 0;
			var numTriangles:uint = 0;
			
			var indices:Vector.<uint> = new Vector.<uint>();
			
			const l:uint = paths.length;
			for (var i:uint = 0; i < l; i++)
			{
				var path:Vector.<Vertex> = paths[i];
				numTriangles += _triangulator.triangulatePath(path, indices, localIndexOffset + vertexOffset);
				
				localIndexOffset += path.length;
			}
			
			if (!fitsIntoIndexBuffer(indices.length))
			{
				return null;
			}
			
			addToIndexData(indices, localIndexOffset);
			addToVertexData(paths, localIndexOffset);
			
			var hardwareGlyph:HardwareGlyph = new HardwareGlyph();
			hardwareGlyph.vertexOffset = vertexOffset;
			hardwareGlyph.indexOffset = indexOffset;
			hardwareGlyph.numTriangles = numTriangles;
			
			_buffersDirty = true;
			
			return hardwareGlyph;
		}
		
		public function render(instanceMap:Object, textColorMap:TextColorMap):void 
		{
			throw new Error("addPathsToRenderer has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
		public function clear():void 
		{
			throw new Error("addPathsToRenderer has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
	}

}