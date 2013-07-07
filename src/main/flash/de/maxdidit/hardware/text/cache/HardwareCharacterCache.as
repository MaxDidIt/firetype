/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.text.cache  
{ 
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance; 
	import de.maxdidit.hardware.text.format.HardwareTextFormat; 
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance; 
	import de.maxdidit.hardware.text.format.TextColor; 
	import de.maxdidit.hardware.text.glyphbuilders.IGlyphBuilder;
	import de.maxdidit.hardware.text.glyphbuilders.SimpleGlyphBuilder;
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
		
		private var _glyphBuilder:IGlyphBuilder;
		 
		private var _clientTexts:Vector.<HardwareText>; 
		 
		private var _textFormatMap:HardwareTextFormatMap;
		private var _textColorMap:TextColorMap; 
		private var _fontMap:HardwareFontMap; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function HardwareCharacterCache(rendererFactory:IHardwareTextRendererFactory, glyphBuilder:IGlyphBuilder = null)  
		{ 
			_rendererFactory = rendererFactory; 
			
			_glyphBuilder = glyphBuilder;
			if (!_glyphBuilder)
			{
				_glyphBuilder = new SimpleGlyphBuilder(new EarClippingTriangulator());
			}
			 
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
		 
		private function addPathsToSection(paths:Vector.<Vector.<Vertex>>, originalPaths:Vector.<Vector.<Vertex>>):HardwareGlyph  
		{ 
			var result:HardwareGlyph; 
			var section:HardwareCharacterCacheSection; 
			
			// create hardware glyph
			result = _glyphBuilder.buildGlyph(paths, originalPaths);
			
			// insert into section 
			const l:uint = _sections.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				section = _sections[i]; 
				
				if (section.addHardwareGlyph(result)) 
				{ 
					result.cacheSectionIndex = i; 
					return result; 
				} 
			} 
			 
			section = new HardwareCharacterCacheSection(_rendererFactory.retrieveHardwareTextRenderer()); 
			_sections.push(section); 
			 
			if (section.addHardwareGlyph(result))
			{
				result.cacheSectionIndex = l; 
			}
			else
			{
				throw new Error("Can't render glyph. Glyph polygon data does not fit into buffers. Try increasing the vertex distance.");
			}
			 
			return result; 
		} 
		 
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, font:HardwareFont, vertexDistance:Number, color:TextColor):void  
		{ 
			var section:HardwareCharacterCacheSection = _sections[hardwareGlyphInstance.hardwareGlyph.cacheSectionIndex]; 
			section.registerGlyphInstance(hardwareGlyphInstance, font, vertexDistance, color); 
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
				section.clearInstances(); 
			} 
			 
			flagAllClientTextsForUpdate(); 
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
		 
		public function addPathsAsHardwareGlyph(paths:Vector.<Vector.<Vertex>>, originalPaths:Vector.<Vector.<Vertex>>, font:HardwareFont, vertexDistance:Number, glyphID:int):HardwareGlyph  
		{ 
			var glyph:HardwareGlyph = addPathsToSection(paths, originalPaths);
			addHardwareGlyphToCache(glyph, font, vertexDistance, glyphID);
			 
			return glyph; 
		} 
		 
		public function clearHardwareGlyphCache():void  
		{ 
			_glyphCache = new Object(); 
			 
			const l:uint = _sections.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				_sections[i].clearBufferData(); 
			} 
			 
			flagAllClientTextsForUpdate(); 
		} 
		 
		private function flagAllClientTextsForUpdate():void 
		{ 
			const l:uint = _clientTexts.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				_clientTexts[i].flagForUpdate(); 
			} 
		} 
		 
		private function addHardwareGlyphToCache(glyph:HardwareGlyph, font:HardwareFont, vertexDistance:uint, glyphID:uint):void  
		{ 
			var subdivisionsInFont:Object = retrieveProperty(_glyphCache, font.uniqueIdentifier); 
			var glyphsInSubdivisions:Object = retrieveProperty(subdivisionsInFont, String(vertexDistance)); 
			 
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
