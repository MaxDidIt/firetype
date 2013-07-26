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

package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.components.HardwareLine;
	import de.maxdidit.hardware.text.components.HardwareWord;
	import de.maxdidit.hardware.text.components.TextSpan;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.layout.ILayout;
	import de.maxdidit.hardware.text.layout.LeftToRightLayout;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRendererFactory;
	import flash.display3D.Context3D;
	
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
		
		private var _textContainer:TransformedInstance;
		
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		private var _textWidth:Number = 0;
		private var _textHeight:Number = 0;
		
		private var _fixedWidth:Boolean;
		private var _untransformedWidth:Number;
		private var _untransformedHeight:Number;
		
		private var _standardFormat:HardwareTextFormat;
		
		private var _layoutDirty:Boolean;
		private var _instancesDirty:Boolean;
		
		private var _layout:ILayout;
		
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		
		public function HardwareText(context3D:Context3D, cache:HardwareCharacterCache = null, layout:ILayout = null, typesetter:Typesetter = null)
		{
			_standardFormat = new HardwareTextFormat();
			
			_textContainer = new TransformedInstance();
			super.addChild(_textContainer);
			
			this._cache = cache;
			if (!_cache)
			{
				_cache = new HardwareCharacterCache(new SingleGlyphRendererFactory(context3D));
			}
			this._cache.addClient(this);
			
			this._layout = layout;
			if (!_layout)
			{
				_layout = new LeftToRightLayout();
			}
			
			this._typesetter = typesetter
			if (!_typesetter)
			{
				_typesetter = new Typesetter();
			}
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
				
				_cache.clearInstanceCache();
				_layoutDirty = true;
			}
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		public function set width(value:Number):void
		{
			_width = value;
			_untransformedWidth = _width / scaleX;
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
		
		public function get fixedWidth():Boolean
		{
			return _fixedWidth;
		}
		
		public function set fixedWidth(value:Boolean):void
		{
			_fixedWidth = value;
		}
		
		override public function get x():Number
		{
			return _textContainer.x;
		}
		
		override public function set x(value:Number):void
		{
			_textContainer.x = value;
		}
		
		override public function get y():Number
		{
			return _textContainer.y;
		}
		
		override public function set y(value:Number):void
		{
			_textContainer.y = value;
		}
		
		override public function get shearX():Number
		{
			return _textContainer.shearX;
		}
		
		override public function set shearX(value:Number):void
		{
			_textContainer.shearX = value;
		}
		
		override public function get shearY():Number
		{
			return _textContainer.shearY;
		}
		
		override public function set shearY(value:Number):void
		{
			_textContainer.shearY = value;
		}
		
		override public function get scaleX():Number
		{
			return _textContainer.scaleX;
		}
		
		override public function set scaleX(value:Number):void
		{
			_textContainer.scaleX = value;
			_untransformedWidth = _width / scaleX;
		}
		
		override public function get scaleY():Number
		{
			return _textContainer.scaleY;
		}
		
		override public function set scaleY(value:Number):void
		{
			_textContainer.scaleY = value;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function get textWidth():Number
		{
			return _textWidth * scaleX;
		}
		
		public function get textHeight():Number
		{
			return _textHeight * scaleY;
		}
		
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		
		public function setMeasuredDimensions(measuredWidth:Number, measuredHeight:Number):void
		{
			_textWidth = measuredWidth;
			_textHeight = measuredHeight;
		}
		
		override public function addChild(child:TransformedInstance):void
		{
			_textContainer.addChild(child);
		}
		
		public function registerFont(font:HardwareFont):void
		{
			throw new Error("Function not yet implemented.");
		}
		
		private function parseText():void
		{
			loseAllChildren();
			
			var textSpans:Vector.<TextSpan> = _typesetter.createTextSpans(_text, _standardFormat, _cache);
			_layout.layout(this, textSpans);
		}
		
		override public function loseAllChildren():void
		{
			// clean up instances 
			const l:uint = _textContainer.numChildren;
			for (var i:uint = 0; i < l; i++)
			{
				var line:HardwareLine = _textContainer.children.shift() as HardwareLine;
				line.loseAllChildren();
			}
		}
		
		public function update(cacheGlyphs:Boolean = true):void
		{
			if (_layoutDirty)
			{
				loseAllChildren();
				parseText();
				
				_textContainer.flagForUpdate();
				_layoutDirty = false;
			}
			
			if (_instancesDirty && cacheGlyphs)
			{
				cacheTextGlyphs();
				_instancesDirty = false;
			}
			
			if (_textContainer.isFlaggedForUpdate)
			{
				calculateTransformations();
			}
		}
		
		private function cacheTextGlyphs():void
		{
			const lineCount:uint = _textContainer.children.length;
			for (var li:uint = 0; li < lineCount; li++)
			{
				var line:HardwareLine = _textContainer.children[li] as HardwareLine;
				if (!line)
				{
					continue;
				}
				
				var wordCount:uint = line.children.length;
				for (var wi:uint = 0; wi < wordCount; wi++)
				{
					var word:HardwareWord = line.children[wi] as HardwareWord;
					if (!word)
					{
						continue;
					}
					
					var characterCount:uint = word.children.length;
					for (var ci:uint = 0; ci < characterCount; ci++)
					{
						var character:HardwareCharacterInstance = word.children[ci] as HardwareCharacterInstance;
						if (!character)
						{
							continue;
						}
						
						var glyphCount:uint = character.children.length;
						for (var gi:uint = 0; gi < glyphCount; gi++)
						{
							var glyphInstance:HardwareGlyphInstance = character.children[gi] as HardwareGlyphInstance;
							if (!glyphInstance)
							{
								continue;
							}
							
							var hardwareGlyph:HardwareGlyph = _cache.getCachedHardwareGlyph(glyphInstance.glyph.font.uniqueIdentifier, glyphInstance.vertexDistance, glyphInstance.glyph.header.index);
							if (!hardwareGlyph)
							{
								var paths:Vector.<Vector.<Vertex>> = new Vector.<Vector.<Vertex>>();
								var originalPaths:Vector.<Vector.<Vertex>> = new Vector.<Vector.<Vertex>>();
								
								glyphInstance.glyph.retrievePaths(glyphInstance.vertexDistance, paths, originalPaths);
								hardwareGlyph = cache.addPathsAsHardwareGlyph(paths, originalPaths, glyphInstance.glyph.font, glyphInstance.vertexDistance, glyphInstance.glyph.header.index);
								hardwareGlyph.glyph = glyphInstance.glyph;
							}
							
							glyphInstance.hardwareGlyph = hardwareGlyph;
							
							cache.registerGlyphInstance(glyphInstance, glyphInstance.glyph.font, glyphInstance.vertexDistance, glyphInstance.textColor);
						}
					}
				}
			}
		}
		
		public override function flagForUpdate():void
		{
			_layoutDirty = true;
			_instancesDirty = true;
		}
	
	}
}
