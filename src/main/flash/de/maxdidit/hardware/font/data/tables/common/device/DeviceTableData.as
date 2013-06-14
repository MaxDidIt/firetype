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
 
package de.maxdidit.hardware.font.data.tables.common.device 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class DeviceTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _startSize:uint;
		private var _endSize:uint;
		
		private var _deltaFormat:uint;
		private var _deltaValues:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function DeviceTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// startSize
		
		public function get startSize():uint 
		{
			return _startSize;
		}
		
		public function set startSize(value:uint):void 
		{
			_startSize = value;
		}
		
		// endSize
		
		public function get endSize():uint 
		{
			return _endSize;
		}
		
		public function set endSize(value:uint):void 
		{
			_endSize = value;
		}
		
		// deltaFormat
		
		public function get deltaFormat():uint 
		{
			return _deltaFormat;
		}
		
		public function set deltaFormat(value:uint):void 
		{
			_deltaFormat = value;
			// TODO: can't be anything else than 1, 2 or 3
		}
		
		// deltaValues
		
		public function get deltaValues():Vector.<uint> 
		{
			return _deltaValues;
		}
		
		public function set deltaValues(value:Vector.<uint>):void 
		{
			_deltaValues = value;
		}
		
	}

}