package de.maxdidit.hardware.text.starling
{
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.format.HardwareFontFeatures;
	import de.maxdidit.hardware.text.format.TextAlign;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRendererFactory;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRendererFactory;
	import flash.display3D.Context3DVertexBufferFormat;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeStarlingTextField extends DisplayObjectContainer
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _text:String;
		private var _hardwareText:HardwareText;
		
		private var _color:uint = 0xFF000000; // standard color
		private var _textAlign:uint = TextAlign.LEFT;
		private var _textScale:Number = 1;
		private var _textSkewX:Number = 0;
		private var _textSkewY:Number = 0;
		private var _font:HardwareFont;
		private var _features:HardwareFontFeatures;
		private var _vertexDistance:Number;
		
		private var _usedForLongTexts:Boolean;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeStarlingTextField(usedForLongTexts:Boolean = false)
		{
			this._usedForLongTexts = usedForLongTexts;
			
			Starling.current.addEventListener(Event.CONTEXT3D_CREATE, handleContext3DCreated);
			
			if (Starling.current.context)
			{
				var cache:HardwareCharacterCache = new HardwareCharacterCache(_usedForLongTexts ? //
					new BatchedGlyphRendererFactory(Starling.current.context) : //
					new SingleGlyphRendererFactory(Starling.current.context));
				
				_hardwareText = new HardwareText(Starling.current.context, cache);
				_hardwareText.scaleX = 0.025;
				_hardwareText.scaleY = -0.025;
				_hardwareText.standardFormat.color = _color;
			}
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		override public function get height():Number 
		{
			if (!_hardwareText)
			{
				return 0;
			}
			
			return _hardwareText.height * _hardwareText.scaleY;
		}
		
		override public function set height(value:Number):void 
		{
			//super.height = value;
		}
		
		override public function set width(value:Number):void
		{
			if (value != super.width)
			{
				super.width = value;
				
				if (_hardwareText)
				{
					_hardwareText.width = value;
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
				
				if (!_hardwareText)
				{
					return;
				}
				
				_hardwareText.text = _text;
			}
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			if (value != _color)
			{
				_color = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.color = _color;
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		public function get textAlign():uint
		{
			return _textAlign;
		}
		
		public function set textAlign(value:uint):void
		{
			if (_textAlign != value)
			{
				_textAlign = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.textAlign = _textAlign;
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		public function get textScale():Number
		{
			return _textScale;
		}
		
		public function set textScale(value:Number):void
		{
			if (_textScale != value)
			{
				_textScale = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.scale = _textScale;
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		public function get textSkewX():Number
		{
			return _textSkewX;
		}
		
		public function set textSkewX(value:Number):void
		{
			if (_textSkewX != value)
			{
				_textSkewX = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.shearX = _textSkewX;
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		public function get textSkewY():Number
		{
			return _textSkewX;
		}
		
		public function set textSkewY(value:Number):void
		{
			if (_textSkewY != value)
			{
				_textSkewY = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.shearY = _textSkewY;
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		public function get font():HardwareFont
		{
			return _font;
		}
		
		public function set font(value:HardwareFont):void
		{
			if (_font != value)
			{
				_font = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.font = _font;
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		public function get features():HardwareFontFeatures
		{
			if (!_hardwareText)
			{
				return null;
			}
			
			return _hardwareText.standardFormat.features;
		}
		
		public function get usedForLongTexts():Boolean
		{
			return _usedForLongTexts;
		}
		
		public function set usedForLongTexts(value:Boolean):void
		{
			if (_usedForLongTexts != value)
			{
				_usedForLongTexts = value;
				
				var cache:HardwareCharacterCache = new HardwareCharacterCache(_usedForLongTexts ? //
					new BatchedGlyphRendererFactory(Starling.current.context) : //
					new SingleGlyphRendererFactory(Starling.current.context));
				
				_hardwareText.cache = cache;
				_hardwareText.flagForUpdate();
			}
		}
		
		public function get vertexDistance():Number
		{
			return _vertexDistance;
		}
		
		public function set vertexDistance(value:Number):void
		{
			if (_vertexDistance != value)
			{
				_vertexDistance = value;
				
				if (_hardwareText)
				{
					_hardwareText.standardFormat.vertexDistance = _vertexDistance;
					_hardwareText.cache.clearHardwareGlyphCache();
					_hardwareText.flagForUpdate();
				}
			}
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (_hardwareText)
			{
				support.finishQuadBatch();
				
				_hardwareText.calculateTransformations(support.mvpMatrix3D, true);
				_hardwareText.cache.render();
				
				// Reset vertex buffers
				Starling.current.context.setVertexBufferAt(0, null);
				Starling.current.context.setVertexBufferAt(1, null);
			}
			
			super.render(support, parentAlpha);
		}
		
		///////////////////////
		// Event Handler
		///////////////////////
		
		private function handleContext3DCreated(e:Event):void
		{
			if (_hardwareText.cache)
			{
				_hardwareText.cache.clearHardwareGlyphCache();
				_hardwareText.cache.clearInstanceCache();
			}
			
			var cache:HardwareCharacterCache = new HardwareCharacterCache(_usedForLongTexts ? //
				new BatchedGlyphRendererFactory(Starling.current.context) : //
				new SingleGlyphRendererFactory(Starling.current.context));
			
			_hardwareText = new HardwareText(Starling.current.context, cache);
			_hardwareText.scaleY = -0.025;
			_hardwareText.scaleX = 0.025;
			
			_hardwareText.standardFormat.color = _color;
			_hardwareText.standardFormat.textAlign = _textAlign;
			_hardwareText.standardFormat.scale = _textScale;
			_hardwareText.standardFormat.shearX = _textSkewX;
			_hardwareText.standardFormat.shearY = _textSkewY;
			_hardwareText.standardFormat.font = _font;
			_hardwareText.standardFormat.vertexDistance = _vertexDistance;
			
			_hardwareText.width = width;
			_hardwareText.text = _text;
		}
	
	}

}