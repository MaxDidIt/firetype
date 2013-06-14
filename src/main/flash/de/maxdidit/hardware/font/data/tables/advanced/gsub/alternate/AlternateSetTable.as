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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate  
{ 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class AlternateSetTable  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _glyphCount:uint; 
		private var _alternateGlyphIDs:Vector.<uint>; 
		private var _alternateGlyphs:Vector.<Glyph>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function AlternateSetTable()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get glyphCount():uint  
		{ 
			return _glyphCount; 
		} 
		 
		public function set glyphCount(value:uint):void  
		{ 
			_glyphCount = value; 
		} 
		 
		public function get alternateGlyphIDs():Vector.<uint>  
		{ 
			return _alternateGlyphIDs; 
		} 
		 
		public function set alternateGlyphIDs(value:Vector.<uint>):void  
		{ 
			_alternateGlyphIDs = value; 
		} 
		 
		public function get alternateGlyphs():Vector.<Glyph>  
		{ 
			return _alternateGlyphs; 
		} 
		 
		public function set alternateGlyphs(value:Vector.<Glyph>):void  
		{ 
			_alternateGlyphs = value; 
		} 
		 
	} 
} 
