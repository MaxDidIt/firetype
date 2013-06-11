package de.maxdidit.hardware.text.cache 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.format.TextColor;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontMap 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _fontMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontMap() 
		{
			_fontMap = new Object();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addFont(font:HardwareFont):void
		{
			_fontMap[font.uniqueIdentifier] = font;
		}
		
		public function getFontById(uniqueIdentifier:String):HardwareFont
		{
			return _fontMap[uniqueIdentifier];
		}
		
		public function removeFontByReference(font:HardwareFont):void
		{
			removeFontByTag(font.uniqueIdentifier);
		}
		
		public function removeFontByTag(id:String):void
		{
			if (_fontMap.hasOwnProperty(id))
			{
				delete _fontMap[id];
			}
		}
		
		public function hasFont(textColor:HardwareFont):Boolean
		{
			return hasFontId(textColor.uniqueIdentifier);
		}
		
		public function hasFontId(uniqueIdentifier:String):Boolean
		{
			return _fontMap.hasOwnProperty(uniqueIdentifier);
		}
	}

}