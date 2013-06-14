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
				values.length = valueCount; 
				 
				value = _valueRecordParser.parseValueRecord(data, valueFormat); 
				values[0] = value; 
			} 
			else if (posFormat == 2) 
			{ 
				valueCount = _dataTypeParser.parseUnsignedShort(data); 
				values.length = valueCount; 
				for (var i:uint = 0; i < valueCount; i++) 
				{ 
					value = _valueRecordParser.parseValueRecord(data, valueFormat); 
					values[i] = value; 
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
