/* 
Copyright ©2013 Max Knoblich 
 
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
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.format.TextColor;
	import de.maxdidit.hardware.text.renderer.IHardwareTextRenderer;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareCharacterCacheSection 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _instanceMap:Object = new Object();
		private var _renderer:IHardwareTextRenderer;
		
		///////////////////////
		// Constructor 
		///////////////////////
		
		public function HardwareCharacterCacheSection($renderer:IHardwareTextRenderer) 
		{
			_renderer = $renderer;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
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
		
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, font:HardwareFont, vertexDistance:Number, color:TextColor):void 
		{
			var cachedDensitiesForFonts:Object = retrieveProperty(_instanceMap, font.uniqueIdentifier);
			var cachedColorsForDensity:Object = retrieveProperty(cachedDensitiesForFonts, String(vertexDistance));
			var cachedInstancesForColor:Object = retrieveProperty(cachedColorsForDensity, color.id);
			
			var instances:Vector.<HardwareGlyphInstance>;
			var indexKey:String = String(hardwareGlyphInstance.glyph.header.index);
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
		
		public function addPathsToSection(paths:Vector.<Vector.<Vertex>>):HardwareGlyph
		{
			return _renderer.addPathsToRenderer(paths);
		}
		
		public function render(textColorMap:TextColorMap):void 
		{
			_renderer.render(_instanceMap, textColorMap);
		}
		
		public function clearBufferData():void
		{
			_renderer.clear();
		}
		
		public function clearInstances():void 
		{
			deleteMap(_instanceMap);
		}
		
		private function deleteMap(map:Object):void 
		{
			for (var index:String in map)
			{
				deleteMap(map[index]);
				delete map[index];
			}
		}
		
	}

}