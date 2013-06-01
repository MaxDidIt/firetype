package de.maxdidit.hardware.text.format 
{
	import de.maxdidit.list.LinkedListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareTextFormatListElement extends LinkedListElement 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _textFormat:HardwareTextFormat;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareTextFormatListElement($textFormat:HardwareTextFormat) 
		{
			this._textFormat = $textFormat;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get hardwareTextFormat():HardwareTextFormat 
		{
			return _textFormat;
		}
		
		public function set hardwareTextFormat(value:HardwareTextFormat):void 
		{
			_textFormat = value;
		}
		
	}

}