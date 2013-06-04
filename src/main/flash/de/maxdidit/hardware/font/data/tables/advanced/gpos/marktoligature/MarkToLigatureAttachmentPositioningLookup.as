package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToLigatureAttachmentPositioningLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ligatureCoverage:ICoverageTable;
		private var _ligatureArray:LigatureArray;
		private var _markRecord:MarkRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToLigatureAttachmentPositioningLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ligatureCoverage():ICoverageTable 
		{
			return _ligatureCoverage;
		}
		
		public function set ligatureCoverage(value:ICoverageTable):void 
		{
			_ligatureCoverage = value;
		}
		
		public function get ligatureArray():LigatureArray 
		{
			return _ligatureArray;
		}
		
		public function set ligatureArray(value:LigatureArray):void 
		{
			_ligatureArray = value;
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