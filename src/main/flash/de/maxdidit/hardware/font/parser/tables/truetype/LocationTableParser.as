package de.maxdidit.hardware.font.parser.tables.truetype 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.head.FontHeaderData;
	import de.maxdidit.hardware.font.data.tables.required.maxp.MaximumProfileTableData;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.data.tables.truetype.LocationTableData;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LocationTableParser implements ITableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LocationTableParser(dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			data.position = record.offset;
			
			var result:LocationTableData = new LocationTableData();
			
			var fontHeader:Table = tableMap.retrieveTable(TableNames.FONT_HEADER);
			var maximumProfile:Table = tableMap.retrieveTable(TableNames.MAXIMUM_PROFILE);
			
			var numOffsets:uint = (maximumProfile.data as MaximumProfileTableData).numGlyphs;
			var valuesAreShort:Boolean = (fontHeader.data as FontHeaderData).indexToLocFormat == 0;
			
			var offsets:Vector.<uint> = valuesAreShort ? parseShortOffsets(data, numOffsets) : parseLongOffsets(data, numOffsets);
			result.offsets = offsets;
			
			return result;
		}
		
		private function parseLongOffsets(data:ByteArray, numOffsets:uint):Vector.<uint> 
		{
			const l:uint = numOffsets + 1;
			var result:Vector.<uint> = new Vector.<uint>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				result[i] = _dataTypeParser.parseUnsignedLong(data);
			}
			
			return result;
		}
		
		private function parseShortOffsets(data:ByteArray, numOffsets:uint):Vector.<uint> 
		{
			const l:uint = numOffsets + 1;
			var result:Vector.<uint> = new Vector.<uint>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				result[i] = _dataTypeParser.parseUnsignedShort(data) << 1; // The actual local offset divided by 2 is stored in the byte array.
			}
			
			return result;
		}
		
	}

}