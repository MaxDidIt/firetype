/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
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
