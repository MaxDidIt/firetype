package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainingContextSubstitutionLookupFormat3 implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _backtackCoverages:Vector.<ICoverageTable>;
		private var _inputCoverages:Vector.<ICoverageTable>;
		private var _lookaheadCoverages:Vector.<ICoverageTable>;
		
		private var _substitutionLookupRecords:Vector.<SubstitutionLookupRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainingContextSubstitutionLookupFormat3() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get backtackCoverages():Vector.<ICoverageTable> 
		{
			return _backtackCoverages;
		}
		
		public function set backtackCoverages(value:Vector.<ICoverageTable>):void 
		{
			_backtackCoverages = value;
		}
		
		public function get inputCoverages():Vector.<ICoverageTable> 
		{
			return _inputCoverages;
		}
		
		public function set inputCoverages(value:Vector.<ICoverageTable>):void 
		{
			_inputCoverages = value;
		}
		
		public function get lookaheadCoverages():Vector.<ICoverageTable> 
		{
			return _lookaheadCoverages;
		}
		
		public function set lookaheadCoverages(value:Vector.<ICoverageTable>):void 
		{
			_lookaheadCoverages = value;
		}
		
		public function get substitutionLookupRecords():Vector.<SubstitutionLookupRecord> 
		{
			return _substitutionLookupRecords;
		}
		
		public function set substitutionLookupRecords(value:Vector.<SubstitutionLookupRecord>):void 
		{
			_substitutionLookupRecords = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void 
		{
			//throw new Error("Not yet implemented.");
		}
	}

}