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
 
package de.maxdidit.hardware.font.parser.tables.required 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.hhea.HorizontalHeaderData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HorizontalHeaderParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HorizontalHeaderParser($dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = $dataTypeParser;	
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			data.position = record.offset;
			
			var result:HorizontalHeaderData = new HorizontalHeaderData();
			
			result.version = _dataTypeParser.parseFixed(data);
			
			result.ascender = _dataTypeParser.parseShort(data);
			result.descender = _dataTypeParser.parseShort(data);
			result.lineGap = _dataTypeParser.parseShort(data);
			
			result.advanceWidthMax = _dataTypeParser.parseUnsignedShort(data);
			result.minLeftSideBearing = _dataTypeParser.parseShort(data);
			result.minRightSideBearing = _dataTypeParser.parseShort(data);
			
			result.xMaxExtend = _dataTypeParser.parseShort(data);
			
			result.caretSlopeRise = _dataTypeParser.parseShort(data);
			result.caretSlopeRun = _dataTypeParser.parseShort(data);
			result.caretOffset = _dataTypeParser.parseShort(data);
			
			// skip 4 reserved short integers
			data.position += 8;
			
			result.metricDataFormat = _dataTypeParser.parseShort(data);
			result.numberOfHMetrics = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
		
	}

}