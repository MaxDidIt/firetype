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
 
package de.maxdidit.hardware.font.data 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SFNTWrapper 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:String;
		private var _numTables:uint;
		private var _searchRange:uint;
		private var _entrySelector:uint;
		private var _rangeShift:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SFNTWrapper() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// version
		
		public function get version():String 
		{
			return _version;
		}
		
		public function set version(value:String):void 
		{
			_version = value;
		}
		
		// numTables
		
		public function get numTables():uint 
		{
			return _numTables;
		}
		
		public function set numTables(value:uint):void 
		{
			_numTables = value;
		}
		
		// searchRange
		
		public function get searchRange():uint 
		{
			return _searchRange;
		}
		
		public function set searchRange(value:uint):void 
		{
			_searchRange = value;
		}
		
		// entrySelector
		
		public function get entrySelector():uint 
		{
			return _entrySelector;
		}
		
		public function set entrySelector(value:uint):void 
		{
			_entrySelector = value;
		}
		
		// rangeShift
		
		public function get rangeShift():uint 
		{
			return _rangeShift;
		}
		
		public function set rangeShift(value:uint):void 
		{
			_rangeShift = value;
		}
		
	}

}