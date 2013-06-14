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
 
package de.maxdidit.hardware.font.parser.tables.advanced.gpos  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class AnchorTableParser implements ISubTableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function AnchorTableParser($dataTypeParser:DataTypeParser)  
		{ 
			this._dataTypeParser = $dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */ 
		 
		public function parseTable(data:ByteArray, offset:uint):*  
		{ 
			data.position = offset; 
			 
			var result:AnchorTable = new AnchorTable(); 
			 
			var format:uint = _dataTypeParser.parseUnsignedShort(data); 
			 
			var xCoordinate:int = _dataTypeParser.parseShort(data); 
			result.xCoordinate = xCoordinate; 
			 
			var yCoordinate:int = _dataTypeParser.parseShort(data); 
			result.yCoordinate = yCoordinate; 
			 
			var anchorPointIndex:int = -1; 
			if (format == 2) 
			{ 
				anchorPointIndex = int(_dataTypeParser.parseUnsignedShort(data)); 
			} 
			result.anchorPointIndex = anchorPointIndex; 
			 
			if (format == 3) 
			{ 
				var xDeviceTableOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
				result.xDeviceTableOffset = xDeviceTableOffset; 
				 
				var yDeviceTableOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
				result.yDeviceTableOffset = yDeviceTableOffset; 
				 
				// TODO: parse device tables pointed to by offsets 
			} 
			 
			return result; 
		} 
		 
	} 
} 
