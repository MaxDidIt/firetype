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
 
package de.maxdidit.hardware.font.parser.tables.required  
{ 
	import de.maxdidit.hardware.font.data.ITableMap; 
	import de.maxdidit.hardware.font.data.tables.required.maxp.MaximumProfileTableData; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class MaximumProfileTableParser implements ITableParser 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function MaximumProfileTableParser(dataTypeParser:DataTypeParser)  
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
			 
			var result:MaximumProfileTableData = new MaximumProfileTableData(); 
			 
			result.version = _dataTypeParser.parseFixed(data); 
			result.numGlyphs = _dataTypeParser.parseUnsignedShort(data); 
			 
			if (result.version == 0.5) 
			{ 
				// in version 0.5, numGlyphs is the only field in the table 
				return result; 
			} 
			 
			result.maxPoints = _dataTypeParser.parseUnsignedShort(data); 
			result.maxContours = _dataTypeParser.parseUnsignedShort(data); 
			result.maxCompositePoints = _dataTypeParser.parseUnsignedShort(data); 
			result.maxCompositeContours = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.maxZones = _dataTypeParser.parseUnsignedShort(data); 
			result.maxTwilightPoint = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.maxStorage = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.maxFunctionDefs = _dataTypeParser.parseUnsignedShort(data); 
			result.maxInstructionDefs = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.maxStackElements = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.maxSizeOfInstructions = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.maxComponentElements = _dataTypeParser.parseUnsignedShort(data); 
			result.maxComponentDepth = _dataTypeParser.parseUnsignedShort(data); 
			 
			return result; 
		} 
		 
	} 
} 
