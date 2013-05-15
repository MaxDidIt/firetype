package de.maxdidit.hardware.font.data.tables.common.language 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LanguageSystemRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _languageSystemTag:String;
		private var _languageSystemOffset:uint;
		private var _languageSystemTable:LanguageSystemTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LanguageSystemRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get languageSystemTag():String
		{
			return _languageSystemTag;
		}
		
		public function set languageSystemTag(value:String):void 
		{
			_languageSystemTag = value;
		}
		
		public function get languageSystemOffset():uint 
		{
			return _languageSystemOffset;
		}
		
		public function set languageSystemOffset(value:uint):void 
		{
			_languageSystemOffset = value;
		}
		
		public function get languageSystemTable():LanguageSystemTable 
		{
			return _languageSystemTable;
		}
		
		public function set languageSystemTable(value:LanguageSystemTable):void 
		{
			_languageSystemTable = value;
		}
		
	}

}