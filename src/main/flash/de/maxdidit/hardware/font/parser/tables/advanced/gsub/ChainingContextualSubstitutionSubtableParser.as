package de.maxdidit.hardware.font.parser.tables.advanced.gsub
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.ChainingContextSubstitutionTableFormat1;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.ChainingContextSubstitutionTableFormat3;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.ChainSubRule;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.ChainSubRuleSet;
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
	public class ChainingContextualSubstitutionSubtableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainingContextualSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageParser:CoverageTableParser)
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
					result = parseContextualSubstitutionTableFormat1(data, offset);
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
		
		// table format 1
		
		private function parseContextualSubstitutionTableFormat1(data:ByteArray, offset:uint):IChainingContextualSubstitutionTable 
		{
			var result:ChainingContextSubstitutionTableFormat1 = new ChainingContextSubstitutionTableFormat1();
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var chainSubRuleSetCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.chainSubRuleSetCount = chainSubRuleSetCount;
			
			var chainSubRuleSetOffsets:Vector.<uint> = new Vector.<uint>(chainSubRuleSetCount);
			for (var i:uint = 0; i < chainSubRuleSetCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				chainSubRuleSetOffsets[i] = offset;
			}
			result.chainSubRuleSetOffsets = chainSubRuleSetOffsets;
			
			if (coverageOffset != 0)
			{
				var coverage:ICoverageTable = _coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			var chainSubRuleSets:Vector.<ChainSubRuleSet> = parseChainSubRuleSets(data, offset, chainSubRuleSetOffsets);
			result.chainSubRuleSets = chainSubRuleSets;
			
			return result;
		}
		
		private function parseChainSubRuleSets(data:ByteArray, offset:uint, chainSubRuleSetOffsets:Vector.<uint>):Vector.<ChainSubRuleSet>
		{
			const l:uint = chainSubRuleSetOffsets.length;
			var result:Vector.<ChainSubRuleSet> = new Vector.<ChainSubRuleSet>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var chainSubRuleSetOffset:uint = chainSubRuleSetOffsets[i];
				var chainSubRuleSet:ChainSubRuleSet = parseChainSubRuleSet(data, offset + chainSubRuleSetOffset);
				result[i] = chainSubRuleSet;
			}
			
			return result;
		}
		
		private function parseChainSubRuleSet(data:ByteArray, offset:uint):ChainSubRuleSet 
		{
			data.position = offset;
			
			var result:ChainSubRuleSet = new ChainSubRuleSet();
			
			var chainSubRuleCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.chainSubRuleCount = chainSubRuleCount;
			
			var chainSubRuleOffsets:Vector.<uint> = new Vector.<uint>(chainSubRuleCount);
			for (var i:uint = 0; i < chainSubRuleCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				chainSubRuleOffsets[i] = offset;
			}
			result.chainSubRuleOffsets = chainSubRuleOffsets;
			
			var chainSubRules:Vector.<ChainSubRule> = parseChainSubRules(data, offset, chainSubRuleOffsets);
			
			return result;
		}
		
		private function parseChainSubRules(data:ByteArray, offset:uint, chainSubRuleOffsets:Vector.<uint>):Vector.<ChainSubRule>
		{
			const l:uint = chainSubRuleOffsets.length;
			var result:Vector.<ChainSubRule> = new Vector.<ChainSubRule>();
			
			for (var i:uint = 0; i < l; i++)
			{
				var chainSubRuleOffset:uint = chainSubRuleOffsets[i];
				var chainSubRule:ChainSubRule = parseChainSubRule(data, offset + chainSubRuleOffset);
				result[i] = chainSubRule;
			}
			
			return result;
		}
		
		private function parseChainSubRule(data:ByteArray, offset:uint):ChainSubRule 
		{
			data.position = offset;
			
			var result:ChainSubRule = new ChainSubRule();
			
			var backtrackGlyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.backtrackGlyphCount = backtrackGlyphCount;
			
			var backtrackGlyphIDs:Vector.<uint> = new Vector.<uint>(backtrackGlyphCount);
			for (var i:uint = 0; i < backtrackGlyphCount; i++)
			{
				var glyphID:uint = _dataTypeParser.parseUnsignedShort(data);
				backtrackGlyphIDs[i] = glyphID;
			}
			result.backtrackGlyphIDs = backtrackGlyphIDs;
			
			var inputGlyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.inputGlyphCount = inputGlyphCount;
			
			var inputGlyphIDs:Vector.<uint> = new Vector.<uint>(inputGlyphCount - 1);
			for (i = 0; i < inputGlyphCount - 1; i++)
			{
				glyphID = _dataTypeParser.parseUnsignedShort(data);
				inputGlyphIDs[i] = glyphID;
			}
			result.inputGlyphIDs = inputGlyphIDs;
			
			var lookaheadGlyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.lookaheadGlyphCount = lookaheadGlyphCount;
			
			var lookaheadGlyphIDs:Vector.<uint> = new Vector.<uint>();
			for (i = 0; i < lookaheadGlyphCount; i++)
			{
				glyphID = _dataTypeParser.parseUnsignedShort(data);
				lookaheadGlyphIDs[i] = glyphID;
			}
			result.lookaheadGlyphIDs = lookaheadGlyphIDs;
			
			var substitutionCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.substitutionCount = substitutionCount;
			
			var substitutionLookupRecords:Vector.<SubstitutionLookupRecord> = new Vector.<SubstitutionLookupRecord>(substitutionCount);
			for (i = 0; i < substitutionCount; i++)
			{
				var substitutionLookupRecord:SubstitutionLookupRecord = parseSubstitutionLookupRecord(data);
				substitutionLookupRecords[i] = substitutionLookupRecord;
			}
			result.substitutionLookupRecords = substitutionLookupRecords;
			
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