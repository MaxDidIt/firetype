package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ValueRecordParser($dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = $dataTypeParser;
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
		
	}

}