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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature  
{ 
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LigatureCaretListTableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _coverageOffset:uint; 
		private var _coverage:ICoverageTable; 
		 
		private var _ligatureGlyphCount:uint; 
		private var _ligatureGlyphTableOffsets:Vector.<uint> 
		 
		private var _ligatureGlyphTables:Vector.<LigatureGlyphTable>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LigatureCaretListTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// coverageOffset 
		 
		public function get coverageOffset():uint  
		{ 
			return _coverageOffset; 
		} 
		 
		public function set coverageOffset(value:uint):void  
		{ 
			_coverageOffset = value; 
		} 
		 
		// ligatureGlyphCount 
		 
		public function get ligatureGlyphCount():uint  
		{ 
			return _ligatureGlyphCount; 
		} 
		 
		public function set ligatureGlyphCount(value:uint):void  
		{ 
			_ligatureGlyphCount = value; 
		} 
		 
		// ligatureGlyphTableOffsets 
		 
		public function get ligatureGlyphTableOffsets():Vector.<uint>  
		{ 
			return _ligatureGlyphTableOffsets; 
		} 
		 
		public function set ligatureGlyphTableOffsets(value:Vector.<uint>):void  
		{ 
			_ligatureGlyphTableOffsets = value; 
		} 
		 
		// ligatureGlyphTables 
		 
		public function get ligatureGlyphTables():Vector.<LigatureGlyphTable>  
		{ 
			return _ligatureGlyphTables; 
		} 
		 
		public function set ligatureGlyphTables(value:Vector.<LigatureGlyphTable>):void  
		{ 
			_ligatureGlyphTables = value; 
		} 
		 
		// coverage 
		 
		public function get coverage():ICoverageTable  
		{ 
			return _coverage; 
		} 
		 
		public function set coverage(value:ICoverageTable):void  
		{ 
			_coverage = value; 
		} 
		 
	} 
} 
