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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature  
{ 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LigatureTable  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _ligatureGlyphID:uint; 
		 
		private var _componentCount:uint; 
		private var _componentGlyphIDs:Vector.<uint>; 
		 
		private var _ligatureGlyph:Glyph; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LigatureTable()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get ligatureGlyphID():uint  
		{ 
			return _ligatureGlyphID; 
		} 
		 
		public function set ligatureGlyphID(value:uint):void  
		{ 
			_ligatureGlyphID = value; 
		} 
		 
		public function get componentCount():uint  
		{ 
			return _componentCount; 
		} 
		 
		public function set componentCount(value:uint):void  
		{ 
			_componentCount = value; 
		} 
		 
		public function get componentGlyphIDs():Vector.<uint>  
		{ 
			return _componentGlyphIDs; 
		} 
		 
		public function set componentGlyphIDs(value:Vector.<uint>):void  
		{ 
			_componentGlyphIDs = value; 
		} 
		 
		public function get ligatureGlyph():Glyph  
		{ 
			return _ligatureGlyph; 
		} 
		 
		public function set ligatureGlyph(value:Glyph):void  
		{ 
			_ligatureGlyph = value; 
		} 
		 
	} 
} 
