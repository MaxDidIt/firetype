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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LigatureSetTable  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _ligatureCount:uint; 
		private var _ligatureOffsets:Vector.<uint>; 
		private var _ligatures:Vector.<LigatureTable>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LigatureSetTable()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get ligatureCount():uint  
		{ 
			return _ligatureCount; 
		} 
		 
		public function set ligatureCount(value:uint):void  
		{ 
			_ligatureCount = value; 
		} 
		 
		public function get ligatureOffsets():Vector.<uint>  
		{ 
			return _ligatureOffsets; 
		} 
		 
		public function set ligatureOffsets(value:Vector.<uint>):void  
		{ 
			_ligatureOffsets = value; 
		} 
		 
		public function get ligatures():Vector.<LigatureTable>  
		{ 
			return _ligatures; 
		} 
		 
		public function set ligatures(value:Vector.<LigatureTable>):void  
		{ 
			_ligatures = value; 
		} 
		 
	} 
} 
