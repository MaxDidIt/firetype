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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef.caret  
{ 
	import de.maxdidit.hardware.font.data.tables.common.device.DeviceTableData; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class CaretValue3 implements ICaretValue 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _format:uint; 
		private var _coordinate:int; 
		 
		private var _deviceTableOffset:uint; 
		private var _deviceTable:DeviceTableData; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function CaretValue3()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// format 
		 
		public function get format():uint  
		{ 
			return 3; 
		} 
		 
		// coordinate 
		 
		public function get coordinate():int  
		{ 
			return _coordinate; 
		} 
		 
		public function set coordinate(value:int):void  
		{ 
			_coordinate = value; 
		} 
		 
		// deviceTableOffset 
		 
		public function get deviceTableOffset():uint  
		{ 
			return _deviceTableOffset; 
		} 
		 
		public function set deviceTableOffset(value:uint):void  
		{ 
			_deviceTableOffset = value; 
		} 
		 
		// deviceTable 
		 
		public function get deviceTable():DeviceTableData  
		{ 
			return _deviceTable; 
		} 
		 
		public function set deviceTable(value:DeviceTableData):void  
		{ 
			_deviceTable = value; 
		} 
		 
	} 
} 
