package de.maxdidit.hardware.text.format 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TextColor 
	{
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _id:String;
		private var _color:Vector.<Number>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TextColor(id:String = null, color:uint = 0x0) 
		{
			_id = id;
			_color = new Vector.<Number>(4, true);
			this.color = color;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get id():String 
		{
			if (!_id)
			{
				return "0x" + color.toString(16);
			}
			
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get color():uint
		{
			var colorUInt:uint = 0x0;
			
			colorUInt += uint(_color[3] * 255) << 24; // alpha
			colorUInt += uint(_color[0] * 255) << 16; // red
			colorUInt += uint(_color[1] * 255) << 8; // green
			colorUInt += uint(_color[2] * 255); // blue
			
			return colorUInt;
		}
		
		public function set color(value:uint):void
		{
			_color[2] = Number(value & 0xFF) / 255; // red
			_color[1] = Number((value >> 8) & 0xFF) / 255; // green
			_color[0] = Number((value >> 16) & 0xFF) / 255; // blue
			_color[3] = Number((value >> 24) & 0xFF) / 255; // alpha
		}
		
		public function get colorVector():Vector.<Number>
		{
			return _color;
		}
	}

}