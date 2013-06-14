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