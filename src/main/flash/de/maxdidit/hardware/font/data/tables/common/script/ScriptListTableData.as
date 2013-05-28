package de.maxdidit.hardware.font.data.tables.common.script 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ScriptListTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _scriptCount:uint;
		private var _scriptRecords:Vector.<ScriptRecord>
		private var _scriptRecordMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ScriptListTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get scriptCount():uint 
		{
			return _scriptCount;
		}
		
		public function set scriptCount(value:uint):void 
		{
			_scriptCount = value;
		}
		
		public function get scriptRecords():Vector.<ScriptRecord> 
		{
			return _scriptRecords;
		}
		
		public function set scriptRecords(value:Vector.<ScriptRecord>):void 
		{
			_scriptRecords = value;
			mapScriptRecords();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function mapScriptRecords():void 
		{
			if (!_scriptRecordMap)
			{
				_scriptRecordMap = new Object();
			}
			
			const l:uint = _scriptRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var scriptRecord:ScriptRecord = _scriptRecords[i];
				_scriptRecordMap[scriptRecord.scriptTag] = scriptRecord;
			}
		}
		
		public function retrieveScriptTable(tag:String):ScriptTable
		{
			if (!_scriptRecordMap.hasOwnProperty(tag))
			{
				return null;
			}
			
			var scriptRecord:ScriptRecord = _scriptRecordMap[tag] as ScriptRecord;
			return scriptRecord.script;
		}
		
	}

}