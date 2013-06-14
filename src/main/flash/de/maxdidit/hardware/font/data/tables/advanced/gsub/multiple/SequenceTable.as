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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple  
{ 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class SequenceTable  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _glyphCount:uint; 
		private var _substituteGlyphIDs:Vector.<uint>; 
		private var _substituteGlyphs:Vector.<Glyph>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function SequenceTable()  
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
		 
		public function get substituteGlyphIDs():Vector.<uint>  
		{ 
			return _substituteGlyphIDs; 
		} 
		 
		public function set substituteGlyphIDs(value:Vector.<uint>):void  
		{ 
			_substituteGlyphIDs = value; 
		} 
		 
		public function get substituteGlyphs():Vector.<Glyph>  
		{ 
			return _substituteGlyphs; 
		} 
		 
		public function set substituteGlyphs(value:Vector.<Glyph>):void  
		{ 
			_substituteGlyphs = value; 
		} 
		 
	} 
} 
