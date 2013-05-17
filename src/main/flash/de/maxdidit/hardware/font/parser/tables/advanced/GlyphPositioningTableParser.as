package de.maxdidit.hardware.font.parser.tables.advanced 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.FeatureListTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.ScriptListTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphPositioningTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphPositioningTableParser($dataTypeParser:DataTypeParser) 
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
			
			var result:GlyphPositioningTableData = new GlyphPositioningTableData();
			
			var version:Number = _dataTypeParser.parseFixed(data);
			result.version = version;
			
			var scriptListOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.scriptListOffset = scriptListOffset;
			
			var featuresListOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.featuresListOffset = featuresListOffset;
			
			var lookupListOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.lookupListOffset = lookupListOffset;
			
			var scriptListTableParser:ScriptListTableParser = new ScriptListTableParser(_dataTypeParser);
			var scriptListTableData:ScriptListTableData = scriptListTableParser.parseTable(data, record.offset + scriptListOffset);
			result.scriptListTable = scriptListTableData;
			
			var featureListTableParser:FeatureListTableParser = new FeatureListTableParser(_dataTypeParser);
			var featureListTableData:FeatureListTableData = featureListTableParser.parseTable(data, record.offset + featuresListOffset);
			result.featureListTable = featureListTableData;
			
			return result;
		}
		
	}

}