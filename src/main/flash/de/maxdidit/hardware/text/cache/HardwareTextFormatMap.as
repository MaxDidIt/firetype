package de.maxdidit.hardware.text.cache 
{
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareTextFormatMap 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _textFormatMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareTextFormatMap() 
		{
			_textFormatMap = new Object();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addTextFormat(textFormat:HardwareTextFormat):void
		{
			_textFormatMap[textFormat.id] = textFormat;
		}
		
		public function getTextFormatById(id:String):HardwareTextFormat
		{
			return _textFormatMap[id];
		}
		
		public function removeTextFormatByReference(textFormat:HardwareTextFormat):void
		{
			removeTextFormatByTag(textFormat.id);
		}
		
		public function removeTextFormatByTag(id:String):void
		{
			if (_textFormatMap.hasOwnProperty(id))
			{
				delete _textFormatMap[id];
			}
		}
		
		public function hasTextFormat(textFormat:HardwareTextFormat):Boolean
		{
			return hasTextFormatId(textFormat.id);
		}
		
		public function hasTextFormatId(id:String):Boolean
		{
			return _textFormatMap.hasOwnProperty(id);
		}
	}

}