package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.SFNTWrapper;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.tables.DigitalSignatureTableParser;
	import de.maxdidit.hardware.font.parser.tables.GlyphDefinitionTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class OpenTypeParser implements IFontParser
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
			
			_tableParserMap["DSIG"] = new DigitalSignatureTableParser(_dataTypeParser);
			_tableParserMap["GDEF"] = new GlyphDefinitionTableParser(_dataTypeParser);
		}
		
		/* INTERFACE de.maxdidit.hardware.font.parser.IFontParser */
		
		public function parseFontData(data:ByteArray):HardwareFontData 
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
			table.data = tableParser.parseTable(data, table.record.offset);
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