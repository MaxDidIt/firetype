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
 
package de.maxdidit.hardware.font.parser.tables.truetype  
{ 
	import de.maxdidit.hardware.font.data.ITableMap; 
	import de.maxdidit.hardware.font.data.tables.required.head.FontHeaderData; 
	import de.maxdidit.hardware.font.data.tables.required.maxp.MaximumProfileTableData; 
	import de.maxdidit.hardware.font.data.tables.Table; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.data.tables.truetype.LocationTableData; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import de.maxdidit.hardware.font.parser.tables.TableNames; 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LocationTableParser implements ITableParser 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LocationTableParser(dataTypeParser:DataTypeParser)  
		{ 
			this._dataTypeParser = dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */ 
		 
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):*  
		{ 
			data.position = record.offset; 
			 
			var result:LocationTableData = new LocationTableData(); 
			 
			var fontHeader:Table = tableMap.retrieveTable(TableNames.FONT_HEADER); 
			var maximumProfile:Table = tableMap.retrieveTable(TableNames.MAXIMUM_PROFILE); 
			 
			var numOffsets:uint = (maximumProfile.data as MaximumProfileTableData).numGlyphs; 
			var valuesAreShort:Boolean = (fontHeader.data as FontHeaderData).indexToLocFormat == 0; 
			 
			var offsets:Vector.<uint> = valuesAreShort ? parseShortOffsets(data, numOffsets) : parseLongOffsets(data, numOffsets); 
			result.offsets = offsets; 
			 
			return result; 
		} 
		 
		private function parseLongOffsets(data:ByteArray, numOffsets:uint):Vector.<uint>  
		{ 
			const l:uint = numOffsets + 1; 
			var result:Vector.<uint> = new Vector.<uint>(l); 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				result[i] = _dataTypeParser.parseUnsignedLong(data); 
			} 
			 
			return result; 
		} 
		 
		private function parseShortOffsets(data:ByteArray, numOffsets:uint):Vector.<uint>  
		{ 
			const l:uint = numOffsets + 1; 
			var result:Vector.<uint> = new Vector.<uint>(l); 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				result[i] = _dataTypeParser.parseUnsignedShort(data) << 1; // The actual local offset divided by 2 is stored in the byte array. 
			} 
			 
			return result; 
		} 
		 
	} 
} 
