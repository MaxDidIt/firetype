package de.maxdidit.hardware.text.tags 
{
	import de.maxdidit.hardware.text.format.HardwareFontFeatures;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FormatTag extends TextTag 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _formatId:String;
		private var _isFormatIdSet:Boolean = false;
		
		private var _fontId:String;
		private var _isFontIdSet:Boolean;
		
		private var _scale:Number;
		private var _isScaleSet:Boolean = false;
		
		private var _color:uint;
		private var _isColorSet:Boolean = false;
		
		private var _textAlign:uint;
		private var _isTextAlignSet:Boolean = false;
		
		private var _vertexDistance:Number;
		private var _isVertexDistanceSet:Boolean = false;
		
		private var _features:HardwareFontFeatures;
		
		private var _scriptTag:String;
		private var _isScriptTagSet:Boolean = false;
		
		private var _languageTag:String;
		private var _isLanguageTagSet:Boolean = false;
		
		private var _colorId:String;
		private var _isColorIdSet:Boolean = false;
		
		private var _shearX:Number;
		private var _isShearXSet:Boolean = false;
		
		private var _shearY:Number;
		private var _isShearYSet:Boolean = false;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FormatTag() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get extendsReferencedFormat():Boolean
		{
			return _isColorIdSet || _isColorSet || _isScaleSet || _isLanguageTagSet || _isScaleSet || _isTextAlignSet || _isVertexDistanceSet || _isFontIdSet || _isShearXSet || _isShearYSet;
		}
		
		public function get formatId():String 
		{
			return _formatId;
		}
		
		public function set formatId(value:String):void 
		{
			_formatId = value;
			_isFormatIdSet = true;
		}
		
		public function get isFormatIdSet():Boolean 
		{
			return _isFormatIdSet;
		}
		
		public function get scale():Number
		{
			return _scale;
		}
		
		public function set scale(value:Number):void 
		{
			_scale = value;
			_isScaleSet = true;
		}
		
		public function get isScaleSet():Boolean 
		{
			return _isScaleSet;
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
			_isColorSet = true;
		}
		
		public function get isColorSet():Boolean 
		{
			return _isColorSet;
		}
		
		public function get textAlign():uint 
		{
			return _textAlign;
		}
		
		public function set textAlign(value:uint):void 
		{
			_textAlign = value;
			_isTextAlignSet = true;
		}
		
		public function get isTextAlignSet():Boolean 
		{
			return _isTextAlignSet;
		}
		
		public function get vertexDistance():Number 
		{
			return _vertexDistance;
		}
		
		public function set vertexDistance(value:Number):void 
		{
			_vertexDistance = value;
			_isVertexDistanceSet = true;
		}
		
		public function get isVertexDistanceSet():Boolean 
		{
			return _isVertexDistanceSet;
		}
		
		public function get features():HardwareFontFeatures 
		{
			return _features;
		}
		
		public function set features(value:HardwareFontFeatures):void 
		{
			_features = value;
		}
		
		public function get areFeaturesSet():Boolean 
		{
			return _features != null;
		}
		
		public function get scriptTag():String 
		{
			return _scriptTag;
		}
		
		public function set scriptTag(value:String):void 
		{
			_scriptTag = value;
			_isScriptTagSet = true;
		}
		
		public function get languageTag():String 
		{
			return _languageTag;
		}
		
		public function set languageTag(value:String):void 
		{
			_languageTag = value;
			_isLanguageTagSet = true;
		}
		
		public function get isScriptTagSet():Boolean 
		{
			return _isScriptTagSet;
		}
		
		public function get isLanguageTagSet():Boolean 
		{
			return _isLanguageTagSet;
		}
		
		public function get fontId():String 
		{
			return _fontId;
		}
		
		public function set fontId(value:String):void 
		{
			_fontId = value;
			_isFontIdSet = true;
		}
		
		public function get isFontIdSet():Boolean 
		{
			return _isFontIdSet;
		}
		
		public function get colorId():String 
		{
			return _colorId;
		}
		
		public function set colorId(value:String):void 
		{
			_colorId = value;
			_isColorIdSet = true;
		}
		
		public function get isColorIdSet():Boolean 
		{
			return _isColorIdSet;
		}
		
		public function get shearX():Number 
		{
			return _shearX;
		}
		
		public function set shearX(value:Number):void 
		{
			_shearX = value;
			_isShearXSet = true;
		}
		
		public function get shearY():Number 
		{
			return _shearY;
		}
		
		public function set shearY(value:Number):void 
		{
			_shearY = value;
			_isShearYSet = true;
		}
		
		public function get isShearXSet():Boolean 
		{
			return _isShearXSet;
		}
		
		public function get isShearYSet():Boolean 
		{
			return _isShearYSet;
		}
		
	}

}