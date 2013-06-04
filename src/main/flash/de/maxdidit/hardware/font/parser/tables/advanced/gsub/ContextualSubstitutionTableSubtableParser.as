package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.ContextualSubstitutionTableFormat1;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.IContextualSubstitutionTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubRuleSetTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubRuleTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ContextualSubstitutionTableSubtableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ContextualSubstitutionTableSubtableParser($dataTypeParser:DataTypeParser, $coverageParser:CoverageTableParser) 
		{
			this._coverageParser = $coverageParser;
			this._dataTypeParser = $dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:IContextualSubstitutionTable;
			
			var substitutionFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			switch(substitutionFormat)
			{
				case 1:
					result = parseContextualSubstitutionTableFormat1(data, offset);
					break;
				case 2:
					throw new Error("Contextual Substitution Table Format 2 not yet implemented.");
					break;
				case 3:
					throw new Error("Contextual Substitution Table Format 3 not yet implemented.");
					break;
			}
			
			return result;
		}
		
		private function parseContextualSubstitutionTableFormat1(data:ByteArray, offset:uint):IContextualSubstitutionTable 
		{
			var result:ContextualSubstitutionTableFormat1 = new ContextualSubstitutionTableFormat1();
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var subruleCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.subruleSetCount = subruleCount;
			
			var subruleSetOffsets:Vector.<uint> = new Vector.<uint>(subruleCount);
			for (var i:uint = 0; i < subruleCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				subruleSetOffsets[i] = offset;
			}
			result.subruleSetOffsets = subruleSetOffsets;
			
			if (coverageOffset > 0)
			{
				var coverage:ICoverageTable = _coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			var subruleSetTables:Vector.<SubRuleSetTable> = parseSubruleSetTables(data, subruleSetOffsets, offset);
			result.subruleSetTables = subruleSetTables;
			
			return result;
		}
		
		private function parseSubruleSetTables(data:ByteArray, subruleSetOffsets:Vector.<uint>, offset:uint):Vector.<SubRuleSetTable> 
		{
			const l:uint = subruleSetOffsets.length;
			var result:Vector.<SubRuleSetTable> = new Vector.<SubRuleSetTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var subruleSetOffset:uint = subruleSetOffsets[i];
				var subRuleSetTable:SubRuleSetTable = parseSubruleSetTable(data, offset + subruleSetOffset);
				result[i] = subRuleSetTable;
			}
			
			return result;
		}
		
		private function parseSubruleSetTable(data:ByteArray, offset:uint):SubRuleSetTable 
		{
			data.position = offset;
			
			var result:SubRuleSetTable = new SubRuleSetTable();
			
			var subruleCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.subRuleCount = subruleCount;
			
			var subRuleOffsets:Vector.<uint> = new Vector.<uint>(subruleCount);
			for (var i:uint = 0; i < subruleCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				subRuleOffsets[i] = offset;
			}
			result.subRuleOffsets = subRuleOffsets;
			
			var subRules:Vector.<SubRuleTable> = parseSubRules(data, subRuleOffsets, offset);
			
			return result;
		}
		
		private function parseSubRules(data:ByteArray, subRuleOffsets:Vector.<uint>, offset:uint):Vector.<SubRuleTable> 
		{
			const l:uint = subRuleOffsets.length;
			var result:Vector.<SubRuleTable> = new Vector.<SubRuleTable>();
			
			for (var i:uint = 0; i < l; i++)
			{
				var subRuleOffset:uint = subRuleOffset[i];
				var subRule:SubRuleTable = parseSubRule(data, subRuleOffset + offset);
				result[i] = subRule;
			}
			
			return result;
		}
		
		private function parseSubRule(data:ByteArray, offset:uint):SubRuleTable 
		{
			data.position = offset;
			
			var result:SubRuleTable = new SubRuleTable();
			
			var glyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.glyphCount = glyphCount;
			
			var substitutionLookupCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.substitutionLookupCount = substitutionLookupCount;
			
			var inputGlyphIDs:Vector.<uint> = new Vector.<uint>(glyphCount - 1);
			for (var i:uint = 0; i < glyphCount - 1; i++)
			{
				var glyphID:uint = _dataTypeParser.parseUnsignedShort(data);
				inputGlyphIDs[i] = glyphID;
			}
			result.inputGlyphIDs = inputGlyphIDs;
			
			var substitutionLookupRecords:Vector.<SubstitutionLookupRecord> = new Vector.<SubstitutionLookupRecord>(substitutionLookupCount);
			for (i = 0; i < substitutionLookupCount; i++)
			{
				var record:SubstitutionLookupRecord = parseSubstitutionLookupRecord(data);
				substitutionLookupRecords[i] = record;
			}
			result.substitutionLookupRecords = substitutionLookupRecords;
			
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