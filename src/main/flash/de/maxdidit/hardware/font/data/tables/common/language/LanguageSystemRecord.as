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