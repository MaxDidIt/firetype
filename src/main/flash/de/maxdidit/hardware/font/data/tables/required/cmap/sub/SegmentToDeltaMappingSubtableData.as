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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.required.cmap.sub.ICharacterIndexMappingSubtableData */
		
		public function getGlyphIndex(charCode:Number):int 
		{
			// search endcode
			const l:uint = _endCount.length;
			for (var i:uint = 0; i < l; i++)
			{
				var endCount:uint = _endCount[i];
				if (endCount >= charCode)
				{
					break;
				}
			}
			
			if (!(_startCount[i] <= charCode))
			{
				return 0;
			}
			
			var glyphID:int;
			if (_idRangeOffset[i] == 0)
			{
				glyphID = charCode + _idDelta[i]
				return glyphID;
			}
			
			// TODO: This part has not been tested yet.
			var idIndex:uint = _idRangeOffset[i] / 2 + (charCode - _startCount[i]);
			return _glyphIdArray[idIndex];
		}
	}

}