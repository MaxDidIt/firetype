package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.AGALMiniAssembler;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareCharacterCache
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _characterCache:Object = new Object();
		private var _glyphCache:Object = new Object();
		private var _instanceMap:Object = new Object();
		
		private var _vertexData:Vector.<Number> = new Vector.<Number>();
		private var _indexData:Vector.<uint> = new Vector.<uint>();
		
		private var _buffersDirty:Boolean = true;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		
		private var _triangulator:ITriangulator;
		private var _context3d:Context3D;
		
		// shader
		private const VERTEX_SHADER:String = "m44 op, va0, vc0"
		
		private const FRAGMENT_SHADER:String = "mov oc, fc0";
		
		private var vertexAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var fragmentAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var programPair:Program3D;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterCache($context3d:Context3D, $triangulator:ITriangulator) 
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
		
		public function getCachedCharacter(font:HardwareFont, subdivisions:uint, charCode:uint):HardwareCharacter
		{
			var cachedSubdivisionsForFont:Object = retrieveProperty(_characterCache, font.uniqueIdentifier);
			var cachedCharactersForSubdivision:Object = retrieveProperty(cachedSubdivisionsForFont, String(subdivisions));
			
			var character:HardwareCharacter;
			if (cachedCharactersForSubdivision.hasOwnProperty(String(charCode)))
			{
				character = cachedCharactersForSubdivision[String(charCode)];
			}
			else
			{
				character = createHardwareCharacter(font, subdivisions, charCode);
				cachedCharactersForSubdivision[String(charCode)] = character;
			}
			
			return character;
		}
		
		private function createHardwareCharacter(font:HardwareFont, subdivisions:uint, charCode:uint):HardwareCharacter 
		{
			var id:uint = font.getGlyphIndex(charCode);
			var glyph:Glyph = font.retrieveGlyph(id);
			
			var hardwareCharacter:HardwareCharacter = glyph.retrieveHardwareCharacter(font, subdivisions, this);
			
			return hardwareCharacter;
		}
		
		public function getCachedGlyph(font:HardwareFont, subdivisions:uint, index:uint):HardwareGlyph
		{
			var cachedSubdivisionsForFont:Object = retrieveProperty(_glyphCache, font.uniqueIdentifier);
			var cachedGlyphsForSubdivision:Object = retrieveProperty(cachedSubdivisionsForFont, String(subdivisions));
			
			var indexKey:String = String(index);
			
			var hardwareGlyph:HardwareGlyph = new HardwareGlyph();
			if (cachedGlyphsForSubdivision.hasOwnProperty(indexKey))
			{
				hardwareGlyph = cachedGlyphsForSubdivision[indexKey] as HardwareGlyph;
			}
			else
			{
				var glyph:Glyph = font.retrieveGlyph(index);
				var paths:Vector.<Vector.<Vertex>> = glyph.retrievePaths(subdivisions);
				
				var vertexOffset:uint = _vertexData.length / 3;
				var indexOffset:uint = _indexData.length;
				
				var localIndexOffset:uint = 0;
				var numTriangles:uint = 0;
				
				const l:uint = paths.length;
				for (var i:uint = 0; i < l; i++)
				{
					var path:Vector.<Vertex> = paths[i];
					numTriangles += _triangulator.triangulatePath(path, _indexData, localIndexOffset + vertexOffset);
					pushVertexData(path, _vertexData);
					
					localIndexOffset += path.length;
				}
				
				hardwareGlyph = new HardwareGlyph();
				hardwareGlyph.vertexOffset = vertexOffset;
				hardwareGlyph.indexOffset = indexOffset;
				hardwareGlyph.numTriangles = numTriangles;
				
				hardwareGlyph.index = index;
				
				hardwareGlyph.boundingBox.setValues(glyph.header.xMin, glyph.header.yMin, glyph.header.xMax, glyph.header.yMax);
				
				cachedGlyphsForSubdivision[indexKey] = hardwareGlyph;
				
				_buffersDirty = true;
			}
			
			return hardwareGlyph;
		}
		
		public function render():void 
		{
			if (_buffersDirty)
			{
				_vertexBuffer = _context3d.createVertexBuffer(_vertexData.length / 3, 3);
				_vertexBuffer.uploadFromVector(_vertexData, 0, _vertexData.length / 3);
				
				_indexBuffer = _context3d.createIndexBuffer(_indexData.length);
				_indexBuffer.uploadFromVector(_indexData, 0, _indexData.length);
				
				_buffersDirty = false;
			}
			
			_context3d.setProgram(programPair);
			
			//_context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX, 0, viewProjectionMtx, true );
			var color:Vector.<Number> = new Vector.<Number>();
			color.push(0, 0, 0, 1);
			_context3d.setProgramConstantsFromVector( Context3DProgramType.FRAGMENT, 0, color, 1 );
			
			_context3d.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			for each(var fonts:Object in _instanceMap)
			{
				for each(var subdivisions:Object in fonts)
				{
					for each(var colors:Object in subdivisions)
					{
						for each(var instances:Vector.<HardwareGlyphInstance> in colors)
						{
							const l:uint = instances.length;
							for (var i:uint = 0; i < l; i++)
							{
								var currentInstance:HardwareGlyphInstance = instances[i];
								
								_context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX, 0, currentInstance.globalTransformation, true );
								_context3d.drawTriangles(_indexBuffer, currentInstance.glyph.indexOffset, currentInstance.glyph.numTriangles);
							}
						}
					}
				}
			}
		}
		
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, uniqueIdentifier:String, subdivisions:uint, color:uint):void 
		{
			var cachedSubdivisionsForFont:Object = retrieveProperty(_instanceMap, uniqueIdentifier);
			var cachedColorsForSubdivision:Object = retrieveProperty(cachedSubdivisionsForFont, String(subdivisions));
			var cachedInstancesForColor:Object = retrieveProperty(cachedColorsForSubdivision, String(color));
			
			var instances:Vector.<HardwareGlyphInstance>;
			var indexKey:String = String(hardwareGlyphInstance.glyph.index);
			if (cachedInstancesForColor.hasOwnProperty(indexKey))
			{
				instances = cachedInstancesForColor[indexKey] as Vector.<HardwareGlyphInstance>;
			}
			else
			{
				instances = new Vector.<HardwareGlyphInstance>();
				cachedInstancesForColor[indexKey] = instances;
			}
			
			instances.push(hardwareGlyphInstance);
		}
		
		private function pushVertexData(path:Vector.<Vertex>, result:Vector.<Number>):void
		{
			const l:uint = path.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var index:uint = i * 3;
				var vertex:Vertex = path[i];
				
				result.push(vertex.x, vertex.y, 0);
			}
		}
		
		private function retrieveProperty(map:Object, key:String):Object
		{
			if (map.hasOwnProperty(key))
			{
				return map[key];
			}
			else
			{
				var property:Object = new Object();
				map[key] = property;
				return property;
			}
		}
		
	}

}