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
 
package de.maxdidit.hardware.font.data.tables.required.cmap  
{ 
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.CharacterIndexMappingSubtable; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class CharacterIndexMappingTableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _version:uint; 
		private var _numTables:uint; 
		 
		private var _subTables:Vector.<CharacterIndexMappingSubtable>; 
		private var _tableMap:Object; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function CharacterIndexMappingTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// version 
		 
		public function get version():uint  
		{ 
			return _version; 
		} 
		 
		public function set version(value:uint):void  
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
		 
		// subTables 
		 
		public function get subTables():Vector.<CharacterIndexMappingSubtable>  
		{ 
			return _subTables; 
		} 
		 
		public function set subTables(value:Vector.<CharacterIndexMappingSubtable>):void  
		{ 
			if (_subTables != value) 
			{ 
				_subTables = value; 
				mapSubTables(); 
			} 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		public function getGlyphIndex(charCode:Number, platformID:int, encodingID:int):int 
		{ 
			var subTable:CharacterIndexMappingSubtable = _tableMap[platformID][encodingID]; 
			if (!subTable) 
			{ 
				return -1; 
			} 
			 
			var glyphIndex:int = subTable.data.getGlyphIndex(charCode); 
			 
			return glyphIndex; 
		} 
		 
		private function mapSubTables():void  
		{ 
			if (!_subTables) 
			{ 
				return; 
			} 
			 
			var tableMap:Object = new Object(); 
			const l:uint = _subTables.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var subtable:CharacterIndexMappingSubtable = _subTables[i]; 
				 
				var platformID:String = String(subtable.platformID); 
				var encodingID:String = String(subtable.encodingID); 
				 
				var subMap:Object; 
				if (tableMap.hasOwnProperty(String(platformID))) 
				{ 
					subMap = tableMap[platformID]; 
				} 
				else 
				{ 
					subMap = new Object(); 
					tableMap[platformID] = subMap; 
				} 
				 
				subMap[encodingID] = subtable; 
			} 
			 
			_tableMap = tableMap; 
		} 
		 
	} 
} 
