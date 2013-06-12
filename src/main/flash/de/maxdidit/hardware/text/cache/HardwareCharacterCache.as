package de.maxdidit.hardware.text.cache 
{
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.format.TextColor;
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
		private var _textColorMap:TextColorMap;
		private var _fontMap:HardwareFontMap;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterCache(rendererFactory:IHardwareTextRendererFactory) 
		{
			_rendererFactory = rendererFactory;
			
			_sections = new Vector.<HardwareCharacterCacheSection>();
			
			_clientTexts = new Vector.<HardwareText>();
			
			_textFormatMap = new HardwareTextFormatMap();
			_textColorMap = new TextColorMap();
			_fontMap = new HardwareFontMap();
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
		
		public function get textColorMap():TextColorMap 
		{
			return _textColorMap;
		}
		
		public function get fontMap():HardwareFontMap 
		{
			return _fontMap;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
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
		
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, font:HardwareFont, vertexDensity:Number, color:TextColor):void 
		{
			var section:HardwareCharacterCacheSection = _sections[hardwareGlyphInstance.hardwareGlyph.cacheSectionIndex];
			section.registerGlyphInstance(hardwareGlyphInstance, font, vertexDensity, color);
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
				section.render(_textColorMap);
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
			
			dirtyAllClientTexts();
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
		
		public function getCachedHardwareGlyph(uniqueIdentifier:String, subdivisions:uint, index:uint):HardwareGlyph
		{
			if (!_glyphCache.hasOwnProperty(uniqueIdentifier))
			{
				return null;
			}
			
			var subdivisionsForFont:Object = _glyphCache[uniqueIdentifier];
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
		
		public function addPathsAsHardwareGlyph(paths:Vector.<Vector.<Vertex>>, font:HardwareFont, vertexDensity:uint, glyphID:uint):HardwareGlyph 
		{
			const l:uint = _sections.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var glyph:HardwareGlyph = _sections[i].addPathsToSection(paths);
				if (glyph)
				{
					// cache glyph
					glyph.cacheSectionIndex = i;
					addHardwareGlyphToCache(glyph, font, vertexDensity, glyphID);
					return glyph;
				}
			}
			
			// glyph did not fit in any existing section, create new section
			var section:HardwareCharacterCacheSection = new HardwareCharacterCacheSection(_rendererFactory.retrieveHardwareTextRenderer());
			
			glyph = section.addPathsToSection(paths);
			glyph.cacheSectionIndex = _sections.length;
			addHardwareGlyphToCache(glyph, font, vertexDensity, glyphID);
			
			_sections.push(section);
			
			return glyph;
		}
		
		public function clearHardwareGlyphCache():void 
		{
			_glyphCache = new Object();
			
			const l:uint = _sections.length;
			for (var i:uint = 0; i < l; i++)
			{
				_sections[i].clear();
			}
			
			dirtyAllClientTexts();
		}
		
		private function dirtyAllClientTexts():void
		{
			const l:uint = _clientTexts.length;
			for (var i:uint = 0; i < l; i++)
			{
				_clientTexts[i].dirty();
			}
		}
		
		private function addHardwareGlyphToCache(glyph:HardwareGlyph, font:HardwareFont, vertexDensity:uint, glyphID:uint):void 
		{
			var subdivisionsInFont:Object = retrieveProperty(_glyphCache, font.uniqueIdentifier);
			var glyphsInSubdivisions:Object = retrieveProperty(subdivisionsInFont, String(vertexDensity));
			
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