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
 
package de.maxdidit.hardware.font.parser.tables.required 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.name.NameRecord;
	import de.maxdidit.hardware.font.data.tables.required.name.NamingTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NamingTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NamingTableParser(dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			var result:NamingTableData = new NamingTableData();
			
			data.position = record.offset;
			
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			result.format = format;
			
			var count:uint = _dataTypeParser.parseUnsignedShort(data);
			result.count = count;
			
			var stringOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.stringOffset = stringOffset;
			
			var nameRecords:Vector.<NameRecord> = parseNameRecords(data, count);
			result.nameRecords = nameRecords;
			
			if (format == 1)
			{
				var langTagCount:uint = _dataTypeParser.parseUnsignedShort(data);
				
				// TODO: implement language tag record parsing
				// skip language tag records for now
				data.position += langTagCount * 4;
			}
			
			parseNameStrings(data, record.offset + stringOffset, nameRecords);
			result.mapNameRecords();
			
			return result;
		}
		
		private function parseNameStrings(data:ByteArray, offset:uint, nameRecords:Vector.<NameRecord>):void 
		{
			const l:uint = nameRecords.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var currentRecord:NameRecord = nameRecords[i];
				data.position = offset + currentRecord.offset;
				
				var string:String = data.readUTFBytes(currentRecord.length);
				currentRecord.string = string;
			}
		}
		
		private function parseNameRecords(data:ByteArray, count:uint):Vector.<NameRecord> 
		{
			var result:Vector.<NameRecord> = new Vector.<NameRecord>();
			for (var i:uint = 0; i < count; i++)
			{
				var nameRecord:NameRecord = parseNameRecord(data);
				result.push(nameRecord);
			}
			
			return result;
		}
		
		private function parseNameRecord(data:ByteArray):NameRecord 
		{
			var result:NameRecord = new NameRecord();
			
			result.platformID = _dataTypeParser.parseUnsignedShort(data);
			result.encodingID = _dataTypeParser.parseUnsignedShort(data);
			result.languageID = _dataTypeParser.parseUnsignedShort(data);
			result.nameID = _dataTypeParser.parseUnsignedShort(data);
			
			result.length = _dataTypeParser.parseUnsignedShort(data);
			result.offset = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
		
	}

}