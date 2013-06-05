package de.maxdidit.hardware.text.cache 
{
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.text.renderer.AGALMiniAssembler;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.renderer.IHardwareTextRenderer;
	import de.maxdidit.hardware.text.renderer.IHardwareTextRendererFactory;
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
		
		//private var _characterCache:Object = new Object();
		private var _glyphCache:Object = new Object();
		
		private var _rendererFactory:IHardwareTextRendererFactory;
		private var _sections:Vector.<HardwareCharacterCacheSection>;
		
		private var _clientTexts:Vector.<HardwareText>;
		
		private var _textFormatMap:HardwareTextFormatMap;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterCache(rendererFactory:IHardwareTextRendererFactory) 
		{
			_rendererFactory = rendererFactory;
			
			_sections = new Vector.<HardwareCharacterCacheSection>();
			
			_clientTexts = new Vector.<HardwareText>();
			
			_textFormatMap = new HardwareTextFormatMap();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get rendererFactory():IHardwareTextRendererFactory 
		{
			return _rendererFactory;
		}
		
		public function set rendererFactory(value:IHardwareTextRendererFactory):void 
		{
			_rendererFactory = value;
		}
		
		public function get textFormatMap():HardwareTextFormatMap 
		{
			return _textFormatMap;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		//public function getCachedCharacter(font:HardwareFont, subdivisions:uint, glyphID:uint):HardwareCharacter
		//{
			//var cachedSubdivisionsForFont:Object = retrieveProperty(_characterCache, font.uniqueIdentifier);
			//var cachedCharactersForSubdivision:Object = retrieveProperty(cachedSubdivisionsForFont, String(subdivisions));
			//
			//var character:HardwareCharacter;
			//if (cachedCharactersForSubdivision.hasOwnProperty(String(glyphID)))
			//{
				//character = cachedCharactersForSubdivision[String(glyphID)];
			//}
			//else
			//{
				//character = createHardwareCharacter(font, subdivisions, glyphID);
				//cachedCharactersForSubdivision[String(glyphID)] = character;
			//}
			//
			//return character;
		//}
		
		//private function createHardwareCharacter(font:HardwareFont, subdivisions:uint, glyphID:uint):HardwareCharacter 
		//{
			//var glyph:Glyph = font.retrieveGlyph(glyphID);
			//
			//if (!glyph.header.hasContour)
			//{
				//return null;
			//}
			//
			//var hardwareCharacter:HardwareCharacter = glyph.retrieveHardwareCharacter(font, subdivisions, this);
			//
			//return hardwareCharacter;
		//}
		
		//public function getCachedGlyph(font:HardwareFont, subdivisions:uint, glyphIndex:uint):HardwareGlyph
		//{
			//var cachedSubdivisionsForFont:Object = retrieveProperty(_glyphCache, font.uniqueIdentifier);
			//var cachedGlyphsForSubdivision:Object = retrieveProperty(cachedSubdivisionsForFont, String(subdivisions));
			//
			//var indexKey:String = String(glyphIndex);
			//
			//var hardwareGlyph:HardwareGlyph = new HardwareGlyph();
			//if (cachedGlyphsForSubdivision.hasOwnProperty(indexKey))
			//{
				//hardwareGlyph = cachedGlyphsForSubdivision[indexKey] as HardwareGlyph;
			//}
			//else
			//{
				//var glyph:Glyph = font.retrieveGlyph(glyphIndex);
				//var paths:Vector.<Vector.<Vertex>> = glyph.retrievePaths(subdivisions);
				//
				// cache hardware glyph
				//if (paths)
				//{
					//hardwareGlyph = addPathsToSection(paths);
				//}
				//else
				//{
					//hardwareGlyph = new HardwareGlyph();
				//}
				//
				//hardwareGlyph.glyphIndex = glyphIndex;
				//hardwareGlyph.glyph = glyph;
				//hardwareGlyph.boundingBox.setValues(glyph.header.xMin, glyph.header.yMin, glyph.header.xMax, glyph.header.yMax);
				//
				//cachedGlyphsForSubdivision[indexKey] = hardwareGlyph;
			//}
			//
			//return hardwareGlyph;
		//}
		
		private function addPathsToSection(paths:Vector.<Vector.<Vertex>>):HardwareGlyph 
		{
			var result:HardwareGlyph;
			var section:HardwareCharacterCacheSection;
			
			const l:uint = _sections.length;
			for (var i:uint = 0; i < l; i++)
			{
				section = _sections[i];
				
				result = section.addPathsToSection(paths);
				if (result)
				{
					result.cacheSectionIndex = i;
					return result;
				}
			}
			
			section = new HardwareCharacterCacheSection(_rendererFactory.retrieveHardwareTextRenderer());
			_sections.push(section);
			
			result = section.addPathsToSection(paths);
			result.cacheSectionIndex = l;
			
			return result;
		}
		
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, uniqueIdentifier:String, subdivisions:uint, textFormat:HardwareTextFormat):void 
		{
			var section:HardwareCharacterCacheSection = _sections[hardwareGlyphInstance.hardwareGlyph.cacheSectionIndex];
			section.registerGlyphInstance(hardwareGlyphInstance, uniqueIdentifier, subdivisions, textFormat);
		}
		
		public function render():void 
		{
			const cl:uint = _clientTexts.length;
			for (var i:uint = 0; i < cl; i++)
			{
				_clientTexts[i].update();
			}
			
			const l:uint = _sections.length;
			for (i = 0; i < l; i++)
			{
				var section:HardwareCharacterCacheSection = _sections[i];
				section.render(_textFormatMap);
			}
		}
		
		public function clearInstanceCache():void 
		{
			const l:uint = _sections.length;
			for (var i:uint = 0; i < l; i++)
			{
				var section:HardwareCharacterCacheSection = _sections[i];
				section.clear();
			}
		}
		
		public function addClient(hardwareText:HardwareText):void 
		{
			_clientTexts.push(hardwareText);
		}
		
		public function removeClient(hardwareText:HardwareText):void
		{
			var index:int = _clientTexts.indexOf(hardwareText);
			if (index == -1)
			{
				return;
			}
			
			_clientTexts.splice(index, 1);
		}
		
		public function getCachedHardwareGlyph(font:HardwareFont, subdivisions:uint, index:uint):HardwareGlyph 
		{
			if (!_glyphCache.hasOwnProperty(font.uniqueIdentifier))
			{
				return null;
			}
			
			var subdivisionsForFont:Object = _glyphCache[font.uniqueIdentifier];
			if (!subdivisionsForFont.hasOwnProperty(String(subdivisions)))
			{
				return null;
			}
			
			var glyphsForSubdivision:Object = subdivisionsForFont[String(subdivisions)];
			if (!glyphsForSubdivision.hasOwnProperty(String(index)))
			{
				return null;
			}
			
			var hardwareGlyph:HardwareGlyph = glyphsForSubdivision[String(index)];
			return hardwareGlyph;
		}
		
		public function addPathsAsHardwareGlyph(paths:Vector.<Vector.<Vertex>>, font:HardwareFont, subdivisions:uint, glyphID:uint):HardwareGlyph 
		{
			const l:uint = _sections.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var glyph:HardwareGlyph = _sections[i].addPathsToSection(paths);
				if (glyph)
				{
					// cache glyph
					glyph.cacheSectionIndex = i;
					addHardwareGlyphToCache(glyph, font, subdivisions, glyphID);
					return glyph;
				}
			}
			
			// glyph did not fit in any existing section, create new section
			var section:HardwareCharacterCacheSection = new HardwareCharacterCacheSection(_rendererFactory.retrieveHardwareTextRenderer());
			
			glyph = section.addPathsToSection(paths);
			glyph.cacheSectionIndex = _sections.length;
			addHardwareGlyphToCache(glyph, font, subdivisions, glyphID);
			
			_sections.push(section);
			
			return glyph;
		}
		
		private function addHardwareGlyphToCache(glyph:HardwareGlyph, font:HardwareFont, subdivisions:uint, glyphID:uint):void 
		{
			var subdivisionsInFont:Object = retrieveProperty(_glyphCache, font.uniqueIdentifier);
			var glyphsInSubdivisions:Object = retrieveProperty(subdivisionsInFont, String(subdivisions));
			
			glyphsInSubdivisions[String(glyphID)] = glyph;
		}
		
		private function retrieveProperty(map:Object, key:String):Object
		{
			var result:Object = map[key];
			
			if (result)
			{
				return result;
			}
			
			result = new Object();
			map[key] = result;
			return result;
		}
		
	}

}