package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.SFNTWrapper;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.tables.NotYetImplementedParser;
	import de.maxdidit.hardware.font.parser.tables.required.CharacterIndexMappingTableParser;
	import de.maxdidit.hardware.font.parser.tables.other.DigitalSignatureTableParser;
	import de.maxdidit.hardware.font.parser.tables.required.FontHeaderParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.GlyphDefinitionTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.required.MaximumProfileTableParser;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.font.parser.tables.truetype.ControlValueTableParser;
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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function OpenTypeParser() 
		{
			_dataTypeParser = new DataTypeParser();
			
			initializeTableParserMap();
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
			_tableParserMap[TableNames.HORIZONTAL_HEADER]			= notYetImplementedParser;
			_tableParserMap[TableNames.HORIZONTAL_METRICS]			= notYetImplementedParser;
			_tableParserMap[TableNames.MAXIMUM_PROFILE]				= new MaximumProfileTableParser(_dataTypeParser);
			_tableParserMap[TableNames.NAMING_TABLE]				= notYetImplementedParser;
			_tableParserMap[TableNames.OS2_WINDOWS_METRICS]			= notYetImplementedParser;
			_tableParserMap[TableNames.POSTSCRIPT_INFORMATION]		= notYetImplementedParser;
			
			// true type tables
			
			_tableParserMap[TableNames.CONTROL_VALUE_TABLE]			= new ControlValueTableParser(_dataTypeParser);
			_tableParserMap[TableNames.FONT_PROGRAM]			 	= notYetImplementedParser;
			_tableParserMap[TableNames.GLYPH_DATA]					= notYetImplementedParser;
			_tableParserMap[TableNames.INDEX_TO_LOCATION]			= notYetImplementedParser;
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
		
		/* INTERFACE de.maxdidit.hardware.font.parser.IFontParser */
		
		protected override function parseFontData(data:ByteArray):HardwareFontData 
		{
			data.position = 0;
			
			var hardwareFontData:HardwareFontData = new HardwareFontData();
			
			hardwareFontData.sfntWrapper = parseSFNTWrapper(data);
			hardwareFontData.tables = parseTableRecords(data, hardwareFontData.sfntWrapper.numTables);
			
			parseTables(data, hardwareFontData.tables);
			
			return hardwareFontData;
		}
		
		private function parseTables(data:ByteArray, tables:Vector.<Table>):void 
		{
			const l:uint = tables.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				parseTable(data, tables[i]);
			}
		}
		
		private function parseTable(data:ByteArray, table:Table):void 
		{
			if (!_tableParserMap.hasOwnProperty(table.record.tag))
			{
				// no appropriate table parser found
				return;
			}
			
			var tableParser:ITableParser = _tableParserMap[table.record.tag] as ITableParser;
			table.data = tableParser.parseTable(data, table.record);
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