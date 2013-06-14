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
 
package de.maxdidit.hardware.font.data.tables.truetype.glyf  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class GlyphTableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _glyphs:Vector.<Glyph>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function GlyphTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// glyphs 
		 
		public function get glyphs():Vector.<Glyph>  
		{ 
			return _glyphs; 
		} 
		 
		public function set glyphs(value:Vector.<Glyph>):void  
		{ 
			_glyphs = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		public function retrieveGlyph(id:uint):Glyph  
		{ 
			if (id >= _glyphs.length) 
			{ 
				return null; 
			} 
			 
			return _glyphs[id]; 
		} 
		 
	} 
} 
