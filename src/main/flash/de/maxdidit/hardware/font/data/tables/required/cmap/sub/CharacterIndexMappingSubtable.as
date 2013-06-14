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
 
package de.maxdidit.hardware.font.data.tables.required.cmap.sub 
{
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CharacterIndexMappingSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _platformID:uint;
		private var _encodingID:uint;
		private var _offset:uint;
		
		private var _data:ICharacterIndexMappingSubtableData;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CharacterIndexMappingSubtable()
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// platformID
		
		public function get platformID():uint 
		{
			return _platformID;
		}
		
		public function set platformID(value:uint):void 
		{
			_platformID = value;
		}
		
		// encodingID
		
		public function get encodingID():uint 
		{
			return _encodingID;
		}
		
		public function set encodingID(value:uint):void 
		{
			_encodingID = value;
		}
		
		// offset
		
		public function get offset():uint 
		{
			return _offset;
		}
		
		public function set offset(value:uint):void 
		{
			_offset = value;
		}
		
		// data
		
		public function get data():ICharacterIndexMappingSubtableData 
		{
			return _data;
		}
		
		public function set data(value:ICharacterIndexMappingSubtableData):void 
		{
			_data = value;
		}
	}
	
}