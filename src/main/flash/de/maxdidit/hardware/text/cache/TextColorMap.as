package de.maxdidit.hardware.text.cache 
{
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.format.TextColor;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TextColorMap 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _textColorMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TextColorMap() 
		{
			_textColorMap = new Object();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addTextColor(textColor:TextColor):void
		{
			_textColorMap[textColor.id] = textColor;
		}
		
		public function getTextColorById(id:String):TextColor
		{
			return _textColorMap[id];
		}
		
		public function removeTextColorByReference(textFormat:TextColor):void
		{
			removeTextColorByTag(textFormat.id);
		}
		
		public function removeTextColorByTag(id:String):void
		{
			if (_textColorMap.hasOwnProperty(id))
			{
				delete _textColorMap[id];
			}
		}
		
		public function hasTextColor(textColor:TextColor):Boolean
		{
			return hasTextColorId(textColor.id);
		}
		
		public function hasTextColorId(id:String):Boolean
		{
			return _textColorMap.hasOwnProperty(id);
		}
	}

}