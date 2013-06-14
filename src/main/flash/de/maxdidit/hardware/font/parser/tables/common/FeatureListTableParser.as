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
 
package de.maxdidit.hardware.font.parser.tables.common  
{ 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData; 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord; 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable; 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class FeatureListTableParser implements ISubTableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function FeatureListTableParser($dataTypeParser:DataTypeParser)  
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
			 
			var result:FeatureListTableData = new FeatureListTableData(); 
			 
			var featureCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.featureCount = featureCount; 
			 
			var featureRecords:Vector.<FeatureRecord> = parseFeatureRecords(data, featureCount); 
			result.featureRecords = featureRecords; 
			 
			parseFeatureTables(data, featureRecords, offset); 
			 
			return result; 
		} 
		 
		private function parseFeatureTables(data:ByteArray, featureRecords:Vector.<FeatureRecord>, offset:uint):void  
		{ 
			const l:uint = featureRecords.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var record:FeatureRecord = featureRecords[i]; 
				 
				var featureTable:FeatureTable = parseFeatureTable(data, offset + record.featureOffset); 
				record.featureTable = featureTable; 
			} 
		} 
		 
		private function parseFeatureTable(data:ByteArray, featureOffset:uint):FeatureTable  
		{ 
			var result:FeatureTable = new FeatureTable(); 
			 
			data.position += 2; 
			 
			var lookupCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.lookupCount = lookupCount; 
			 
			var lookupListIndices:Vector.<uint> = new Vector.<uint>(lookupCount); 
			for (var i:uint = 0; i < lookupCount; i++) 
			{ 
				var value:uint = _dataTypeParser.parseUnsignedShort(data); 
				lookupListIndices[i] = value; 
			} 
			result.lookupListIndices = lookupListIndices; 
			 
			return result; 
		} 
		 
		private function parseFeatureRecords(data:ByteArray, featureCount:uint):Vector.<FeatureRecord>  
		{ 
			var result:Vector.<FeatureRecord> = new Vector.<FeatureRecord>(featureCount); 
			 
			for (var i:uint = 0; i < featureCount; i++) 
			{ 
				var record:FeatureRecord = parseFeatureRecord(data); 
				result[i] = record; 
			} 
			 
			return result; 
		} 
		 
		private function parseFeatureRecord(data:ByteArray):FeatureRecord  
		{ 
			var record:FeatureRecord = new FeatureRecord(); 
			 
			var featureTag:String = _dataTypeParser.parseTag(data); 
			var feature:FeatureTag = FeatureTag.getFeatureTag(featureTag); 
			 
			record.featureTag = feature; 
			record.featureOffset = _dataTypeParser.parseUnsignedShort(data); 
			 
			return record; 
		} 
		 
	} 
} 
