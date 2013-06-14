/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.text.format 
{ 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag; 
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageTag; 
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTag; 
	import de.maxdidit.hardware.font.HardwareFont; 
	import de.maxdidit.hardware.font.parser.OpenTypeParser; 
	import flash.utils.ByteArray; 
	import flash.utils.getTimer; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class HardwareTextFormat 
	{ 
		/////////////////////// 
		// Constants 
		/////////////////////// 
		 
		/* 
		firetype uses the Open Source font "News Cycle" as it's default font.  
		 
		Copyright (c) 2010-2011, Nathan Willis (nwillis@glyphography.com), 
		with Reserved Font Name "News Cycle." 
		This Font Software is licensed under the SIL Open Font License, Version 1.1. 
		This license is available with a FAQ at: 
		http://scripts.sil.org/OFL 
		*/ 
		 
		[Embed(source="../../../../../../resources/fonts/newscycle/newscycle-regular.ttf", mimeType="application/octet-stream")] 
        private static const fontNewsCycleData : Class; 
		 
		public static const DEFAULT_FONT:HardwareFont = new OpenTypeParser().parseFont(new fontNewsCycleData() as ByteArray); 
		 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		// font 
		private var _font:HardwareFont = DEFAULT_FONT; 
		private var _isFontSet:Boolean = false; 
		 
		// scale 
		private var _scale:Number = 1; 
		private var _isScaleSet:Boolean = false; 
		 
		// color 
		private var _color:TextColor; 
		private var _isColorSet:Boolean = false; 
		 
		// text align 
		private var _textAlign:uint = TextAlign.LEFT; 
		private var _isTextAlignSet:Boolean = false; 
		 
		// vertex density 
		private var _vertexDistance:uint = 100; 
		private var _isVertexDistanceSet:Boolean; 
		 
		// features 
		private var _features:HardwareFontFeatures; 
		 
		// scriptTag 
		private var _scriptTag:String = ScriptTag.LATIN; 
		private var _isScriptTagSet:Boolean; 
		 
		// languageTag 
		private var _languageTag:String = LanguageTag.ENGLISH; 
		private var _isLanguageTagSet:Boolean; 
		 
		// shearX 
		private var _shearX:Number = 0; 
		private var _isShearXSet:Boolean = false; 
		 
		// shearY 
		private var _shearY:Number = 0; 
		private var _isShearYSet:Boolean = false; 
		 
		private var _id:String; 
		 
		private var _parentFormat:HardwareTextFormat; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function HardwareTextFormat(parentFormat:HardwareTextFormat = null) 
		{ 
			_parentFormat = parentFormat; 
			 
			_color = new TextColor(); 
			 
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
			if (_isFontSet || !_parentFormat) 
			{ 
				return _font; 
			} 
			 
			return _parentFormat.font; 
		} 
		 
		public function set font(value:HardwareFont):void 
		{ 
			_font = value; 
			_isFontSet = true; 
		} 
		 
		// scale 
		 
		public function get scale():Number 
		{ 
			if (_isScaleSet || !_parentFormat) 
			{ 
				return _scale; 
			} 
			 
			return _parentFormat.scale; 
		} 
		 
		public function set scale(value:Number):void 
		{ 
			_scale = value; 
			_isScaleSet = true; 
		} 
		 
		// color 
		 
		public function get color():uint 
		{ 
			if (_isColorSet || !_parentFormat) 
			{ 
				return _color.color; 
			} 
			 
			return _parentFormat.color; 
		} 
		 
		public function set color(value:uint):void 
		{ 
			_color.color = value; 
			_isColorSet = true; 
		} 
		 
		// subdivisions 
		 
		public function get vertexDistance():Number 
		{ 
			if (_isVertexDistanceSet || !_parentFormat) 
			{ 
				return _vertexDistance; 
			} 
			 
			return _parentFormat.vertexDistance; 
		} 
		 
		public function set vertexDistance(value:Number):void 
		{ 
			_vertexDistance = value; 
			_isVertexDistanceSet = true; 
		} 
		 
		// scriptTag 
		 
		public function get scriptTag():String 
		{ 
			if (_isScriptTagSet || !_parentFormat) 
			{ 
				return _scriptTag; 
			} 
			 
			return _parentFormat.scriptTag; 
		} 
		 
		public function set scriptTag(value:String):void 
		{ 
			_scriptTag = value; 
			_isScriptTagSet = true; 
		} 
		 
		// languageTag 
		 
		public function get languageTag():String 
		{ 
			return _languageTag; 
		} 
		 
		public function set languageTag(value:String):void 
		{ 
			_languageTag = value; 
			_isLanguageTagSet = true; 
		} 
		 
		// features 
		 
		public function get features():HardwareFontFeatures  
		{ 
			return _features; 
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
			return _color.colorVector; 
		} 
		 
		public function get textAlign():uint  
		{ 
			if (_isTextAlignSet || !_parentFormat) 
			{ 
				return _textAlign; 
			} 
			 
			return _parentFormat.textAlign; 
		} 
		 
		public function set textAlign(value:uint):void  
		{ 
			_textAlign = value; 
			_isTextAlignSet = true; 
		} 
		 
		public function get parentFormat():HardwareTextFormat  
		{ 
			return _parentFormat; 
		} 
		 
		public function set parentFormat(value:HardwareTextFormat):void  
		{ 
			_parentFormat = value; 
		} 
		 
		public function get isColorSet():Boolean  
		{ 
			return _isColorSet; 
		} 
		 
		public function get isScaleSet():Boolean  
		{ 
			return _isScaleSet; 
		} 
		 
		public function get textColor():TextColor  
		{ 
			if (_isColorSet || !_parentFormat) 
			{ 
				return _color; 
			} 
			 
			return _parentFormat.textColor; 
		} 
		 
		public function set textColor(value:TextColor):void 
		{ 
			_color = value; 
			_isColorSet = true; 
		} 
		 
		public function get isVertexDistanceSet():Boolean  
		{ 
			return _isVertexDistanceSet; 
		} 
		 
		public function get isScriptTagSet():Boolean  
		{ 
			return _isScriptTagSet; 
		} 
		 
		public function get isLanguageTagSet():Boolean  
		{ 
			return _isLanguageTagSet; 
		} 
		 
		public function get isTextAlignSet():Boolean  
		{ 
			return _isTextAlignSet; 
		} 
		 
		public function get shearX():Number  
		{ 
			if (_isShearXSet || !_parentFormat) 
			{ 
				return _shearX; 
			} 
			 
			return _parentFormat.shearX; 
		} 
		 
		public function set shearX(value:Number):void  
		{ 
			_shearX = value; 
			_isShearXSet = true; 
		} 
		 
		public function get shearY():Number  
		{ 
			if (_isShearYSet || !_parentFormat) 
			{ 
				return _shearY; 
			} 
			 
			return _parentFormat.shearY; 
		} 
		 
		public function set shearY(value:Number):void  
		{ 
			_shearY = value; 
			_isShearYSet = true; 
		} 
	 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
	} 
} 
