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
 
package de.maxdidit.hardware.font.data.tables 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TableRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _tag:String;
		private var _checkSum:uint;
		private var _offset:uint;
		private var _length:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TableRecord()
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// tag
		
		public function get tag():String 
		{
			return _tag;
		}
		
		public function set tag(value:String):void 
		{
			_tag = value;
		}
		
		// checkSum
		
		public function get checkSum():uint 
		{
			return _checkSum;
		}
		
		public function set checkSum(value:uint):void 
		{
			_checkSum = value;
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
		
		// length
		
		public function get length():uint 
		{
			return _length;
		}
		
		public function set length(value:uint):void 
		{
			_length = value;
		}
		
	}

}