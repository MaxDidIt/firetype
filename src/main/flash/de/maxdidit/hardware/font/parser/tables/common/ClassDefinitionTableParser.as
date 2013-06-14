/* 
Copyright ©2013 Max Knoblich 
 
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
 
package de.maxdidit.hardware.font.parser.tables.common 
{
	import de.maxdidit.hardware.font.data.tables.common.classes.ClassDefinitionTableData1;
	import de.maxdidit.hardware.font.data.tables.common.classes.ClassDefinitionTableData2;
	import de.maxdidit.hardware.font.data.tables.common.classes.ClassRangeRecord;
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ClassDefinitionTableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ClassDefinitionTableParser(dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			var result:IClassDefinitionTable;
			
			if (format == 1)
			{
				result = parseClassDefinitionTable1(data);
				(result as ClassDefinitionTableData1).classFormat = format;
			}
			else if (format == 2)
			{
				result = parseClassDefinitionTable2(data);
				(result as ClassDefinitionTableData2).classFormat = format;
			}
			else
			{
				// class definition table format not supported
				// TODO: feedback to the user
				return null;
			}
			
			return result;
		}
		
		private function parseClassDefinitionTable1(data:ByteArray):ClassDefinitionTableData1 
		{
			var result:ClassDefinitionTableData1 = new ClassDefinitionTableData1();
			
			result.startGlyphID = _dataTypeParser.parseUnsignedShort(data);
			result.glyphCount = _dataTypeParser.parseUnsignedShort(data);
			
			var classValues:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < result.glyphCount; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				classValues.push(value);
			}
			
			result.classValues = classValues;
			
			return result;
		}
		
		private function parseClassDefinitionTable2(data:ByteArray):ClassDefinitionTableData2
		{
			var result:ClassDefinitionTableData2 = new ClassDefinitionTableData2();
			
			result.classRangeCount = _dataTypeParser.parseUnsignedShort(data);
			result.classRangeRecords = parseClassRangeRecords(data, result.classRangeCount);
			
			return result;
		}
		
		private function parseClassRangeRecords(data:ByteArray, classRangeCount:uint):Vector.<ClassRangeRecord> 
		{
			var records:Vector.<ClassRangeRecord> = new Vector.<ClassRangeRecord>();
			
			for (var i:uint = 0; i < classRangeCount; i++)
			{
				var record:ClassRangeRecord = new ClassRangeRecord();
				record.start = _dataTypeParser.parseUnsignedShort(data);
				record.end = _dataTypeParser.parseUnsignedShort(data);
				record.classValue = _dataTypeParser.parseUnsignedShort(data);
				
				records.push(record);
			}
			
			return records;
		}
		
	}

}