package de.maxdidit.hardware.font.parser.tables.required 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.head.FontHeaderData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	import de.maxdidit.hardware.font.HardwareFont;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FontHeaderParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontHeaderParser(dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			data.position = record.offset;
			
			var result:FontHeaderData = new FontHeaderData();
			
			result.tableVersion = _dataTypeParser.parseFixed(data);
			result.fontRevision = _dataTypeParser.parseFixed(data);
			
			result.checkSumAdjustment = _dataTypeParser.parseUnsignedLong(data);
			result.magicNumber = _dataTypeParser.parseUnsignedLong(data);
			
			result.flags = _dataTypeParser.parseUnsignedShort(data);
			
			result.baselineAtZero = ((result.flags) & 1) == 1;
			result.sidebearingPointAtZero = ((result.flags >> 1) & 1) == 1;
			result.dependsOnPointSize = ((result.flags >> 2) & 1) == 1;
			result.forcePPEMIntegerValues = ((result.flags >> 3) & 1) == 1;			
			result.advanceWidthAlterable = ((result.flags >> 4) & 1) == 1;
			
			result.losslessCompression = ((result.flags >> 11) & 1) == 1;
			result.fontConverted = ((result.flags >> 12) & 1) == 1;
			result.clearTypeOptimized = ((result.flags >> 13) & 1) == 1;
			result.lastResort = ((result.flags >> 14) & 1) == 1;
			
			result.unitsPerEm = _dataTypeParser.parseUnsignedShort(data);
			
			result.created = _dataTypeParser.parseLong64(data);
			result.modified = _dataTypeParser.parseLong64(data);
			
			result.xMin = _dataTypeParser.parseShort(data);
			result.yMin = _dataTypeParser.parseShort(data);
			result.xMax = _dataTypeParser.parseShort(data);
			result.yMax = _dataTypeParser.parseShort(data);
			
			result.macStyle = _dataTypeParser.parseUnsignedShort(data);
			
			result.bold = ((result.flags) & 1) == 1;
			result.italic = ((result.flags >> 1) & 1) == 1;
			result.underline = ((result.flags >> 2) & 1) == 1;
			result.outline = ((result.flags >> 3) & 1) == 1;
			result.shadow = ((result.flags >> 4) & 1) == 1;
			result.condensed = ((result.flags >> 5) & 1) == 1;
			result.extended = ((result.flags >> 6) & 1) == 1;
			
			result.lowestRecPPEM = _dataTypeParser.parseUnsignedShort(data);
			result.fontDirectionHint = _dataTypeParser.parseShort(data);
			
			result.indexToLocFormat = _dataTypeParser.parseShort(data);
			result.glyphDataFormat = _dataTypeParser.parseShort(data);
			
			return result;
		}
		
	}

}