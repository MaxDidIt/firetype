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
 
package de.maxdidit.hardware.font.data.tables.common.coverage  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class RangeRecord  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _start:uint; 
		private var _end:uint; 
		private var _startCoverageIndex:uint; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function RangeRecord()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// start 
		 
		public function get start():uint  
		{ 
			return _start; 
		} 
		 
		public function set start(value:uint):void  
		{ 
			_start = value; 
		} 
		 
		// end 
		 
		public function get end():uint 
		{ 
			return _end; 
		} 
		 
		public function set end(value:uint):void  
		{ 
			_end = value; 
		} 
		 
		// startCoverageIndex 
		 
		public function get startCoverageIndex():uint  
		{ 
			return _startCoverageIndex; 
		} 
		 
		public function set startCoverageIndex(value:uint):void  
		{ 
			_startCoverageIndex = value; 
		} 
		 
		 
		 
	} 
} 
