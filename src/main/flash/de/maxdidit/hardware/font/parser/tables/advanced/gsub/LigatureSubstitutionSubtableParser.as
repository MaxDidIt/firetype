package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureCaretListTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature.LigatureSetTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature.LigatureSubstitutionSubtable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature.LigatureTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureSubstitutionSubtableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageTableParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._coverageTableParser = $coverageTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:LigatureSubstitutionSubtable = new LigatureSubstitutionSubtable();
			
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var ligatureSetCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureSetCount = ligatureSetCount;
			
			var ligatureSetOffsets:Vector.<uint> = new Vector.<uint>(ligatureSetCount);
			for (var i:uint = 0; i < ligatureSetCount; i++)
			{
				var ligatureSetOffset:uint = _dataTypeParser.parseUnsignedShort(data);
				ligatureSetOffsets[i] = ligatureSetOffset;
			}
			result.ligatureSetOffsets = ligatureSetOffsets;
			
			if (coverageOffset > 0)
			{
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			var ligatureSets:Vector.<LigatureSetTable> = parseLigatureSets(data, ligatureSetOffsets, offset);
			result.ligatureSets = ligatureSets;
			
			return result;
		}
		
		private function parseLigatureSets(data:ByteArray, ligatureSetOffsets:Vector.<uint>, offset:uint):Vector.<LigatureSetTable> 
		{
			const l:uint = ligatureSetOffsets.length;
			var result:Vector.<LigatureSetTable> = new Vector.<LigatureSetTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var ligatureSetOffset:uint = ligatureSetOffsets[i];
				var ligatureSet:LigatureSetTable = parseLigatureSet(data, offset + ligatureSetOffset);
				
				result[i] = ligatureSet;
			}
			
			return result;
		}
		
		private function parseLigatureSet(data:ByteArray, ligatureSetOffset:uint):LigatureSetTable 
		{
			data.position = ligatureSetOffset;
			
			var result:LigatureSetTable = new LigatureSetTable();
			
			var ligatureCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureCount = ligatureCount;
			
			var ligatureOffsets:Vector.<uint> = new Vector.<uint>(ligatureCount);
			for (var i:uint = 0; i < ligatureCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				ligatureOffsets[i] = offset;
			}
			result.ligatureOffsets = ligatureOffsets;
			
			var ligatures:Vector.<LigatureTable> = parseLigatures(data, ligatureOffsets, ligatureSetOffset);
			result.ligatures = ligatures;
			
			return result;
		}
		
		private function parseLigatures(data:ByteArray, ligatureOffsets:Vector.<uint>, ligatureSetOffset:uint):Vector.<LigatureTable> 
		{
			const l:uint = ligatureOffsets.length;
			var result:Vector.<LigatureTable> = new Vector.<LigatureTable>();
			
			for (var i:uint = 0; i < l; i++)
			{
				var offset:uint = ligatureOffsets[i];
				var ligature:LigatureTable = parseLigature(data, ligatureSetOffset + offset);
				
				result[i] = ligature;
			}
			
			return result;
		}
		
		private function parseLigature(data:ByteArray, offset:uint):LigatureTable 
		{
			data.position = offset;
			
			var result:LigatureTable = new LigatureTable();
			
			var ligatureGlyphID:uint = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureGlyphID = ligatureGlyphID;
			
			var componentCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.componentCount = componentCount;
			
			var componentGlyphIDs:Vector.<uint> = new Vector.<uint>(componentCount - 1);
			for (var i:uint = 0; i < componentCount - 1; i++)
			{
				var id:uint = _dataTypeParser.parseUnsignedShort(data);
				componentGlyphIDs[i] = id;
			}
			result.componentGlyphIDs = componentGlyphIDs;
			
			return result;
		}
		
	}

}