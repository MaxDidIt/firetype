package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.Class1Record;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.Class2Record;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairAdjustmentPositioningSubtable1;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairAdjustmentPositioningSubtable2;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairSet;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.pair.PairValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.ClassDefinitionTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.DeviceTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairAdjustmentPositioningSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageParser:CoverageTableParser;
		
		private var _valueFormatParser:ValueFormatParser;
		private var _valueRecordParser:ValueRecordParser;
		
		private var _classDefinitionParser:ClassDefinitionTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairAdjustmentPositioningSubtableParser($dataTypeParser:DataTypeParser, $coverageParser:CoverageTableParser, $classDefinitionParser:ClassDefinitionTableParser, $valueFormatParser:ValueFormatParser, $valueRecordParser:ValueRecordParser) 
		{
			this._classDefinitionParser = $classDefinitionParser;
			
			this._coverageParser = $coverageParser;
			this._dataTypeParser = $dataTypeParser;
			
			this._valueRecordParser = $valueRecordParser;
			this._valueFormatParser = $valueFormatParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var result:ILookupSubtable;
			
			if (posFormat == 1)
			{
				result = parsePairAdjustmentPositioningSubtable1(data, offset);
			}
			else if (posFormat == 2)
			{
				result = parsePairAdjustmentPositioningSubtable2(data, offset);
			}
			
			return result;
		}
		
		private function parsePairAdjustmentPositioningSubtable2(data:ByteArray, offset:uint):PairAdjustmentPositioningSubtable2 
		{
			var result:PairAdjustmentPositioningSubtable2 = new PairAdjustmentPositioningSubtable2();
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var valueFormatData1:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData1 = valueFormatData1;
			
			var valueFormat1:ValueFormat = _valueFormatParser.parseValueFormat(valueFormatData1);
			result.valueFormat1 = valueFormat1;
			
			var valueFormatData2:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData1 = valueFormatData2;
			
			var valueFormat2:ValueFormat = _valueFormatParser.parseValueFormat(valueFormatData2);
			result.valueFormat2 = valueFormat2;
			
			var classDefinitionOffset1:uint = _dataTypeParser.parseUnsignedShort(data);
			result.classDefinitionOffset1 = classDefinitionOffset1;
			
			var classDefinitionOffset2:uint = _dataTypeParser.parseUnsignedShort(data);
			result.classDefinitionOffset2 = classDefinitionOffset2;
			
			var class1Count:uint = _dataTypeParser.parseUnsignedShort(data);
			result.class1Count = class1Count;
			
			var class2Count:uint = _dataTypeParser.parseUnsignedShort(data);
			result.class2Count = class2Count;
			
			var class1Records:Vector.<Class1Record> = parseClass1Records(data, class1Count, class2Count, valueFormat1, valueFormat2);
			result.class1Records = class1Records;
			
			if (coverageOffset != 0)
			{
				var coverage:ICoverageTable = _coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			if (classDefinitionOffset1 != 0)
			{
				var classDefinition:IClassDefinitionTable = _classDefinitionParser.parseTable(data, offset + classDefinitionOffset1);
				result.classDefinition1 = classDefinition;
			}
			
			if (classDefinitionOffset2 != 0)
			{
				classDefinition = _classDefinitionParser.parseTable(data, offset + classDefinitionOffset2);
				result.classDefinition2 = classDefinition;
			}
			
			return result;
		}
		
		private function parseClass1Records(data:ByteArray, class1Count:uint, class2Count:uint, valueFormat1:ValueFormat, valueFormat2:ValueFormat):Vector.<Class1Record> 
		{
			var result:Vector.<Class1Record> = new Vector.<Class1Record>(class1Count);
			
			for (var i:uint = 0; i < class1Count; i++)
			{
				var record:Class1Record = parseClass1Record(data, class2Count, valueFormat1, valueFormat2);
				result[i] = record;
			}
			
			return result;
		}
		
		private function parseClass1Record(data:ByteArray, class2Count:uint, valueFormat1:ValueFormat, valueFormat2:ValueFormat):Class1Record 
		{
			var result:Class1Record = new Class1Record();
			
			var class2Records:Vector.<Class2Record> = new Vector.<Class2Record>(class2Count);
			for (var i:uint = 0; i < class2Count; i++)
			{
				var record:Class2Record = parse2ClassRecord(data, valueFormat1, valueFormat2);
				class2Records[i] = record;
			}
			result.class2Records = class2Records;
			
			return result;
		}
		
		private function parse2ClassRecord(data:ByteArray, valueFormat1:ValueFormat, valueFormat2:ValueFormat):Class2Record 
		{
			var result:Class2Record = new Class2Record();
			
			var valueRecord1:ValueRecord = _valueRecordParser.parseValueRecord(data, valueFormat1);
			result.value1 = valueRecord1;
			
			var valueRecord2:ValueRecord = _valueRecordParser.parseValueRecord(data, valueFormat2);
			result.value2 = valueRecord2;
			
			return result;
		}
		
		private function parsePairAdjustmentPositioningSubtable1(data:ByteArray, offset:uint):PairAdjustmentPositioningSubtable1
		{
			var result:PairAdjustmentPositioningSubtable1 = new PairAdjustmentPositioningSubtable1();
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var valueFormatData1:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData1 = valueFormatData1;
			
			var valueFormat1:ValueFormat = _valueFormatParser.parseValueFormat(valueFormatData1);
			result.valueFormat1 = valueFormat1;
			
			var valueFormatData2:uint = _dataTypeParser.parseUnsignedShort(data);
			result.valueFormatData2 = valueFormatData2;
			
			var valueFormat2:ValueFormat = _valueFormatParser.parseValueFormat(valueFormatData2);
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
				var coverage:ICoverageTable = _coverageParser.parseTable(data, offset + coverageOffset);
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
			
			parsePairValueRecordDeviceTables(data, pairValueRecords, offset);
			
			return result;
		}
		
		private function parsePairValueRecordDeviceTables(data:ByteArray, pairValueRecords:Vector.<PairValueRecord>, offset:uint):void 
		{
			const l:uint = pairValueRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var record:PairValueRecord = pairValueRecords[i];
				_valueRecordParser.parseDeviceTables(data, record.value1, offset);
				_valueRecordParser.parseDeviceTables(data, record.value2, offset);
			}
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
			result.value1 = _valueRecordParser.parseValueRecord(data, valueFormat1);
			result.value2 = _valueRecordParser.parseValueRecord(data, valueFormat2);
			
			return result;
		}
	}

}