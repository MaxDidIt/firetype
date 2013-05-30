package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.common.device.DeviceTableData;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.DeviceTableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ValueRecordParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _deviceTableParser:DeviceTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ValueRecordParser($dataTypeParser:DataTypeParser, $deviceTableParser:DeviceTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._deviceTableParser = $deviceTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function parseValueRecord(data:ByteArray, valueFormat:ValueFormat):ValueRecord
		{
			var result:ValueRecord = new ValueRecord();
			
			if (valueFormat.xPlacement)
			{
				result.xPlacement = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yPlacement)
			{
				result.yPlacement = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.xAdvance)
			{
				result.xAdvance = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yAdvance)
			{
				result.yAdvance = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.xPlacementDevice)
			{
				result.xPlacementDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yPlacementDevice)
			{
				result.yPlacementDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.xAdvanceDevice)
			{
				result.xAdvanceDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yAdvanceDevice)
			{
				result.yAdvanceDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			return result;
		}
		
		public function parseDeviceTables(data:ByteArray, record:ValueRecord, offset:uint):void 
		{
			if (record.xPlacementDeviceOffset > 0)
			{
				var deviceTable:DeviceTableData = _deviceTableParser.parseTable(data, offset + record.xPlacementDeviceOffset);
				record.xPlacementDeviceTable = deviceTable;
			}
			
			if (record.yPlacementDeviceOffset > 0)
			{
				deviceTable = _deviceTableParser.parseTable(data, offset + record.yPlacementDeviceOffset);
				record.yPlacementDeviceTable = deviceTable;
			}
			
			if (record.xAdvanceDeviceOffset > 0)
			{
				deviceTable = _deviceTableParser.parseTable(data, offset + record.xAdvanceDeviceOffset);
				record.xAdvanceDeviceTable = deviceTable;
			}
			
			if (record.yAdvanceDeviceOffset > 0)
			{
				deviceTable = _deviceTableParser.parseTable(data, offset + record.yAdvanceDeviceOffset);
				record.yAdvanceDeviceTable = deviceTable;
			}
		}
		
	}

}