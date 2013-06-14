/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
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
