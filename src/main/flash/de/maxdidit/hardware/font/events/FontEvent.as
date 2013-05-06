package de.maxdidit.hardware.font.events 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FontEvent extends Event 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const FONT_PARSED:String = "fontParsed";
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _font:HardwareFont;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontEvent(type:String, font:HardwareFont, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable)
			this.font = font;
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// font
		
		public function get font():HardwareFont 
		{
			return _font;
		}
		
		public function set font(value:HardwareFont):void 
		{
			_font = value;
		}
		
	}

}