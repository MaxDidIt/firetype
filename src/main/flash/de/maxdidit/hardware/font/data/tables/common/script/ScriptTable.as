package de.maxdidit.hardware.font.data.tables.common.script 
{
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemRecord;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ScriptTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _offset:uint;
		private var _languageSystemCount:uint;
		private var _languageSystemRecords:Vector.<LanguageSystemRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ScriptTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get offset():uint 
		{
			return _offset;
		}
		
		public function set offset(value:uint):void 
		{
			_offset = value;
		}
		
		public function get languageSystemCount():uint 
		{
			return _languageSystemCount;
		}
		
		public function set languageSystemCount(value:uint):void 
		{
			_languageSystemCount = value;
		}
		
		public function get languageSystemRecords():Vector.<LanguageSystemRecord> 
		{
			return _languageSystemRecords;
		}
		
		public function set languageSystemRecords(value:Vector.<LanguageSystemRecord>):void 
		{
			_languageSystemRecords = value;
		}
		
	}

}