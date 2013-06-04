package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToBaseAttachmentPositioningLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _baseCoverage:ICoverageTable;
		private var _baseArray:BaseArray;
		private var _markRecord:MarkRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToBaseAttachmentPositioningLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get baseCoverage():ICoverageTable 
		{
			return _baseCoverage;
		}
		
		public function set baseCoverage(value:ICoverageTable):void 
		{
			_baseCoverage = value;
		}
		
		public function get baseArray():BaseArray 
		{
			return _baseArray;
		}
		
		public function set baseArray(value:BaseArray):void 
		{
			_baseArray = value;
		}
		
		public function get markRecord():MarkRecord 
		{
			return _markRecord;
		}
		
		public function set markRecord(value:MarkRecord):void 
		{
			_markRecord = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void 
		{
			throw new Error("Not yet implemented.");
		}
	}

}