package de.maxdidit.hardware.font.parser.tables.required 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.hhea.HorizontalHeaderData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HorizontalHeaderParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HorizontalHeaderParser($dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = $dataTypeParser;	
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			data.position = record.offset;
			
			var result:HorizontalHeaderData = new HorizontalHeaderData();
			
			result.version = _dataTypeParser.parseFixed(data);
			
			result.ascender = _dataTypeParser.parseShort(data);
			result.descender = _dataTypeParser.parseShort(data);
			result.lineGap = _dataTypeParser.parseShort(data);
			
			result.advanceWidthMax = _dataTypeParser.parseUnsignedShort(data);
			result.minLeftSideBearing = _dataTypeParser.parseShort(data);
			result.minRightSideBearing = _dataTypeParser.parseShort(data);
			
			result.xMaxExtend = _dataTypeParser.parseShort(data);
			
			result.caretSlopeRise = _dataTypeParser.parseShort(data);
			result.caretSlopeRun = _dataTypeParser.parseShort(data);
			result.caretOffset = _dataTypeParser.parseShort(data);
			
			// skip 4 reserved short integers
			data.position += 8;
			
			result.metricDataFormat = _dataTypeParser.parseShort(data);
			result.numberOfHMetrics = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
		
	}

}