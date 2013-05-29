package de.maxdidit.hardware.text.renderer 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.hardware.text.HardwareGlyphInstance;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class BatchedGlyphRenderer implements IHardwareTextRenderer 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		private const VERTEX_SHADER:String = 	"m44 op, va0, vc[va1.x]";
		private const FRAGMENT_SHADER:String = 	"mov oc, fc0";
		
		private const DRAW_CALLS_PER_BATCH:uint = 128 / 4; // 128 is the maximum of vertex shader registers. A matrix requires 4 registers.
		
		private const FIELDS_PER_VERTEX:uint = 4;
		private const MAX_VERTEXBUFFER_BYTES:uint = (256 << 9) << 9;
		private const MAX_INDEXBUFFER_BYTES:uint = (128 << 9) << 9;
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _vertexData:Vector.<Number> = new Vector.<Number>();
		private var _indexData:Vector.<uint> = new Vector.<uint>();
		
		private var _buffersDirty:Boolean = true;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		
		private var _triangulator:ITriangulator;
		private var _context3d:Context3D;
		
		// shader
		private var vertexAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var fragmentAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var programPair:Program3D;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function BatchedGlyphRenderer($context3d:Context3D, $triangulator:ITriangulator)
		{
			_triangulator = $triangulator;
			_context3d = $context3d;
			
			// init shaders
			vertexAssembly.assemble(Context3DProgramType.VERTEX, VERTEX_SHADER);
			fragmentAssembly.assemble(Context3DProgramType.FRAGMENT, FRAGMENT_SHADER);
			
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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function fitsIntoVertexBuffer(paths:Vector.<Vector.<Vertex>>):Boolean
		{
			var numberOfVertices:uint = 0;
			const l:uint = paths.length;
			for (var i:uint = 0; i < l; i++)
			{
				numberOfVertices += paths[i].length;
			}
			
			var vertexBufferSizeInBytes:uint = (_vertexData.length + numberOfVertices) * FIELDS_PER_VERTEX * 8 * DRAW_CALLS_PER_BATCH;
			return vertexBufferSizeInBytes <= MAX_VERTEXBUFFER_BYTES;
		}
		
		private function fitsIntoIndexBuffer(numberOfNewIndices:uint):Boolean
		{
			var indexBufferSizeInBytes:uint = (_indexData.length + numberOfNewIndices) * 4 * DRAW_CALLS_PER_BATCH;
			return indexBufferSizeInBytes <= MAX_INDEXBUFFER_BYTES;
		}
		
		public function addPathsToRenderer(paths:Vector.<Vector.<Vertex>>):HardwareGlyph
		{
			// test if vertices would fit
			if (!fitsIntoVertexBuffer(paths))
			{
				return null;
			}
			
			// triangulate paths
			var vertexOffset:uint = _vertexData.length / FIELDS_PER_VERTEX;
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
			addToVertexData(paths);
			
			var hardwareGlyph:HardwareGlyph = new HardwareGlyph();
			hardwareGlyph.vertexOffset = vertexOffset;
			hardwareGlyph.indexOffset = indexOffset;
			hardwareGlyph.numTriangles = numTriangles;
			
			_buffersDirty = true;
			
			return hardwareGlyph;
		}
		
		private function addToIndexData(indices:Vector.<uint>, numVertices:uint):void 
		{
			const l:uint = indices.length;
			
			var indexOffset:uint = 0;
			
			for (var i:uint = 0; i < DRAW_CALLS_PER_BATCH; i++)
			{
				for (var j:uint = 0; j < l; j++)
				{
					_indexData.push(indices[j] + indexOffset);
				}
				
				indexOffset += numVertices;
			}
		}
		
		private function addToVertexData(paths:Vector.<Vector.<Vertex>>):void
		{
			const l:uint = paths.length;
			
			for (var b:uint = 0; b < DRAW_CALLS_PER_BATCH; b++)
			{
				for (var p:uint = 0; p < l; p++)
				{
					var path:Vector.<Vertex> = paths[p];
					var pl:uint = path.length;
					
					for (var i:uint = 0; i < pl; i++)
					{
						var vertex:Vertex = path[i];
						_vertexData.push(vertex.x, vertex.y, 0, b * 4);
					}
				}
			}
		}
		
		public function render(instanceMap:Object):void
		{
			if (_buffersDirty)
			{
				_vertexBuffer = _context3d.createVertexBuffer(_vertexData.length / FIELDS_PER_VERTEX, FIELDS_PER_VERTEX);
				_vertexBuffer.uploadFromVector(_vertexData, 0, _vertexData.length / FIELDS_PER_VERTEX);
				
				_indexBuffer = _context3d.createIndexBuffer(_indexData.length);
				_indexBuffer.uploadFromVector(_indexData, 0, _indexData.length);
				
				_buffersDirty = false;
			}
			
			_context3d.setProgram(programPair);
			
			//_context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX, 0, viewProjectionMtx, true );
			var color:Vector.<Number> = new Vector.<Number>();
			color.push(0, 0, 0, 1);
			_context3d.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, color, 1);
			
			_context3d.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context3d.setVertexBufferAt(1, _vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_1);
			for each (var fonts:Object in instanceMap)
			{
				for each (var subdivisions:Object in fonts)
				{
					for each (var colors:Object in subdivisions)
					{
						for each (var instances:Vector.<HardwareGlyphInstance>in colors)
						{
							var l:uint = instances.length;
							var i:uint = 0;
							var b:uint = 0;
							
							while (i < l)
							{
								var currentInstance:HardwareGlyphInstance = instances[i];
								_context3d.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, b * 4, currentInstance.globalTransformation, true);
								
								b++;
								i++;
								
								if (b == DRAW_CALLS_PER_BATCH || i == l)
								{
									_context3d.drawTriangles(_indexBuffer, currentInstance.glyph.indexOffset, currentInstance.glyph.numTriangles * b);
									b = 0;
								}
							}
						}
					}
				}
			}
		}
		
	}

}