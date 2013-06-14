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
 
package de.maxdidit.hardware.font.data.tables.required.cmap.sub 
{ 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class SegmentToDeltaMappingSubtableData implements ICharacterIndexMappingSubtableData 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _length:uint; 
		private var _language:uint; 
		 
		private var _segCountX2:uint; // 2 x segCount. 
		private var _searchRange:uint; // 2 x (2**floor(log2(segCount))) 
		private var _entrySelector:uint; // log2(searchRange/2) 
		private var _rangeShift:uint; // 2 x segCount - searchRange 
		 
		private var _endCount:Vector.<uint>; // End characterCode for each segment, last=0xFFFF. 
		 
		private var _startCount:Vector.<uint>; // Start character code for each segment. 
		private var _idDelta:Vector.<int>; // Delta for all character codes in segment. 
		 
		private var _idRangeOffset:Vector.<uint>; // Offsets into glyphIdArray or 0 
		private var _glyphIdArray:Vector.<uint>; // Glyph index array (arbitrary length) 
		 
		private var _segmentStartIndex:Vector.<uint>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function SegmentToDeltaMappingSubtableData() 
		{ 
		 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.cmap.sub.ICharacterIndexMappingSubtableData */ 
		 
		// format 
		 
		public function get format():uint 
		{ 
			return 4; 
		} 
		 
		// length 
		 
		public function get length():uint 
		{ 
			return _length; 
		} 
		 
		public function set length(value:uint):void 
		{ 
			_length = value; 
		} 
		 
		// language 
		 
		public function get language():uint 
		{ 
			return _language; 
		} 
		 
		public function set language(value:uint):void 
		{ 
			_language = value; 
		} 
		 
		public function get segCountX2():uint 
		{ 
			return _segCountX2; 
		} 
		 
		public function set segCountX2(value:uint):void 
		{ 
			_segCountX2 = value; 
		} 
		 
		public function get searchRange():uint 
		{ 
			return _searchRange; 
		} 
		 
		public function set searchRange(value:uint):void 
		{ 
			_searchRange = value; 
		} 
		 
		public function get entrySelector():uint 
		{ 
			return _entrySelector; 
		} 
		 
		public function set entrySelector(value:uint):void 
		{ 
			_entrySelector = value; 
		} 
		 
		public function get rangeShift():uint 
		{ 
			return _rangeShift; 
		} 
		 
		public function set rangeShift(value:uint):void 
		{ 
			_rangeShift = value; 
		} 
		 
		public function get endCount():Vector.<uint> 
		{ 
			return _endCount; 
		} 
		 
		public function set endCount(value:Vector.<uint>):void 
		{ 
			_endCount = value; 
		} 
		 
		public function get startCount():Vector.<uint> 
		{ 
			return _startCount; 
		} 
		 
		public function set startCount(value:Vector.<uint>):void 
		{ 
			_startCount = value; 
		} 
		 
		public function get idDelta():Vector.<int> 
		{ 
			return _idDelta; 
		} 
		 
		public function set idDelta(value:Vector.<int>):void 
		{ 
			_idDelta = value; 
		} 
		 
		public function get idRangeOffset():Vector.<uint> 
		{ 
			return _idRangeOffset; 
		} 
		 
		public function set idRangeOffset(value:Vector.<uint>):void 
		{ 
			_idRangeOffset = value; 
		} 
		 
		public function get glyphIdArray():Vector.<uint> 
		{ 
			return _glyphIdArray; 
		} 
		 
		public function set glyphIdArray(value:Vector.<uint>):void 
		{ 
			_glyphIdArray = value; 
		} 
		 
		public function get segmentStartIndex():Vector.<uint>  
		{ 
			return _segmentStartIndex; 
		} 
		 
		public function set segmentStartIndex(value:Vector.<uint>):void  
		{ 
			_segmentStartIndex = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.required.cmap.sub.ICharacterIndexMappingSubtableData */ 
		 
		public function getGlyphIndex(charCode:Number):int 
		{ 
			// search endcode 
			//const l:uint = _endCount.length; 
			//for (var segmentIndex:uint = 0; segmentIndex < l; segmentIndex++) 
			//{ 
				//var endCount:uint = _endCount[segmentIndex]; 
				//if (endCount >= charCode) 
				//{ 
					//break; 
				//} 
			//} 
			 
			//if (!(_startCount[segmentIndex] <= charCode)) 
			//{ 
				//return 0; 
			//} 
			 
			var segmentIndex:int = getSegmentIndex(charCode); 
			if (segmentIndex == -1) 
			{ 
				return 0; 
			} 
			 
			var glyphID:int; 
			if (_idRangeOffset[segmentIndex] == 0) 
			{ 
				glyphID = charCode + _idDelta[segmentIndex] 
				return glyphID; 
			} 
			 
			var rangeIndex:uint = charCode - _startCount[segmentIndex]; 
			var idIndex:uint = _segmentStartIndex[segmentIndex] + rangeIndex; 
			if (idIndex != 0) 
			{ 
				idIndex += _idDelta[segmentIndex]; 
			} 
			 
			return _glyphIdArray[idIndex]; 
		} 
		 
		private function getSegmentIndex(glyphIndex:int):int  
		{ 
			var min:int = 0; 
			var max:int = (_segCountX2 >> 1) - 1; 
			 
			while (max >= min) 
			{ 
				var mid:int = (min + max) >> 1; 
				 
				if (glyphIndex < _startCount[mid]) 
				{ 
					max = mid - 1; 
				} 
				else if (glyphIndex > _endCount[mid]) 
				{ 
					min = mid + 1; 
				} 
				else 
				{ 
					return mid; 
				} 
			} 
			 
			return -1; 
		} 
	} 
} 
