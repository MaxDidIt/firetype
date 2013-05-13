package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.AGALMiniAssembler;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.renderer.IHardwareTextRenderer;
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
		private var _renderer:IHardwareTextRenderer;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterCache(renderer:IHardwareTextRenderer) 
		{
			this._renderer = renderer;
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get renderer():IHardwareTextRenderer 
		{
			return _renderer;
		}
		
		public function set renderer(value:IHardwareTextRenderer):void 
		{
			_renderer = value;
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
				
				// cache hardware glyph
				hardwareGlyph = _renderer.addPathsToRenderer(paths);
				hardwareGlyph.index = index;
				hardwareGlyph.boundingBox.setValues(glyph.header.xMin, glyph.header.yMin, glyph.header.xMax, glyph.header.yMax);
				
				cachedGlyphsForSubdivision[indexKey] = hardwareGlyph;
			}
			
			return hardwareGlyph;
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
		
		public function render():void 
		{
			_renderer.render(_instanceMap);
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