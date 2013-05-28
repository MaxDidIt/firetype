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
		
		private var _languageSystemMap:Object;
		
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
			mapLanguageSystemRecords();
		}
		
		public function get defaultLanguageSystemTable():LanguageSystemTable 
		{
			return _defaultLanguageSystemTable;
		}
		
		public function set defaultLanguageSystemTable(value:LanguageSystemTable):void 
		{
			_defaultLanguageSystemTable = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function mapLanguageSystemRecords():void 
		{
			if (!_languageSystemMap)
			{
				_languageSystemMap = new Object();
			}
			
			const l:uint = _languageSystemRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var languageSystemRecord:LanguageSystemRecord = _languageSystemRecords[i];
				_languageSystemMap[languageSystemRecord.languageSystemTag] = languageSystemRecord;
			}
		}
		
		public function retrieveLanguageSystemTable(tag:String):LanguageSystemTable
		{
			if (!_languageSystemMap.hasOwnProperty(tag))
			{
				return _defaultLanguageSystemTable;
			}
			
			var languageSystemRecord:LanguageSystemRecord = _languageSystemMap[tag] as LanguageSystemRecord;
			return languageSystemRecord.languageSystemTable;
		}
	}

}