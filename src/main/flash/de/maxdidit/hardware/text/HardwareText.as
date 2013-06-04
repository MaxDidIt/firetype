package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
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
		
		private var _textDirty:Boolean;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareText(cache:HardwareCharacterCache) 
		{
			this._cache = cache;
			this._cache.addClient(this);
			
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
			if (_cache != value)
			{
				if (_cache)
				{
					_cache.removeClient(this);
				}
				
				_cache = value;
				
				if (_cache)
				{
					_cache.addClient(this);
				}
			}
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			if (_text != value)
			{
				_text = value;
				_textDirty = true;
			}
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
			
			_typesetter.assemble(this, cache);
		}
		
		override public function loseAllChildren():void 
		{
			// clean up instances
			//const l:uint = _children.length;
			//for (var i:uint = 0; i < l; i++)
			//{
				//var word:HardwareWord = _children[i] as HardwareWord;
			//}
			
			super.loseAllChildren();
		}
		
		public function update():void 
		{
			if (_textDirty)
			{
				_cache.clearInstanceCache(); // TODO: will cause problems if multiple texts use the same cache.
				parseText();
				calculateTransformations();
				_textDirty = false;
			}
		}
		
	}

}