package de.maxdidit.hardware.font.data.tables.common.script 
{
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemRecord;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ScriptTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _defaultLanguageSystemTableOffset:uint;
		private var _languageSystemCount:uint;
		private var _languageSystemRecords:Vector.<LanguageSystemRecord>;
		
		private var _defaultLanguageSystemTable:LanguageSystemTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ScriptTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get defaultLanguageSystemTableOffset():uint 
		{
			return _defaultLanguageSystemTableOffset;
		}
		
		public function set defaultLanguageSystemTableOffset(value:uint):void 
		{
			_defaultLanguageSystemTableOffset = value;
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
		
		public function get defaultLanguageSystemTable():LanguageSystemTable 
		{
			return _defaultLanguageSystemTable;
		}
		
		public function set defaultLanguageSystemTable(value:LanguageSystemTable):void 
		{
			_defaultLanguageSystemTable = value;
		}
		
	}

}