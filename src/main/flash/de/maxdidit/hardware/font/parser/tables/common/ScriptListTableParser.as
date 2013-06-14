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
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemRecord;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptRecord;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ScriptListTableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ScriptListTableParser($dataTypeParser:DataTypeParser)
		{
			_dataTypeParser = $dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):*
		{
			data.position = offset;
			
			var result:ScriptListTableData = new ScriptListTableData();
			
			var scriptCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.scriptCount = scriptCount;
			
			var scriptRecords:Vector.<ScriptRecord> = parseScriptRecords(data, scriptCount);
			result.scriptRecords = scriptRecords;
			parseScriptTables(data, scriptRecords, offset);
			
			return result;
		}
		
		private function parseScriptTables(data:ByteArray, scriptRecords:Vector.<ScriptRecord>, offset:uint):void
		{
			var languageSystemParser:LanguageSystemParser = new LanguageSystemParser(_dataTypeParser);
			
			const l:uint = scriptRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var record:ScriptRecord = scriptRecords[i];
				var scriptTable:ScriptTable = parseScriptTable(data, languageSystemParser, record.scriptOffset + offset);
				
				record.script = scriptTable;
			}
		}
		
		private function parseScriptTable(data:ByteArray, languageSystemParser:LanguageSystemParser, offset:uint):ScriptTable
		{
			var result:ScriptTable = new ScriptTable();
			
			data.position = offset;
			
			var defaultLanguageSystemTableOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.defaultLanguageSystemTableOffset = defaultLanguageSystemTableOffset;
			var languageSystemCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.languageSystemCount = languageSystemCount;
			
			var languageSystemRecords:Vector.<LanguageSystemRecord> = parseLanguageSystemRecords(data, languageSystemCount, languageSystemParser);
			result.languageSystemRecords = languageSystemRecords;
			
			if (defaultLanguageSystemTableOffset != 0)
			{
				var defaultLanguageSystemTable:LanguageSystemTable = languageSystemParser.parseTable(data, offset + defaultLanguageSystemTableOffset);
				result.defaultLanguageSystemTable = defaultLanguageSystemTable;
			}
			
			parseLanguageSystemTables(data, languageSystemRecords, languageSystemParser, offset);
			
			return result;
		}
		
		private function parseLanguageSystemTables(data:ByteArray, languageSystemRecords:Vector.<LanguageSystemRecord>, languageSystemParser:LanguageSystemParser, offset:uint):void 
		{
			const l:uint = languageSystemRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var record:LanguageSystemRecord = languageSystemRecords[i];
				
				if (record.languageSystemOffset != 0)
				{
					var languageSystemTable:LanguageSystemTable = languageSystemParser.parseTable(data, record.languageSystemOffset + offset) as LanguageSystemTable;
					record.languageSystemTable = languageSystemTable;
				}
			}
		}
		
		private function parseLanguageSystemRecords(data:ByteArray, languageSystemCount:uint, languageSystemParser:LanguageSystemParser):Vector.<LanguageSystemRecord> 
		{
			var result:Vector.<LanguageSystemRecord> = new Vector.<LanguageSystemRecord>(languageSystemCount);
			
			for (var i:uint = 0; i < languageSystemCount; i++)
			{
				var languageSystemRecord:LanguageSystemRecord = languageSystemParser.parseLanguageSystemRecord(data);
				result[i] = languageSystemRecord;
			}
			
			return result;
		}
		
		private function parseScriptRecords(data:ByteArray, scriptCount:uint):Vector.<ScriptRecord>
		{
			var result:Vector.<ScriptRecord> = new Vector.<ScriptRecord>(scriptCount);
			
			for (var i:uint = 0; i < scriptCount; i++)
			{
				var scriptRecord:ScriptRecord = parseScriptRecord(data);
				result[i] = scriptRecord;
			}
			
			return result;
		}
		
		private function parseScriptRecord(data:ByteArray):ScriptRecord
		{
			var result:ScriptRecord = new ScriptRecord();
			
			result.scriptTag = _dataTypeParser.parseTag(data);
			result.scriptOffset = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
	
	}

}