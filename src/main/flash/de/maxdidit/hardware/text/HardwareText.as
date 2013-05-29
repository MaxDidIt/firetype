package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareText extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _typesetter:Typesetter;
		private var _cache:HardwareCharacterCache;
		private var _text:String;
		
		private var _fixedWidth:Boolean;
		private var _width:Number;
		private var _height:Number;
		
		private var _standardFormat:HardwareTextFormat;
		private var _standardScript:String;
		private var _standardLanguage:String;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareText(cache:HardwareCharacterCache) 
		{
			this._cache = cache;
			this._typesetter = new Typesetter();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get cache():HardwareCharacterCache 
		{
			return _cache;
		}
		
		public function set cache(value:HardwareCharacterCache):void 
		{
			_cache = value;
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			
			_cache.clearInstanceCache(); // gotta watch 
			parseText();
			calculateTransformations();
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
			_fixedWidth = true;
		}
		
		// standardFormat
		
		public function get standardFormat():HardwareTextFormat 
		{
			return _standardFormat;
		}
		
		public function set standardFormat(value:HardwareTextFormat):void 
		{
			_standardFormat = value;
		}
		
		public function get standardScript():String 
		{
			return _standardScript;
		}
		
		public function set standardScript(value:String):void 
		{
			_standardScript = value;
		}
		
		public function get standardLanguage():String 
		{
			return _standardLanguage;
		}
		
		public function set standardLanguage(value:String):void 
		{
			_standardLanguage = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function registerFont(font:HardwareFont):void
		{
			throw new Error("Function not yet implemented.");
		}
		
		private function parseText():void 
		{
			loseAllChildren();
			
			_typesetter.assemble(_text, this, _standardFormat, _cache);
		}
		
		override public function loseAllChildren():void 
		{
			// clean up instances
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				var word:HardwareWord = _children[i] as HardwareWord;
				word.loseCharacters();
			}
			
			super.loseAllChildren();
		}
		
	}

}