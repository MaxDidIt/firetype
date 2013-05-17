package de.maxdidit.hardware.font.parser.tables.advanced 
{
	import adobe.utils.CustomActions;
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningLookupType;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.SingleAdjustmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.FeatureListTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.LookupListTableDataParser;
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
			
			var lookupTableParser:LookupListTableDataParser = new LookupListTableDataParser(_dataTypeParser);
			var lookupTableData:LookupListTable = lookupTableParser.parseTable(data, record.offset + lookupListOffset);
			result.lookupTable = lookupTableData;
			
			var coverageParser:CoverageTableParser = new CoverageTableParser(_dataTypeParser);
			
			var subTables:Vector.<LookupTable> = parseSubTables(data, record.offset + lookupListOffset, lookupTableData.lookupOffsets, lookupTableParser, coverageParser);
			lookupTableData.lookupTables = subTables;
			
			return result;
		}
		
		private function parseSubTables(data:ByteArray, lookupListOffset:uint, lookupOffsets:Vector.<uint>, lookupTableParser:LookupListTableDataParser, coverageParser:CoverageTableParser):Vector.<LookupTable> 
		{
			const l:uint = lookupOffsets.length;
			var result:Vector.<LookupTable> = new Vector.<LookupTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var offset:uint = lookupOffsets[i];
				var lookupTable:LookupTable = parseLookupTable(data, lookupListOffset + offset, lookupTableParser, coverageParser);
			}
			
			return result;
		}
		
		private function parseLookupTable(data:ByteArray, offset:uint, lookupTableParser:LookupListTableDataParser, coverageParser:CoverageTableParser):LookupTable 
		{
			data.position = offset;
			
			var lookupType:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var result:LookupTable;
			
			switch(lookupType)
			{
				case GlyphPositioningLookupType.SINGLE_ADJUSTMENT:
					result = parseSingleAdjustmentPositioningSubtable(data, offset, lookupTableParser, coverageParser);
					break;
			}
			
			return result;
		}
		
		private function parseSingleAdjustmentPositioningSubtable(data:ByteArray, offset:uint, lookupTableParser:LookupListTableDataParser, coverageParser:CoverageTableParser):LookupTable 
		{
			var result:SingleAdjustmentPositioningSubtable = new SingleAdjustmentPositioningSubtable();
			
			lookupTableParser.parseLookupTable(data, result);
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var valueFormatData:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData = valueFormatData;
			
			var valueFormat:ValueFormat = parseValueFormat(valueFormatData);
			
			var valueCount:uint;
			var values:Vector.<ValueRecord> = new Vector.<ValueRecord>();
			var value:ValueRecord;
			
			if (posFormat == 1)
			{
				valueCount = 1;
				
				value = parseValueRecord(data, valueFormat);
				values.push(value);
			}
			else if (posFormat == 2)
			{
				valueCount = _dataTypeParser.parseUnsignedShort(data);
				for (var i:uint = 0; i < valueCount; i++)
				{
					value = parseValueRecord(data, valueFormat);
					values.push(value);
				}
			}
			
			result.valueCount = valueCount;
			result.values = values;
			
			if (coverageOffset != 0)
			{
				var coverage:ICoverageTable = coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			// TODO: parse value record sub tables
			
			return result;
		}
		
		private function parseValueFormat(valueFormatData:uint):ValueFormat 
		{
			var valueFormat:ValueFormat = new ValueFormat();
			
			valueFormat.xPlacement = (valueFormatData & 0x1) == 1;
			valueFormat.yPlacement = ((valueFormatData >> 1) & 0x1) == 1;
			
			valueFormat.xAdvance = ((valueFormatData >> 2) & 0x1) == 1;
			valueFormat.yAdvance = ((valueFormatData >> 3) & 0x1) == 1;
			
			valueFormat.xPlacementDevice = ((valueFormatData >> 4) & 0x1) == 1;
			valueFormat.yPlacementDevice = ((valueFormatData >> 5) & 0x1) == 1;
			
			valueFormat.xAdvanceDevice = ((valueFormatData >> 6) & 0x1) == 1;
			valueFormat.yAdvanceDevice = ((valueFormatData >> 7) & 0x1) == 1;
			
			return valueFormat;
		}
		
		private function parseValueRecord(data:ByteArray, valueFormat:ValueFormat):ValueRecord 
		{
			var result:ValueRecord = new ValueRecord();
			
			if (valueFormat.xPlacement)
			{
				result.xPlacement = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yPlacement)
			{
				result.yPlacement = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.xAdvance)
			{
				result.xAdvance = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yAdvance)
			{
				result.yAdvance = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.xPlacementDevice)
			{
				result.xPlacementDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yPlacementDevice)
			{
				result.yPlacementDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.xAdvanceDevice)
			{
				result.xAdvanceDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			if (valueFormat.yAdvanceDevice)
			{
				result.yAdvanceDeviceOffset = _dataTypeParser.parseShort(data);
			}
			
			return result;
		}
		
	}

}