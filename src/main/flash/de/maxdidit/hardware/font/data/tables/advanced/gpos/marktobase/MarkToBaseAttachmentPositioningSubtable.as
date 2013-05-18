package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToBaseAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _markCoverageOffset:uint;
		private var _markCoverage:ICoverageTable;
		
		private var _baseCoverageOffset:uint;
		private var _baseCoverage:ICoverageTable;
		
		private var _classCount:uint;
		
		private var _markArrayOffset:uint;
		private var _markArray:MarkArray;
		
		private var _baseArrayOffset:uint;
		private var _baseArray:BaseArray;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToBaseAttachmentPositioningSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get markCoverageOffset():uint 
		{
			return _markCoverageOffset;
		}
		
		public function set markCoverageOffset(value:uint):void 
		{
			_markCoverageOffset = value;
		}
		
		public function get markCoverage():ICoverageTable 
		{
			return _markCoverage;
		}
		
		public function set markCoverage(value:ICoverageTable):void 
		{
			_markCoverage = value;
		}
		
		public function get baseCoverageOffset():uint 
		{
			return _baseCoverageOffset;
		}
		
		public function set baseCoverageOffset(value:uint):void 
		{
			_baseCoverageOffset = value;
		}
		
		public function get baseCoverage():ICoverageTable 
		{
			return _baseCoverage;
		}
		
		public function set baseCoverage(value:ICoverageTable):void 
		{
			_baseCoverage = value;
		}
		
		public function get classCount():uint 
		{
			return _classCount;
		}
		
		public function set classCount(value:uint):void 
		{
			_classCount = value;
		}
		
		public function get markArrayOffset():uint 
		{
			return _markArrayOffset;
		}
		
		public function set markArrayOffset(value:uint):void 
		{
			_markArrayOffset = value;
		}
		
		public function get markArray():MarkArray 
		{
			return _markArray;
		}
		
		public function set markArray(value:MarkArray):void 
		{
			_markArray = value;
		}
		
		public function get baseArrayOffset():uint 
		{
			return _baseArrayOffset;
		}
		
		public function set baseArrayOffset(value:uint):void 
		{
			_baseArrayOffset = value;
		}
		
		public function get baseArray():BaseArray 
		{
			return _baseArray;
		}
		
		public function set baseArray(value:BaseArray):void 
		{
			_baseArray = value;
		}
		
	}

}