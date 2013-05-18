package de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CursiveAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _entryExitCount:uint;
		private var _entryExitRecords:Vector.<EntryExitRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CursiveAttachmentPositioningSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Propertes
		///////////////////////
		
		public function get coverageOffset():uint 
		{
			return _coverageOffset;
		}
		
		public function set coverageOffset(value:uint):void 
		{
			_coverageOffset = value;
		}
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
		public function get entryExitCount():uint 
		{
			return _entryExitCount;
		}
		
		public function set entryExitCount(value:uint):void 
		{
			_entryExitCount = value;
		}
		
		public function get entryExitRecords():Vector.<EntryExitRecord> 
		{
			return _entryExitRecords;
		}
		
		public function set entryExitRecords(value:Vector.<EntryExitRecord>):void 
		{
			_entryExitRecords = value;
		}
		
	}

}