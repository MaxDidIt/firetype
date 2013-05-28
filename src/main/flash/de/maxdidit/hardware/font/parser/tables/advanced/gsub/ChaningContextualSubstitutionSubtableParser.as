package de.maxdidit.hardware.font.parser.tables.advanced.gsub
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.ChainingContextSubstitutionTableFormat3;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.IChainingContextualSubstitutionTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChaningContextualSubstitutionSubtableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChaningContextualSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageParser:CoverageTableParser)
		{
			this._dataTypeParser = $dataTypeParser;
			this._coverageParser = $coverageParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):*
		{
			data.position = offset;
			
			var result:IChainingContextualSubstitutionTable;
			
			var subFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			switch (subFormat)
			{
				case 1: 
					throw new Error("Chaining Contextual Substitution Format 1 not yet implemented.");
					break;
				
				case 2: 
					throw new Error("Chaining Contextual Substitution Format 2 not yet implemented.");
					break;
				
				case 3: 
					result = parseContextualSubstitutionTableFormat3(data, offset);
					break;
			}
			
			return result;
		}
		
		// table format 3
		
		private function parseContextualSubstitutionTableFormat3(data:ByteArray, offset:uint):IChainingContextualSubstitutionTable
		{
			var result:ChainingContextSubstitutionTableFormat3 = new ChainingContextSubstitutionTableFormat3();
			
			// backtracking glyphs
			var backtrackGlyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.backtrackGlyphCount = backtrackGlyphCount;
			
			var backtrackCoverageOffsets:Vector.<uint> = new Vector.<uint>(backtrackGlyphCount);
			for (var i:uint = 0; i < backtrackGlyphCount; i++)
			{
				var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
				backtrackCoverageOffsets[i] = coverageOffset;
			}
			result.backtrackCoverageOffsets = backtrackCoverageOffsets;
			
			// input glyphs
			var inputGlyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.inputGlyphCount = inputGlyphCount;
			
			var inputCoverageOffsets:Vector.<uint> = new Vector.<uint>(inputGlyphCount);
			for (i = 0; i < inputGlyphCount; i++)
			{
				coverageOffset = _dataTypeParser.parseUnsignedShort(data);
				inputCoverageOffsets[i] = coverageOffset;
			}
			result.inputCoverageOffsets = inputCoverageOffsets;
			
			// lookahead glyphs
			var lookaheadGlyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.lookaheadGlyphCount = lookaheadGlyphCount;
			
			var lookaheadCoverageOffsets:Vector.<uint> = new Vector.<uint>(lookaheadGlyphCount);
			for (i = 0; i < lookaheadGlyphCount; i++)
			{
				coverageOffset = _dataTypeParser.parseUnsignedShort(data);
				lookaheadCoverageOffsets[i] = coverageOffset;
			}
			result.lookaheadCoverageOffsets = lookaheadCoverageOffsets;
			
			// substitution lookup records
			var substitutionRecordCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.substitutionCount = substitutionRecordCount;
			
			var substitutionLookupRecords:Vector.<SubstitutionLookupRecord> = new Vector.<SubstitutionLookupRecord>(substitutionRecordCount);
			for (i = 0; i < substitutionRecordCount; i++)
			{
				var record:SubstitutionLookupRecord = parseSubstitutionLookupRecord(data);
				substitutionLookupRecords[i] = record;
			}
			result.substitutionLookupRecords = substitutionLookupRecords;
			
			// parse coverages
			var backtrackCoverages:Vector.<ICoverageTable> = parseCoverageTables(data, backtrackCoverageOffsets, offset);
			result.backtrackCoverages = backtrackCoverages;
			
			var inputCoverages:Vector.<ICoverageTable> = parseCoverageTables(data, inputCoverageOffsets, offset);
			result.inputCoverages = inputCoverages;
			
			var lookaheadCoverages:Vector.<ICoverageTable> = parseCoverageTables(data, lookaheadCoverageOffsets, offset);
			result.lookaheadCoverages = lookaheadCoverages;
			
			return result;
		}
		
		private function parseCoverageTables(data:ByteArray, coverageOffsets:Vector.<uint>, offset:uint):Vector.<ICoverageTable>
		{
			const l:uint = coverageOffsets.length;
			var result:Vector.<ICoverageTable> = new Vector.<ICoverageTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var coverageOffset:uint = coverageOffsets[i];
				var coverage:ICoverageTable = _coverageParser.parseTable(data, coverageOffset + offset);
				result[i] = coverage;
			}
			
			return result;
		}
		
		private function parseSubstitutionLookupRecord(data:ByteArray):SubstitutionLookupRecord
		{
			var result:SubstitutionLookupRecord = new SubstitutionLookupRecord();
			
			var sequenceIndex:uint = _dataTypeParser.parseUnsignedShort(data);
			result.sequenceIndex = sequenceIndex;
			
			var lookupListIndex:uint = _dataTypeParser.parseUnsignedShort(data);
			result.lookupListIndex = lookupListIndex;
			
			return result;
		}
	}

}