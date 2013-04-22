package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.CaretValue1;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.CaretValue2;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.CaretValue3;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.ICaretValue;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureCaretListTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureGlyphTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureCaretListTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureCaretListTableParser(dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:LigatureCaretListTableData = new LigatureCaretListTableData();
			
			result.coverageOffset = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureGlyphCount = _dataTypeParser.parseUnsignedShort(data);
			
			var ligatureGlyphTableOffsets:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < result.ligatureGlyphCount; i++ )
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				ligatureGlyphTableOffsets.push(offset);
			}
			result.ligatureGlyphTableOffsets = ligatureGlyphTableOffsets;
			
			var coverageParser:CoverageTableParser = new CoverageTableParser(_dataTypeParser);
			result.coverage = coverageParser.parseTable(data, offset + result.coverageOffset);
			
			var ligatureGlyphTables:Vector.<LigatureGlyphTable> = new Vector.<LigatureGlyphTable>();
			for (i = 0; i < result.ligatureGlyphCount; i++)
			{
				var ligatureGlyphTable:LigatureGlyphTable = parseLigatureGlyphTable(data, offset + result.ligatureGlyphTableOffsets[i]);
				ligatureGlyphTables.push(ligatureGlyphTable);
			}
			result.ligatureGlyphTables = ligatureGlyphTables;
			
			return result;
		}
		
		private function parseLigatureGlyphTable(data:ByteArray, offset:uint):LigatureGlyphTable 
		{
			data.position = offset;
			
			var result:LigatureGlyphTable = new LigatureGlyphTable();
			
			result.caretCount = _dataTypeParser.parseUnsignedShort(data);
			
			var caretValueOffsets:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < result.caretCount; i++ )
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				caretValueOffsets.push(offset);
			}
			result.caretValueOffsets = caretValueOffsets;
			
			var caretValues:Vector.<ICaretValue> = new Vector.<ICaretValue>();
			for (i = 0; i < result.caretCount; i++)
			{
				var caretValue:ICaretValue = parseCaretValue(data, offset + result.caretValueOffsets[i]);
				caretValues.push(caretValue);
			}
			result.caretValues = caretValues;
			
			return result;
		}
		
		private function parseCaretValue(data:ByteArray, offset:uint):ICaretValue 
		{
			data.position = offset;
			
			var format:uint = _dataTypeParser.parseUnsignedShort(data);

			if (format == 1)
			{
				var caretValue1:CaretValue1 = new CaretValue1();
				caretValue1.coordinate = _dataTypeParser.parseShort(data);
				return caretValue1;
			}
			
			if (format == 2)
			{
				var caretValue2:CaretValue2 = new CaretValue2();
				caretValue2.pointIndex = _dataTypeParser.parseUnsignedShort(data);
				return caretValue2;
			}
			
			if (format == 3)
			{
				var caretValue3:CaretValue3 = new CaretValue3();
				caretValue3.coordinate = _dataTypeParser.parseUnsignedShort(data);
				caretValue3.deviceTableOffset = _dataTypeParser.parseUnsignedShort(data);
				
				var deviceTableParser:DeviceTableParser = new DeviceTableParser(_dataTypeParser);
				caretValue3.deviceTable = deviceTableParser.parseTable(data, offset + caretValue3.deviceTableOffset);
				
				return caretValue3;
			}
			
			return null;
		}
		
	}

}