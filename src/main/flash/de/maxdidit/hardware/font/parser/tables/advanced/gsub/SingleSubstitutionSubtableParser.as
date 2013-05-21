package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.single.SingleSubstitutionSubtable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleSubstitutionSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageTableParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SingleSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser)
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
			
			var result:SingleSubstitutionSubtable = new SingleSubstitutionSubtable();
			
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			if (format == 1)
			{
				var deltaGlyphID:int = _dataTypeParser.parseShort(data);
				result.deltaGlyphID = deltaGlyphID;
				
				result.substituteGlyphCount = 0;
			}
			else if (format == 2)
			{
				var glyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
				result.substituteGlyphCount = glyphCount;
				
				var substituteGlyphIDs:Vector.<uint> = new Vector.<uint>(glyphCount);
				for (var i:uint = 0; i < glyphCount; i++)
				{
					substituteGlyphIDs[i] = _dataTypeParser.parseUnsignedShort(data);
				}
				result.substituteGlyphIDs = substituteGlyphIDs;
			}
			
			if (coverageOffset > 0)
			{
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			return result;
		}
		
	}

}