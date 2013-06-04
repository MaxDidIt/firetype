package de.maxdidit.hardware.text.cache 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.HardwareGlyphInstance;
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
		
		public function registerGlyphInstance(hardwareGlyphInstance:HardwareGlyphInstance, uniqueIdentifier:String, subdivisions:uint, textFormat:HardwareTextFormat):void 
		{
			var cachedSubdivisionsForFont:Object = retrieveProperty(_instanceMap, uniqueIdentifier);
			var cachedFormatsForSubdivision:Object = retrieveProperty(cachedSubdivisionsForFont, String(subdivisions));
			var cachedInstancesForFormat:Object = retrieveProperty(cachedFormatsForSubdivision, textFormat.id);
			
			var instances:Vector.<HardwareGlyphInstance>;
			var indexKey:String = String(hardwareGlyphInstance.glyph.index);
			if (cachedInstancesForFormat.hasOwnProperty(indexKey))
			{
				instances = cachedInstancesForFormat[indexKey] as Vector.<HardwareGlyphInstance>;
			}
			else
			{
				instances = new Vector.<HardwareGlyphInstance>();
				cachedInstancesForFormat[indexKey] = instances;
			}
			
			instances.push(hardwareGlyphInstance);
		}
		
		public function addPathsToSection(paths:Vector.<Vector.<Vertex>>):HardwareGlyph
		{
			return _renderer.addPathsToRenderer(paths);
		}
		
		public function render(textFormatMap:HardwareTextFormatMap):void 
		{
			_renderer.render(_instanceMap, textFormatMap);
		}
		
		public function clear():void 
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