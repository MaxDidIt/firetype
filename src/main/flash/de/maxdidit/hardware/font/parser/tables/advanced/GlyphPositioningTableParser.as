package de.maxdidit.hardware.font.parser.tables.advanced
{
	import adobe.utils.CustomActions;
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive.CursiveAttachmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive.EntryExitRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningLookupType;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase.BaseArray;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase.BaseRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase.MarkToBaseAttachmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairAdjustmentPositioningSubtable1;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairSet;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.single.SingleAdjustmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
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
			result.lookupListTable = lookupTableData;
			
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
				result[i] = lookupTable;
			}
			
			return result;
		}
		
		private function parseLookupTable(data:ByteArray, offset:uint, lookupTableParser:LookupListTableDataParser, coverageParser:CoverageTableParser):LookupTable
		{
			data.position = offset;
			
			//var lookupType:uint = _dataTypeParser.parseUnsignedShort(data);
			var result:LookupTable = lookupTableParser.parseLookupTable(data);
			
			const l:uint = result.subTableOffsets.length;
			var subTables:Vector.<ILookupSubtable> = new Vector.<ILookupSubtable>(l);
			for (var i:uint = 0; i < l; i++)
			{
				var subTable:ILookupSubtable;
				var subTableOffset:uint = result.subTableOffsets[i];
				
				switch (result.lookupType)
				{
					case GlyphPositioningLookupType.SINGLE_ADJUSTMENT: 
						subTable = parseSingleAdjustmentPositioningSubtable(data, offset + subTableOffset, coverageParser);
						break;
					
					case GlyphPositioningLookupType.PAIR_ADJUSTMENT: 
						subTable = parsePairAdjustmentPositioningSubtable(data, offset + subTableOffset, coverageParser);
						break;
						
					case GlyphPositioningLookupType.CURSIVE_ATTACHMENT:
						subTable = parseCursiveAttachmentPositioningSubtable(data, offset + subTableOffset, coverageParser);
						break;
						
					case GlyphPositioningLookupType.MARK_TO_BASE_ATTACHMENT:
						subTable = parseMarkToBaseAttachment(data, offset + subTableOffset, coverageParser);
						break;
				}
				
				subTables[i] = subTable;
			}
			result.subTables = subTables;
			
			return result;
		}
		
		private function parseMarkToBaseAttachment(data:ByteArray, subTableOffset:uint, coverageParser:CoverageTableParser):ILookupSubtable 
		{
			data.position = subTableOffset;
			
			var result:MarkToBaseAttachmentPositioningSubtable = new MarkToBaseAttachmentPositioningSubtable();
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var markCoverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markCoverageOffset = markCoverageOffset;
			
			var baseCoverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.baseCoverageOffset = baseCoverageOffset;
			
			var classCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.classCount = classCount;
			
			var markArrayOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markArrayOffset = markArrayOffset;
			
			var baseArrayOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.baseArrayOffset = baseArrayOffset;
			
			if (markCoverageOffset != 0)
			{
				var coverage:ICoverageTable = coverageParser.parseTable(data, subTableOffset + markCoverageOffset);
				result.markCoverage = coverage;
			}
			
			if (baseCoverageOffset != 0)
			{
				coverage = coverageParser.parseTable(data, subTableOffset + baseCoverageOffset);
				result.baseCoverage = coverage;
			}
			
			if (markArrayOffset != 0)
			{
				var markArray:MarkArray = parseMarkArray(data, subTableOffset + markArrayOffset);
				result.markArray = markArray;
			}
			
			if (baseArrayOffset != 0)
			{
				var baseArray:BaseArray = parseBaseArray(data, subTableOffset + baseArrayOffset, classCount);
				result.baseArray = baseArray;
			}
			
			return result;
		}
		
		private function parseBaseArray(data:ByteArray, baseArrayOffset:uint, classCount:uint):BaseArray 
		{
			data.position = baseArrayOffset;
			
			var result:BaseArray = new BaseArray();
			
			var baseCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.baseCount = baseCount;
			
			var baseRecords:Vector.<BaseRecord> = new Vector.<BaseRecord>(baseCount);
			for (var i:uint = 0; i < baseCount; i++)
			{
				var baseRecord:BaseRecord = parseBaseRecord(data, classCount);
				baseRecords[i] = baseRecord;
			}
			result.baseRecords = baseRecords;
			
			parseBaseRecordAnchors(data, baseArrayOffset, baseRecords);
			
			return result;
		}
		
		private function parseBaseRecordAnchors(data:ByteArray, baseArrayOffset:uint, baseRecords:Vector.<BaseRecord>):void 
		{
			const l:uint = baseRecords.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var baseRecord:BaseRecord = baseRecords[i];
				
				var al:uint = baseRecord.baseAnchorOffsets.length;
				var anchors:Vector.<AnchorTable> = new Vector.<AnchorTable>(al);
				for (var a:uint = 0; a < al; a++)
				{
					var anchor:AnchorTable = parseAnchor(data, baseArrayOffset + baseRecord.baseAnchorOffsets[a]);
					anchors[a] = anchor;
				}
				
				baseRecord.baseAnchors = anchors;
			}
		}
		
		private function parseBaseRecord(data:ByteArray, classCount:uint):BaseRecord 
		{
			var result:BaseRecord = new BaseRecord();
			
			var baseAnchorOffsets:Vector.<uint> = new Vector.<uint>(classCount);
			for (var i:uint = 0; i < classCount; i++)
			{
				baseAnchorOffsets[i] = _dataTypeParser.parseUnsignedShort(data);
			}
			result.baseAnchorOffsets = baseAnchorOffsets;
			
			return result;
		}
		
		private function parseMarkArray(data:ByteArray, markArrayOffset:uint):MarkArray 
		{
			data.position = markArrayOffset;
			
			var result:MarkArray = new MarkArray();
			
			var markCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markCount = markCount;
			
			var markRecords:Vector.<MarkRecord> = parseMarkRecords(data, markArrayOffset, markCount);
			result.markRecords = markRecords;
			
			return result;
		}
		
		private function parseMarkRecords(data:ByteArray, markArrayOffset:uint, markCount:uint):Vector.<MarkRecord> 
		{
			var result:Vector.<MarkRecord> = new Vector.<MarkRecord>(markCount);
			
			for (var i:uint = 0; i < markCount; i++)
			{
				var markRecord:MarkRecord = parseMarkRecord(data);
				result[i] = markRecord;
			}
			
			parseMarkRecordAnchors(data, result, markArrayOffset);
			
			return result;
		}
		
		private function parseMarkRecordAnchors(data:ByteArray, markRecords:Vector.<MarkRecord>, markArrayOffset:uint):void 
		{
			const l:uint = markRecords.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var markRecord:MarkRecord = markRecords[i];
				var anchorTable:AnchorTable = parseAnchor(data, markArrayOffset + markRecord.markAnchorOffset);
				markRecord.markAnchor = anchorTable;
			}
		}
		
		private function parseMarkRecord(data:ByteArray):MarkRecord 
		{
			var result:MarkRecord = new MarkRecord();
			
			var markClass:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markClass = markClass;
			
			var markAnchorOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markAnchorOffset = markAnchorOffset;
			
			return result;
		}
		
		private function parseCursiveAttachmentPositioningSubtable(data:ByteArray, subTableOffset:uint, coverageParser:CoverageTableParser):ILookupSubtable 
		{
			data.position = subTableOffset;
			
			var result:CursiveAttachmentPositioningSubtable = new CursiveAttachmentPositioningSubtable();
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var entryExitCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.entryExitCount = entryExitCount;
			
			var entryExitRecords:Vector.<EntryExitRecord> = parseEntryExitRecords(data, entryExitCount);
			result.entryExitRecords = entryExitRecords;
			
			if (coverageOffset != 0)
			{
				var coverage:ICoverageTable = coverageParser.parseTable(data, subTableOffset + coverageOffset);
				result.coverage = coverage;
			}
			
			parseEntryExitAnchors(data, subTableOffset, entryExitRecords);
			
			return result;
		}
		
		private function parseEntryExitAnchors(data:ByteArray, subTableOffset:uint, entryExitRecords:Vector.<EntryExitRecord>):void 
		{
			const l:uint = entryExitRecords.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var entryExitRecord:EntryExitRecord = entryExitRecords[i];
				entryExitRecord.entryAnchor = parseAnchor(data, subTableOffset + entryExitRecord.entryAnchorOffset);
				entryExitRecord.exitAnchor = parseAnchor(data, subTableOffset + entryExitRecord.exitAnchorOffset);
			}
		}
		
		private function parseAnchor(data:ByteArray, entryAnchorOffset:uint):AnchorTable 
		{
			data.position = entryAnchorOffset;
			
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
		
		private function parseEntryExitRecords(data:ByteArray, entryExitCount:uint):Vector.<EntryExitRecord>
		{
			var result:Vector.<EntryExitRecord> = new Vector.<EntryExitRecord>(entryExitCount);
			
			for (var i:uint = 0; i < entryExitCount; i++)
			{
				var record:EntryExitRecord = parseEntryExitRecord(data);
				result[i];
			}
			
			return result;
		}
		
		private function parseEntryExitRecord(data:ByteArray):EntryExitRecord 
		{
			var result:EntryExitRecord = new EntryExitRecord();
			
			result.entryAnchorOffset = _dataTypeParser.parseUnsignedShort(data);
			result.exitAnchorOffset = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
		
		private function parsePairAdjustmentPositioningSubtable(data:ByteArray, offset:uint, coverageParser:CoverageTableParser):ILookupSubtable
		{
			data.position = offset;
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var result:ILookupSubtable;
			
			if (posFormat == 1)
			{
				result = parsePairAdjustmentPositioningSubtable1(data, offset, coverageParser);
			}
			else if (posFormat == 2)
			{
				// TODO: Implement pair adjustment format 2
			}
			
			return result;
		}
		
		private function parsePairAdjustmentPositioningSubtable1(data:ByteArray, offset:uint, coverageParser:CoverageTableParser):PairAdjustmentPositioningSubtable1 
		{
			var result:PairAdjustmentPositioningSubtable1 = new PairAdjustmentPositioningSubtable1();
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var valueFormatData1:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData1 = valueFormatData1;
			
			var valueFormat1:ValueFormat = parseValueFormat(valueFormatData1);
			result.valueFormat1 = valueFormat1;
			
			var valueFormatData2:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData2 = valueFormatData2;
			
			var valueFormat2:ValueFormat = parseValueFormat(valueFormatData2);
			result.valueFormat2 = valueFormat2;
			
			var pairSetCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.pairSetCount = pairSetCount;
			
			var pairSetOffsets:Vector.<uint> =  new Vector.<uint>(pairSetCount);
			for (var i:uint = 0; i < pairSetCount; i++)
			{
				pairSetOffsets[i] = _dataTypeParser.parseUnsignedShort(data);
			}
			result.pairSetOffset = pairSetOffsets;
			
			var pairSets:Vector.<PairSet> = parsePairSets(data, offset, pairSetOffsets, valueFormat1, valueFormat2);
			result.pairSets = pairSets;
			
			if (coverageOffset != 0)
			{
				var coverage:ICoverageTable = coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			return result;
		}
		
		private function parsePairSets(data:ByteArray, offset:uint, pairSetOffsets:Vector.<uint>, valueFormat1:ValueFormat, valueFormat2:ValueFormat):Vector.<PairSet>
		{
			const l:uint = pairSetOffsets.length;
			var result:Vector.<PairSet> = new Vector.<PairSet>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var pairSet:PairSet = parsePairSet(data, offset + pairSetOffsets[i], valueFormat1, valueFormat2);
				result[i] = pairSet;
			}
			
			return result;
		}
		
		private function parsePairSet(data:ByteArray, offset:uint, valueFormat1:ValueFormat, valueFormat2:ValueFormat):PairSet
		{
			data.position = offset;
			
			var result:PairSet = new PairSet();
			
			var pairValueCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.pairValueCount = pairValueCount;
			
			var pairValueRecords:Vector.<PairValueRecord> = parsePairValueRecords(data, pairValueCount, valueFormat1, valueFormat2);
			result.pairValueRecords = pairValueRecords;
			
			return result;
		}
		
		private function parsePairValueRecords(data:ByteArray, pairValueCount:uint, valueFormat1:ValueFormat, valueFormat2:ValueFormat):Vector.<PairValueRecord>
		{
			var result:Vector.<PairValueRecord> = new Vector.<PairValueRecord>(pairValueCount);
			
			for (var i:uint = 0; i < pairValueCount; i++)
			{
				var pairValueRecord:PairValueRecord = parsePairValueRecord(data, valueFormat1, valueFormat2);
				result[i] = pairValueRecord;
			}
			
			return result;
		}
		
		private function parsePairValueRecord(data:ByteArray, valueFormat1:ValueFormat, valueFormat2:ValueFormat):PairValueRecord
		{
			var result:PairValueRecord = new PairValueRecord();
			
			result.secondGlyphID = _dataTypeParser.parseUnsignedShort(data);
			result.value1 = parseValueRecord(data, valueFormat1);
			result.value2 = parseValueRecord(data, valueFormat2);
			
			return result;
		}
		
		private function parseSingleAdjustmentPositioningSubtable(data:ByteArray, offset:uint, coverageParser:CoverageTableParser):ILookupSubtable
		{
			var result:SingleAdjustmentPositioningSubtable = new SingleAdjustmentPositioningSubtable();
			
			data.position = offset;
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var valueFormatData:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData = valueFormatData;
			
			var valueFormat:ValueFormat = parseValueFormat(valueFormatData);
			result.valueFormat = valueFormat;
			
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