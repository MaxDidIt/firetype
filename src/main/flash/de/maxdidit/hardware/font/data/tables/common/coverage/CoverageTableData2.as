package de.maxdidit.hardware.font.data.tables.common.coverage 
{
	import de.maxdidit.hardware.font.HardwareFont;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CoverageTableData2 implements ICoverageTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _format:uint;
		private var _rangeCount:uint;
		
		private var _rangeRecords:Vector.<RangeRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CoverageTableData2() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// format
		
		public function get format():uint 
		{
			return _format;
		}
		
		public function set format(value:uint):void 
		{
			// TODO: If this is set to anything else than 1, something's wrong
			_format = value;
		}
		
		// rangeCount
		
		public function get rangeCount():uint 
		{
			return _rangeCount;
		}
		
		public function set rangeCount(value:uint):void 
		{
			_rangeCount = value;
		}
		
		// rangeRecords
		
		public function get rangeRecords():Vector.<RangeRecord> 
		{
			return _rangeRecords;
		}
		
		public function set rangeRecords(value:Vector.<RangeRecord>):void 
		{
			_rangeRecords = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable */
		
		public function getCoverageIndex(glyphIndex:uint):int 
		{
			var min:int = 0;
			var max:int = _rangeCount - 1;
			
			while (max >= min)
			{
				var mid:int = (min + max) >> 1;
				
				var record:RangeRecord = _rangeRecords[mid];
				
				if (glyphIndex < record.start)
				{
					max = mid - 1;
				}
				else if (glyphIndex > record.end)
				{
					min = mid + 1;
				}
				else
				{
					return record.startCoverageIndex + glyphIndex - record.start;
				}
			}
			
			return -1;
		}
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable */
		
		public function iterateOverCoveredIndices(callback:Function, font:HardwareFont):void 
		{
			const l:uint = _rangeCount;
			for (var i:uint = 0; i < l; i++)
			{
				var rangeRecord:RangeRecord = _rangeRecords[i];
				
				var start:uint = rangeRecord.start;
				var end:uint = rangeRecord.end;
				var startCoverageIndex:uint = rangeRecord.startCoverageIndex;
				
				for (var glyphIndex:uint = start; glyphIndex <= end; glyphIndex++)
				{
					var coverageIndex:uint = startCoverageIndex + glyphIndex - start;
					callback.call(null, glyphIndex, coverageIndex, font);
				}
			}
		}
		
	}

}