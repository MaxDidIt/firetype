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
		}
		
	}

}