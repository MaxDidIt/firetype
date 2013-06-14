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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class BaseRecord  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		private var _baseAnchorOffsets:Vector.<uint>; 
		private var _baseAnchors:Vector.<AnchorTable>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function BaseRecord()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get baseAnchorOffsets():Vector.<uint>  
		{ 
			return _baseAnchorOffsets; 
		} 
		 
		public function set baseAnchorOffsets(value:Vector.<uint>):void  
		{ 
			_baseAnchorOffsets = value; 
		} 
		 
		public function get baseAnchors():Vector.<AnchorTable>  
		{ 
			return _baseAnchors; 
		} 
		 
		public function set baseAnchors(value:Vector.<AnchorTable>):void  
		{ 
			_baseAnchors = value; 
		} 
		 
	} 
} 
