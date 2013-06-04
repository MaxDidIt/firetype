package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToMarkAttachmentPositioningLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _mark2Coverage:ICoverageTable;
		private var _mark2Array:Mark2Array;
		private var _markRecord:MarkRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToMarkAttachmentPositioningLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get mark2Coverage():ICoverageTable 
		{
			return _mark2Coverage;
		}
		
		public function set mark2Coverage(value:ICoverageTable):void 
		{
			_mark2Coverage = value;
		}
		
		public function get mark2Array():Mark2Array 
		{
			return _mark2Array;
		}
		
		public function set mark2Array(value:Mark2Array):void 
		{
			_mark2Array = value;
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