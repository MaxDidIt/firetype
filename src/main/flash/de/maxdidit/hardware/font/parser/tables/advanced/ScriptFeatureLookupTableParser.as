package de.maxdidit.hardware.font.parser.tables.advanced
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.FeatureListTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.LookupListTableDataParser;
	import de.maxdidit.hardware.font.parser.tables.common.ScriptListTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.NotYetImplementedSubtableParser;
	import flash.utils.ByteArray;
	
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ScriptFeatureLookupTableParser implements ITableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		protected var _dataTypeParser:DataTypeParser;
		
		protected var _scriptListTableParser:ScriptListTableParser;
		protected var _featureListTableParser:FeatureListTableParser;
		protected var _lookupTableParser:LookupListTableDataParser;
		
		protected var _coverageTableParser:CoverageTableParser;
		
		protected var _subtableParserMap:Object;
			
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ScriptFeatureLookupTableParser($dataTypeParser:DataTypeParser)
		{
			this._dataTypeParser = $dataTypeParser;
			
			_scriptListTableParser = new ScriptListTableParser(_dataTypeParser);
			_featureListTableParser = new FeatureListTableParser(_dataTypeParser);
			_lookupTableParser = new LookupListTableDataParser(_dataTypeParser);
			
			_coverageTableParser = new CoverageTableParser(_dataTypeParser);
			
			initSubtableParser();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		protected function initSubtableParser():void 
		{
			throw new Error("Extend this class and implement this function.");
		}
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):*
		{
			data.position = record.offset;
			
			var result:ScriptFeatureLookupTable = instantiateResult();
			
			var version:Number = _dataTypeParser.parseFixed(data);
			result.version = version;
			
			var scriptListOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.scriptListOffset = scriptListOffset;
			
			var featuresListOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.featuresListOffset = featuresListOffset;
			
			var lookupListOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.lookupListOffset = lookupListOffset;
			
			var scriptListTableData:ScriptListTableData = _scriptListTableParser.parseTable(data, record.offset + scriptListOffset);
			result.scriptListTable = scriptListTableData;
			
			var featureListTableData:FeatureListTableData = _featureListTableParser.parseTable(data, record.offset + featuresListOffset);
			result.featureListTable = featureListTableData;
			
			var lookupTableData:LookupListTable = _lookupTableParser.parseTable(data, record.offset + lookupListOffset);
			result.lookupListTable = lookupTableData;
			
			var subTables:Vector.<LookupTable> = parseSubTables(data, record.offset + lookupListOffset, lookupTableData.lookupOffsets);
			lookupTableData.lookupTables = subTables;
			
			return result;
		}
		
		protected function instantiateResult():ScriptFeatureLookupTable 
		{
			throw new Error("Extend this class and implement this function.")
		}
		
		private function parseSubTables(data:ByteArray, lookupListOffset:uint, lookupOffsets:Vector.<uint>):Vector.<LookupTable>
		{
			const l:uint = lookupOffsets.length;
			var result:Vector.<LookupTable> = new Vector.<LookupTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var offset:uint = lookupOffsets[i];
				var lookupTable:LookupTable = parseLookupTable(data, lookupListOffset + offset);
				result[i] = lookupTable;
			}
			
			return result;
		}
		
		private function parseLookupTable(data:ByteArray, offset:uint):LookupTable
		{
			data.position = offset;
			
			var result:LookupTable = _lookupTableParser.parseLookupTable(data);
			var parser:ISubTableParser = _subtableParserMap[String(result.lookupType)] as ISubTableParser;
			
			const l:uint = result.subTableOffsets.length;
			var subTables:Vector.<ILookupSubtable> = new Vector.<ILookupSubtable>(l);
			for (var i:uint = 0; i < l; i++)
			{
				var subTableOffset:uint = result.subTableOffsets[i];
				var subTable:ILookupSubtable = parser.parseTable(data, offset + subTableOffset) as ILookupSubtable;
				
				subTables[i] = subTable;
			}
			result.subTables = subTables;
			
			return result;
		}
		
	}

}