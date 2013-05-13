package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.SFNTWrapper;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.tables.NotYetImplementedParser;
	import de.maxdidit.hardware.font.parser.tables.required.CharacterIndexMappingTableParser;
	import de.maxdidit.hardware.font.parser.tables.other.DigitalSignatureTableParser;
	import de.maxdidit.hardware.font.parser.tables.required.FontHeaderParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.GlyphDefinitionTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.required.HorizontalHeaderParser;
	import de.maxdidit.hardware.font.parser.tables.required.HorizontalMetricsParser;
	import de.maxdidit.hardware.font.parser.tables.required.MaximumProfileTableParser;
	import de.maxdidit.hardware.font.parser.tables.required.NamingTableParser;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.font.parser.tables.truetype.ControlValueTableParser;
	import de.maxdidit.hardware.font.parser.tables.truetype.GlyphDataTableParser;
	import de.maxdidit.hardware.font.parser.tables.truetype.LocationTableParser;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import flash.display3D.Context3D;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class OpenTypeParser extends FontParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _tableParserMap:Object;
		private var _dataTypeParser:DataTypeParser;
		
		private var _tableParsingPriority:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function OpenTypeParser() 
		{
			super();
			
			_dataTypeParser = new DataTypeParser();
			
			initializeTableParserMap();
			initializeTableParsingPriorities();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function initializeTableParserMap():void 
		{
			_tableParserMap = new Object();
			
			var notYetImplementedParser:NotYetImplementedParser = new NotYetImplementedParser();
			
			// required tables
			
			_tableParserMap[TableNames.CHARACTER_INDEX_MAPPING]		= new CharacterIndexMappingTableParser(_dataTypeParser);
			_tableParserMap[TableNames.FONT_HEADER]					= new FontHeaderParser(_dataTypeParser);
			_tableParserMap[TableNames.HORIZONTAL_HEADER]			= new HorizontalHeaderParser(_dataTypeParser);
			_tableParserMap[TableNames.HORIZONTAL_METRICS]			= new HorizontalMetricsParser(_dataTypeParser);
			_tableParserMap[TableNames.MAXIMUM_PROFILE]				= new MaximumProfileTableParser(_dataTypeParser);
			_tableParserMap[TableNames.NAMING_TABLE]				= new NamingTableParser(_dataTypeParser);
			_tableParserMap[TableNames.OS2_WINDOWS_METRICS]			= notYetImplementedParser;
			_tableParserMap[TableNames.POSTSCRIPT_INFORMATION]		= notYetImplementedParser;
			
			// true type tables
			
			_tableParserMap[TableNames.CONTROL_VALUE_TABLE]			= new ControlValueTableParser(_dataTypeParser);
			_tableParserMap[TableNames.FONT_PROGRAM]			 	= notYetImplementedParser;
			_tableParserMap[TableNames.GLYPH_DATA]					= new GlyphDataTableParser(_dataTypeParser);
			_tableParserMap[TableNames.INDEX_TO_LOCATION]			= new LocationTableParser(_dataTypeParser);
			_tableParserMap[TableNames.CVT_PROGRAM]					= notYetImplementedParser;
			
			// postscript tables
			
			_tableParserMap[TableNames.POSTSCRIPT_FONT_PROGRAM]		= notYetImplementedParser;
			_tableParserMap[TableNames.VERTICAL_ORIGIN]				= notYetImplementedParser;
			
			// bitmap glyph tables
			
			_tableParserMap[TableNames.EMBEDDED_BITMAP_DATA]		= notYetImplementedParser;
			_tableParserMap[TableNames.EMBEDDED_BITMAP_LOCATIONS]	= notYetImplementedParser;
			_tableParserMap[TableNames.EMBEDDED_BITMAP_SCALING]		= notYetImplementedParser;
			
			// advanced tables
			
			_tableParserMap[TableNames.BASELINE_DATA]				= notYetImplementedParser;
			_tableParserMap[TableNames.GLYPH_DEFINITION_DATA]		= new GlyphDefinitionTableParser(_dataTypeParser);
			_tableParserMap[TableNames.GLYPH_POSITIONING_DATA]		= notYetImplementedParser;
			_tableParserMap[TableNames.GLYPH_SUBSTITUTION_DATA]		= notYetImplementedParser;
			_tableParserMap[TableNames.JUSTIFICATION_DATA]			= notYetImplementedParser;
			
			// other opentype tables
			
			_tableParserMap[TableNames.DIGITAL_SIGNATURE]			= new DigitalSignatureTableParser(_dataTypeParser);
			_tableParserMap[TableNames.GRID_FITTING]				= notYetImplementedParser;
			_tableParserMap[TableNames.HORIZONTAL_DEVICE_METRICS]	= notYetImplementedParser;
			_tableParserMap[TableNames.KERNING]						= notYetImplementedParser;
			_tableParserMap[TableNames.LINEAR_THRESHOLD_DATA]		= notYetImplementedParser;
			_tableParserMap[TableNames.PCL5_DATA]					= notYetImplementedParser;
			_tableParserMap[TableNames.VERTICAL_DEVICE_METRICS]		= notYetImplementedParser;
			_tableParserMap[TableNames.VERTICAL_METRICS_HEADER]		= notYetImplementedParser;
			_tableParserMap[TableNames.VERTICAL_METRICS]			= notYetImplementedParser;
		}
		
		private function initializeTableParsingPriorities():void 
		{
			_tableParsingPriority = new Object();
			
			const iDontCare:uint = 0xFFFFFFFF;
			var priority:uint = 0;
			
			_tableParsingPriority[TableNames.FONT_HEADER]					= priority++; // font header should be parsed first
			_tableParsingPriority[TableNames.MAXIMUM_PROFILE]				= priority++;
			_tableParsingPriority[TableNames.INDEX_TO_LOCATION]				= priority++; // font header and maximum profile need to be parsed before this
			_tableParsingPriority[TableNames.GLYPH_DATA]					= priority++; // index to location needs to be parsed before this
			
			_tableParsingPriority[TableNames.CHARACTER_INDEX_MAPPING]		= iDontCare;
			_tableParsingPriority[TableNames.HORIZONTAL_HEADER]				= iDontCare;
			_tableParsingPriority[TableNames.HORIZONTAL_METRICS]			= iDontCare;
			_tableParsingPriority[TableNames.NAMING_TABLE]					= iDontCare;
			_tableParsingPriority[TableNames.OS2_WINDOWS_METRICS]			= iDontCare;
			_tableParsingPriority[TableNames.POSTSCRIPT_INFORMATION]		= iDontCare;
			_tableParsingPriority[TableNames.CONTROL_VALUE_TABLE]			= iDontCare;
			_tableParsingPriority[TableNames.FONT_PROGRAM]			 		= iDontCare;
			_tableParsingPriority[TableNames.CVT_PROGRAM]					= iDontCare;
			_tableParsingPriority[TableNames.POSTSCRIPT_FONT_PROGRAM]		= iDontCare;
			_tableParsingPriority[TableNames.VERTICAL_ORIGIN]				= iDontCare;
			_tableParsingPriority[TableNames.EMBEDDED_BITMAP_DATA]			= iDontCare;
			_tableParsingPriority[TableNames.EMBEDDED_BITMAP_LOCATIONS]		= iDontCare;
			_tableParsingPriority[TableNames.EMBEDDED_BITMAP_SCALING]		= iDontCare;
			_tableParsingPriority[TableNames.BASELINE_DATA]					= iDontCare;
			_tableParsingPriority[TableNames.GLYPH_DEFINITION_DATA]			= iDontCare;
			_tableParsingPriority[TableNames.GLYPH_POSITIONING_DATA]		= iDontCare;
			_tableParsingPriority[TableNames.GLYPH_SUBSTITUTION_DATA]		= iDontCare;
			_tableParsingPriority[TableNames.JUSTIFICATION_DATA]			= iDontCare;
			_tableParsingPriority[TableNames.DIGITAL_SIGNATURE]				= iDontCare;
			_tableParsingPriority[TableNames.GRID_FITTING]					= iDontCare;
			_tableParsingPriority[TableNames.HORIZONTAL_DEVICE_METRICS]		= iDontCare;
			_tableParsingPriority[TableNames.KERNING]						= iDontCare;
			_tableParsingPriority[TableNames.LINEAR_THRESHOLD_DATA]			= iDontCare;
			_tableParsingPriority[TableNames.PCL5_DATA]						= iDontCare;
			_tableParsingPriority[TableNames.VERTICAL_DEVICE_METRICS]		= iDontCare;
			_tableParsingPriority[TableNames.VERTICAL_METRICS_HEADER]		= iDontCare;
			_tableParsingPriority[TableNames.VERTICAL_METRICS]				= iDontCare;
		}
		
		/* INTERFACE de.maxdidit.hardware.font.parser.IFontParser */
		
		protected override function parseFontData(data:ByteArray):HardwareFontData 
		{
			data.position = 0;
			
			var hardwareFontData:HardwareFontData = new HardwareFontData();
			
			hardwareFontData.sfntWrapper = parseSFNTWrapper(data);
			hardwareFontData.tables = parseTableRecords(data, hardwareFontData.sfntWrapper.numTables);
			
			sortTablesForParsing(hardwareFontData.tables); // bring tables into the correct order for parsing. example: maxp has to be parsed before loca.
			
			parseTables(data, hardwareFontData.tables, hardwareFontData);
			
			return hardwareFontData;
		}
		
		private function sortTablesForParsing(tables:Vector.<Table>):void 
		{
			tables.sort(compareTablePriority);
		}
		
		private function compareTablePriority(tableA:Table, tableB:Table):Number 
		{
			var priorityA:uint = uint(_tableParsingPriority[tableA.record.tag]);
			var priorityB:uint = uint(_tableParsingPriority[tableB.record.tag]);
			
			return Number(priorityA) - Number(priorityB)
		}
		
		private function parseTables(data:ByteArray, tables:Vector.<Table>, tableMap:ITableMap):void 
		{
			const l:uint = tables.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				parseTable(data, tables[i], tableMap);
			}
		}
		
		private function parseTable(data:ByteArray, table:Table, tableMap:ITableMap):void 
		{
			if (!_tableParserMap.hasOwnProperty(table.record.tag))
			{
				// no appropriate table parser found
				return;
			}
			
			var tableParser:ITableParser = _tableParserMap[table.record.tag] as ITableParser;
			table.data = tableParser.parseTable(data, table.record, tableMap);
		}
		
		private function parseTableRecords(data:ByteArray, numRecords:uint):Vector.<Table> 
		{
			var tables:Vector.<Table> = new Vector.<Table>();
			
			for (var i:uint = 0; i < numRecords; i++)
			{
				var table:Table = new Table();
				table.record = parseTableRecord(data);
				tables.push(table);
			}
			
			return tables;
		}
		
		private function parseTableRecord(data:ByteArray):TableRecord 
		{
			var tableRecord:TableRecord = new TableRecord();
			
			tableRecord.tag = _dataTypeParser.parseUnsignedLongAsString(data);
			tableRecord.checkSum = _dataTypeParser.parseUnsignedLong(data);
			tableRecord.offset = _dataTypeParser.parseUnsignedLong(data);
			tableRecord.length = _dataTypeParser.parseUnsignedLong(data);
			
			return tableRecord;
		}
		
		private function parseSFNTWrapper(data:ByteArray):SFNTWrapper 
		{
			var sfntWrapper:SFNTWrapper = new SFNTWrapper();
			
			sfntWrapper.version = _dataTypeParser.parseSFNTVersionNumber(data);
			sfntWrapper.numTables = _dataTypeParser.parseUnsignedShort(data);
			sfntWrapper.searchRange = _dataTypeParser.parseUnsignedShort(data);
			sfntWrapper.entrySelector = _dataTypeParser.parseUnsignedShort(data);
			sfntWrapper.rangeShift = _dataTypeParser.parseUnsignedShort(data);
			
			return sfntWrapper;
		}
		
	}

}