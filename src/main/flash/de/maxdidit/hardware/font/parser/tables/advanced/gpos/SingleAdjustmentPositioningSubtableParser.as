package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.single.SingleAdjustmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleAdjustmentPositioningSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageParser:CoverageTableParser;
		
		private var _valueFormatParser:ValueFormatParser;
		private var _valueRecordParser:ValueRecordParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SingleAdjustmentPositioningSubtableParser($dataTypeParser:DataTypeParser, $coverageParser:CoverageTableParser, $valueFormatParser:ValueFormatParser, $valueRecordParser:ValueRecordParser) 
		{
			this._coverageParser = $coverageParser;
			this._dataTypeParser = $dataTypeParser;
			
			this._valueRecordParser = $valueRecordParser;
			this._valueFormatParser = $valueFormatParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			var result:SingleAdjustmentPositioningSubtable = new SingleAdjustmentPositioningSubtable();
			
			data.position = offset;
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var valueFormatData:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData = valueFormatData;
			
			var valueFormat:ValueFormat = _valueFormatParser.parseValueFormat(valueFormatData);
			result.valueFormat = valueFormat;
			
			var valueCount:uint;
			var values:Vector.<ValueRecord> = new Vector.<ValueRecord>();
			var value:ValueRecord;
			
			if (posFormat == 1)
			{
				valueCount = 1;
				
				value = _valueRecordParser.parseValueRecord(data, valueFormat);
				values.push(value);
			}
			else if (posFormat == 2)
			{
				valueCount = _dataTypeParser.parseUnsignedShort(data);
				for (var i:uint = 0; i < valueCount; i++)
				{
					value = _valueRecordParser.parseValueRecord(data, valueFormat);
					values.push(value);
				}
			}
			
			result.valueCount = valueCount;
			result.values = values;
			
			if (coverageOffset != 0)
			{
				var coverage:ICoverageTable = _coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			// TODO: parse value record sub tables
			
			return result;
		}
		
	}

}