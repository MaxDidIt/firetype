package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageTag;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTag;
	import de.maxdidit.hardware.font.HardwareFont;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareTextFormat 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _font:HardwareFont;
		private var _scale:Number = 1;
		private var _color:uint = 0x0;
		private var _subdivisions:uint = 1;
		
		private var _scriptTag:String = ScriptTag.LATIN;
		private var _languageTag:String = LanguageTag.ENGLISH;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareTextFormat() 
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
		
		// scriptTag
		
		public function get scriptTag():String 
		{
			return _scriptTag;
		}
		
		public function set scriptTag(value:String):void 
		{
			_scriptTag = value;
		}
		
		// languageTag
		
		public function get languageTag():String 
		{
			return _languageTag;
		}
		
		public function set languageTag(value:String):void 
		{
			_languageTag = value;
		}
		
		// 
		
	}

}