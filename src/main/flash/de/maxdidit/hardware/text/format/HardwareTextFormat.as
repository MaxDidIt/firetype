package de.maxdidit.hardware.text.format
{
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag;
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
		private var _colorVector:Vector.<Number>;
		
		private var _subdivisions:uint = 1;
		
		private var _scriptTag:String = ScriptTag.LATIN;
		private var _languageTag:String = LanguageTag.ENGLISH;
		
		private var _script:String;
		private var _language:String;
		private var _features:HardwareFontFeatures;
		
		private var _id:String;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareTextFormat()
		{
			_colorVector = new Vector.<Number>(4);
			
			_features = new HardwareFontFeatures();
			
			// default features
			_features.addFeature(FeatureTag.KERNING);
			_features.addFeature(FeatureTag.GLYPH_COMPOSITION_DECOMPOSITION);
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
			
			var alpha:uint = (_color >> 24) & 0xFF;
			var red:uint = (_color >> 16) & 0xFF;
			var green:uint = (_color >> 8) & 0xFF;
			var blue:uint = _color & 0xFF;
			
			_colorVector[0] = Number(red) / 255;
			_colorVector[1] = Number(green) / 255;
			_colorVector[2] = Number(blue) / 255;
			_colorVector[3] = Number(alpha) / 255;
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
		
		// features
		
		public function get features():HardwareFontFeatures 
		{
			return _features;
		}
		
		public function get script():String 
		{
			return _script;
		}
		
		public function set script(value:String):void 
		{
			_script = value;
		}
		
		public function get language():String 
		{
			return _language;
		}
		
		public function set language(value:String):void 
		{
			_language = value;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get colorVector():Vector.<Number> 
		{
			return _colorVector;
		}
	
		///////////////////////
		// Member Functions
		///////////////////////
	}

}