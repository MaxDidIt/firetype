package de.maxdidit.hardware.font.data.tables.common.script 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ScriptRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _scriptTag:String;
		private var _scriptOffset:uint;
		private var _script:ScriptTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ScriptRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get scriptTag():String
		{
			return _scriptTag;
		}
		
		public function set scriptTag(value:String):void 
		{
			_scriptTag = value;
		}
		
		public function get scriptOffset():uint 
		{
			return _scriptOffset;
		}
		
		public function set scriptOffset(value:uint):void 
		{
			_scriptOffset = value;
		}
		
		public function get script():ScriptTable 
		{
			return _script;
		}
		
		public function set script(value:ScriptTable):void 
		{
			_script = value;
		}
		
	}

}