package de.maxdidit.hardware.font.parser.tables.common 
{
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptRecord;
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
			// TODO: parse scriptTables pointed to by script records
			
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