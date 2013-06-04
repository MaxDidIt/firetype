package de.maxdidit.hardware.text.components 
{
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TextSpan 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _textFormat:HardwareTextFormat;
		private var _characterInstances:LinkedList;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TextSpan() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get textFormat():HardwareTextFormat 
		{
			return _textFormat;
		}
		
		public function set textFormat(value:HardwareTextFormat):void 
		{
			_textFormat = value;
		}
		
		public function get characterInstances():LinkedList 
		{
			return _characterInstances;
		}
		
		public function set characterInstances(value:LinkedList):void 
		{
			_characterInstances = value;
		}
		
	}

}