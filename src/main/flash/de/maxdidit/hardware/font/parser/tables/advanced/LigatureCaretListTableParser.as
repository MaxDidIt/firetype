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
 
package de.maxdidit.hardware.font.parser.tables.advanced  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.CaretValue1; 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.CaretValue2; 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.CaretValue3; 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.ICaretValue; 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureCaretListTableData; 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureGlyphTable; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser; 
	import de.maxdidit.hardware.font.parser.tables.common.DeviceTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LigatureCaretListTableParser implements ISubTableParser 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LigatureCaretListTableParser(dataTypeParser:DataTypeParser)  
		{ 
			this._dataTypeParser = dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */ 
		 
		public function parseTable(data:ByteArray, offset:uint):*  
		{ 
			data.position = offset; 
			 
			var result:LigatureCaretListTableData = new LigatureCaretListTableData(); 
			 
			result.coverageOffset = _dataTypeParser.parseUnsignedShort(data); 
			result.ligatureGlyphCount = _dataTypeParser.parseUnsignedShort(data); 
			 
			var ligatureGlyphTableOffsets:Vector.<uint> = new Vector.<uint>(); 
			for (var i:uint = 0; i < result.ligatureGlyphCount; i++ ) 
			{ 
				var offset:uint = _dataTypeParser.parseUnsignedShort(data); 
				ligatureGlyphTableOffsets.push(offset); 
			} 
			result.ligatureGlyphTableOffsets = ligatureGlyphTableOffsets; 
			 
			var coverageParser:CoverageTableParser = new CoverageTableParser(_dataTypeParser); 
			result.coverage = coverageParser.parseTable(data, offset + result.coverageOffset); 
			 
			var ligatureGlyphTables:Vector.<LigatureGlyphTable> = new Vector.<LigatureGlyphTable>(); 
			for (i = 0; i < result.ligatureGlyphCount; i++) 
			{ 
				var ligatureGlyphTable:LigatureGlyphTable = parseLigatureGlyphTable(data, offset + result.ligatureGlyphTableOffsets[i]); 
				ligatureGlyphTables.push(ligatureGlyphTable); 
			} 
			result.ligatureGlyphTables = ligatureGlyphTables; 
			 
			return result; 
		} 
		 
		private function parseLigatureGlyphTable(data:ByteArray, offset:uint):LigatureGlyphTable  
		{ 
			data.position = offset; 
			 
			var result:LigatureGlyphTable = new LigatureGlyphTable(); 
			 
			result.caretCount = _dataTypeParser.parseUnsignedShort(data); 
			 
			var caretValueOffsets:Vector.<uint> = new Vector.<uint>(); 
			for (var i:uint = 0; i < result.caretCount; i++ ) 
			{ 
				var offset:uint = _dataTypeParser.parseUnsignedShort(data); 
				caretValueOffsets.push(offset); 
			} 
			result.caretValueOffsets = caretValueOffsets; 
			 
			var caretValues:Vector.<ICaretValue> = new Vector.<ICaretValue>(); 
			for (i = 0; i < result.caretCount; i++) 
			{ 
				var caretValue:ICaretValue = parseCaretValue(data, offset + result.caretValueOffsets[i]); 
				caretValues.push(caretValue); 
			} 
			result.caretValues = caretValues; 
			 
			return result; 
		} 
		 
		private function parseCaretValue(data:ByteArray, offset:uint):ICaretValue  
		{ 
			data.position = offset; 
			 
			var format:uint = _dataTypeParser.parseUnsignedShort(data); 
			if (format == 1) 
			{ 
				var caretValue1:CaretValue1 = new CaretValue1(); 
				caretValue1.coordinate = _dataTypeParser.parseShort(data); 
				return caretValue1; 
			} 
			 
			if (format == 2) 
			{ 
				var caretValue2:CaretValue2 = new CaretValue2(); 
				caretValue2.pointIndex = _dataTypeParser.parseUnsignedShort(data); 
				return caretValue2; 
			} 
			 
			if (format == 3) 
			{ 
				var caretValue3:CaretValue3 = new CaretValue3(); 
				caretValue3.coordinate = _dataTypeParser.parseUnsignedShort(data); 
				caretValue3.deviceTableOffset = _dataTypeParser.parseUnsignedShort(data); 
				 
				var deviceTableParser:DeviceTableParser = new DeviceTableParser(_dataTypeParser); 
				caretValue3.deviceTable = deviceTableParser.parseTable(data, offset + caretValue3.deviceTableOffset); 
				 
				return caretValue3; 
			} 
			 
			return null; 
		} 
		 
	} 
} 
