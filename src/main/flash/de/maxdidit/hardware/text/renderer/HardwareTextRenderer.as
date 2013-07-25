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
		 
		protected var _context3d:Context3D; 
		 
		// shader 
		 
		protected var vertexAssembly:AGALMiniAssembler = new AGALMiniAssembler(); 
		protected var fragmentAssembly:AGALMiniAssembler = new AGALMiniAssembler(); 
		protected var programPair:Program3D; 
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareTextRenderer($context3d:Context3D) 
		{
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
		
		protected function addToVertexData(vertices:Vector.<Vertex>):void 
		{
			throw new Error("addToVertexData has not been implemented yet. Please extend HardwareTextRenderer and implement this function.");
		}
		
		protected function addToIndexData(indices:Vector.<uint>, numVertices:uint, vertexOffset:uint):void 
		{ 
			const l:uint = indices.length; 
			 
			var index:uint = _indexData.length; 
			const newLength:uint = index + l; 
			
			_indexData.length = newLength;
			 
			for (var j:uint = 0; j < l; j++) 
			{ 
				_indexData[index++] = indices[j] + vertexOffset; 
			}
		} 
		
		protected function fitsIntoVertexBuffer(numberOfNewVertices:uint):Boolean 
		{ 
			var vertexBufferSizeInBytes:uint = (_vertexData.length + numberOfNewVertices * fieldsPerVertex * 8); 
			return vertexBufferSizeInBytes <= HardwareTextRenderer.MAX_VERTEXBUFFER_BYTES;
		}
		
		protected function fitsIntoIndexBuffer(numberOfNewIndices:uint):Boolean
		{
			var indexBufferSizeInBytes:uint = (_indexData.length + numberOfNewIndices) * 4;
			return indexBufferSizeInBytes <= HardwareTextRenderer.MAX_INDEXBUFFER_BYTES;
		}
		
		protected function updateBuffers():void
		{
			if (_buffersDirty) 
			{
				_vertexBuffer = _context3d.createVertexBuffer(_vertexData.length / fieldsPerVertex, fieldsPerVertex); 
				_vertexBuffer.uploadFromVector(_vertexData, 0, _vertexData.length / fieldsPerVertex); 
				 
				_indexBuffer = _context3d.createIndexBuffer(_indexData.length); 
				_indexBuffer.uploadFromVector(_indexData, 0, _indexData.length);
				
				//_vertexData.length = 0;
				//_indexData.length = 0;
				
				_buffersDirty = false; 
			}
		}
		
		/* INTERFACE de.maxdidit.hardware.text.renderer.IHardwareTextRenderer */
		
		public function addHardwareGlyph(glyph:HardwareGlyph):Boolean 
		{
			var vertexOffset:uint = _vertexData.length / fieldsPerVertex;
			var indexOffset:uint = _indexData.length;
			
			if (!fitsIntoVertexBuffer(glyph.vertices.length))
			{
				return false;
			}
			
			if (!fitsIntoIndexBuffer(glyph.indices.length))
			{
				return false;
			}
			
			addToIndexData(glyph.indices, glyph.vertices.length, vertexOffset);
			addToVertexData(glyph.vertices);
			
			glyph.vertexOffset = vertexOffset;
			glyph.indexOffset = indexOffset;
			glyph.numTriangles = glyph.indices.length / 3;
			
			_buffersDirty = true;
			
			return true;
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