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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairValueRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _secondGlyphID:uint;
		private var _value1:ValueRecord;
		private var _value2:ValueRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairValueRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get secondGlyphID():uint 
		{
			return _secondGlyphID;
		}
		
		public function set secondGlyphID(value:uint):void 
		{
			_secondGlyphID = value;
		}
		
		public function get value1():ValueRecord 
		{
			return _value1;
		}
		
		public function set value1(value:ValueRecord):void 
		{
			_value1 = value;
		}
		
		public function get value2():ValueRecord 
		{
			return _value2;
		}
		
		public function set value2(value:ValueRecord):void 
		{
			_value2 = value;
		}
		
	}

}