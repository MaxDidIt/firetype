package de.maxdidit.hardware.font.parser.tables.common 
{
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable;
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
			
			record.featureTag = _dataTypeParser.parseTag(data);
			record.featureOffset = _dataTypeParser.parseUnsignedShort(data);
			
			return record;
		}
		
	}

}