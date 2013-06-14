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
		
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, font:HardwareFont, vertexDensity:Number, color:TextColor):void 
		{
			var cachedDensitiesForFonts:Object = retrieveProperty(_instanceMap, font.uniqueIdentifier);
			var cachedColorsForDensity:Object = retrieveProperty(cachedDensitiesForFonts, String(vertexDensity));
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