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
	import de.maxdidit.hardware.font.data.tables.required.hhea.HorizontalHeaderData; 
	import de.maxdidit.hardware.font.data.tables.required.hmtx.HorizontalMetricsData; 
	import de.maxdidit.hardware.font.data.tables.required.hmtx.LongHorizontalMetric; 
	import de.maxdidit.hardware.font.data.tables.required.maxp.MaximumProfileTableData; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import de.maxdidit.hardware.font.parser.tables.TableNames; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class HorizontalMetricsParser implements ITableParser 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function HorizontalMetricsParser($dataTypeParser:DataTypeParser) 
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
			 
			var result:HorizontalMetricsData = new HorizontalMetricsData(); 
			 
			var maximumProfileData:MaximumProfileTableData = tableMap.retrieveTable(TableNames.MAXIMUM_PROFILE).data as MaximumProfileTableData; 
			var horizontalHeaderData:HorizontalHeaderData = tableMap.retrieveTable(TableNames.HORIZONTAL_HEADER).data as HorizontalHeaderData; 
			 
			var longHorizontalMetrics:Vector.<LongHorizontalMetric> = parseLongHorizontalMetrics(data, horizontalHeaderData.numberOfHMetrics); 
			result.longHorizontalMetrics = longHorizontalMetrics; 
			 
			var leftSideBearings:Vector.<int> = parseLeftSideBearings(data, maximumProfileData.numGlyphs - horizontalHeaderData.numberOfHMetrics); 
			result.leftSideBearings = leftSideBearings; 
			 
			return result; 
		} 
		 
		private function parseLongHorizontalMetrics(data:ByteArray, numberOfHMetrics:uint):Vector.<LongHorizontalMetric> 
		{ 
			var result:Vector.<LongHorizontalMetric> = new Vector.<LongHorizontalMetric>(numberOfHMetrics); 
			 
			for (var i:uint = 0; i < numberOfHMetrics; i++) 
			{ 
				var longHorizontalMetric:LongHorizontalMetric = new LongHorizontalMetric(); 
				 
				longHorizontalMetric.advanceWidth = _dataTypeParser.parseUnsignedShort(data); 
				longHorizontalMetric.leftSideBearing = _dataTypeParser.parseShort(data); 
				 
				result[i] = longHorizontalMetric; 
			} 
			 
			return result; 
		} 
		 
		private function parseLeftSideBearings(data:ByteArray, numberOfBearings:uint):Vector.<int> 
		{ 
			var result:Vector.<int> = new Vector.<int>(numberOfBearings); 
			 
			for (var i:uint = 0; i < numberOfBearings; i++) 
			{ 
				var bearing:int = _dataTypeParser.parseShort(data); 
				result[i] = bearing; 
			} 
			 
			return result; 
		} 
	} 
} 
