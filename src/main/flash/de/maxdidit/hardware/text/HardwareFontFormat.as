package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.HardwareFont;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontFormat 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _font:HardwareFont;
		private var _scale:Number;
		private var _color:uint;
		private var _subdivisions:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontFormat() 
		{
			
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
		
		// scale
		
		public function get scale():Number 
		{
			return _scale;
		}
		
		public function set scale(value:Number):void 
		{
			_scale = value;
		}
		
		// color
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		// subdivisions
		
		public function get subdivisions():uint 
		{
			return _subdivisions;
		}
		
		public function set subdivisions(value:uint):void 
		{
			_subdivisions = value;
		}
		
		// 
		
	}

}