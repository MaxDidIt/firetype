package de.maxdidit.hardware.font.parser.tables.common 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.CoverageTableData1;
	import de.maxdidit.hardware.font.data.tables.common.coverage.CoverageTableData2;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.RangeRecord;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CoverageTableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CoverageTableParser(dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint ):* 
		{
			data.position = offset;
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			var result:ICoverageTable;
			
			if (format == 1)
			{
				result = parseCoverageTable1(data);
				(result as CoverageTableData1).format = format;
			}
			else if (format == 2)
			{
				result = parseCoverageTable2(data);
				(result as CoverageTableData2).format = format;
			}
			else
			{
				// class definition table format not supported
				// TODO: feedback to the user
				return null;
			}
			
			return result;
		}
		
		private function parseCoverageTable1(data:ByteArray):ICoverageTable 
		{
			var result:CoverageTableData1 = new CoverageTableData1();
			
			result.glyphCount = _dataTypeParser.parseUnsignedShort(data);
			
			var glyphIDs:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < result.glyphCount; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				glyphIDs.push(value);
			}
			
			result.glyphIDs = glyphIDs;
			
			return result;
		}
		
		private function parseCoverageTable2(data:ByteArray):ICoverageTable
		{
			var result:CoverageTableData2 = new CoverageTableData2();
			
			result.rangeCount = _dataTypeParser.parseUnsignedShort(data);
			result.rangeRecords = parseRangeRecords(data, result.rangeCount);
			
			return result;
		}
		
		private function parseRangeRecords(data:ByteArray, rangeCount:uint):Vector.<RangeRecord> 
		{
			var records:Vector.<RangeRecord> = new Vector.<RangeRecord>();
			
			for (var i:uint = 0; i < rangeCount; i++)
			{
				var record:RangeRecord = new RangeRecord();
				record.start = _dataTypeParser.parseUnsignedShort(data);
				record.end = _dataTypeParser.parseUnsignedShort(data);
				record.startCoverageIndex = _dataTypeParser.parseUnsignedShort(data);
				
				records.push(record);
			}
			
			return records;
		}
		
	}

}