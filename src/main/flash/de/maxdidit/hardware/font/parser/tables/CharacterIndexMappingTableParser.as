package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.tables.cmap.CharacterIndexMappingTableData;
	import de.maxdidit.hardware.font.data.tables.cmap.sub.ByteEncodingTableData;
	import de.maxdidit.hardware.font.data.tables.cmap.sub.CharacterIndexMappingSubtable;
	import de.maxdidit.hardware.font.data.tables.cmap.sub.HighByteMappingTableData;
	import de.maxdidit.hardware.font.data.tables.cmap.sub.HighByteSubHeader;
	import de.maxdidit.hardware.font.data.tables.cmap.sub.ICharacterIndexMappingSubtableData;
	import de.maxdidit.hardware.font.data.tables.cmap.sub.SegmentToDeltaMappingSubtableData;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CharacterIndexMappingTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CharacterIndexMappingTableParser(dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = dataTypeParser;
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:CharacterIndexMappingTableData = new CharacterIndexMappingTableData();
			
			result.version = _dataTypeParser.parseUnsignedShort(data);
			result.numTables = _dataTypeParser.parseUnsignedShort(data);
			
			result.subTables = parseSubTableEncodingRecords(data, result.numTables);
			
			parseSubTables(data, offset, result.subTables);
			
			return result;
		}
		
		private function parseSubTables(data:ByteArray, offset:uint, subTables:Vector.<CharacterIndexMappingSubtable>):void 
		{
			const l:uint = subTables.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var subTable:CharacterIndexMappingSubtable = subTables[i];
				
				data.position = offset + subTable.offset;
				var format:uint = _dataTypeParser.parseUnsignedShort(data);
				
				var subTableData:ICharacterIndexMappingSubtableData = null;
				
				switch(format)
				{
					case 0:
						subTableData = parseByteEncodingTable(data);
						break;
						
					case 2:
						subTableData = parseHighByteMappingTable(data);
						break;
						
					case 4:
						subTableData = parseSegmentToDeltaTable(data);
						break;
				}
				
				subTable.data = subTableData;
			}
		}
		
		private function parseSegmentToDeltaTable(data:ByteArray):SegmentToDeltaMappingSubtableData 
		{
			var result:SegmentToDeltaMappingSubtableData = new SegmentToDeltaMappingSubtableData();
			
			result.length = _dataTypeParser.parseUnsignedShort(data);
			result.language = _dataTypeParser.parseUnsignedShort(data);
			
			result.segCountX2 = _dataTypeParser.parseUnsignedShort(data);
			result.searchRange = _dataTypeParser.parseUnsignedShort(data);
			result.entrySelector = _dataTypeParser.parseUnsignedShort(data);
			result.rangeShift = _dataTypeParser.parseUnsignedShort(data);
			
			const segCount:uint = result.segCountX2 >> 1;
			// parse endCount
			var endCount:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < segCount; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				endCount.push(value);
			}
			result.endCount = endCount;
			
			data.position += 2; // reserved short
			
			// parse startCount
			var startCount:Vector.<uint> = new Vector.<uint>();
			for (i = 0; i < segCount; i++)
			{
				value = _dataTypeParser.parseUnsignedShort(data);
				startCount.push(value);
			}
			result.startCount = startCount;
			
			// parse idDelta
			var idDelta:Vector.<int> = new Vector.<int>();
			for (i = 0; i < segCount; i++)
			{
				value = _dataTypeParser.parseShort(data);
				idDelta.push(value);
			}
			result.idDelta = idDelta;
			
			// parse idRangeOffset/glyphIdArray
			var idRangeOffset:Vector.<uint> = new Vector.<uint>();
			var glyphIdArray:Vector.<uint> = new Vector.<uint>();
			for (i = 0; i < segCount; i++)
			{
				value = _dataTypeParser.parseUnsignedShort(data);
				idRangeOffset.push(value);
				
				// TODO: The documentation is a little unclear on how to handle the glyphIdArray.
				// not sure if this is correct.
				if (value != 0)
				{
					var offset:uint = result.startCount[i] + value;
					var currentPosition:uint = data.position;
					
					data.position = currentPosition + offset;
					var glyphID:uint = _dataTypeParser.parseUnsignedShort(data);
					data.position = currentPosition;
					
					glyphIdArray.push(glyphID);
				}
			}
			result.idRangeOffset = idRangeOffset;
			
			return result;
		}
		
		private function parseHighByteMappingTable(data:ByteArray):HighByteMappingTableData 
		{
			var result:HighByteMappingTableData = new HighByteMappingTableData();
			
			result.length = _dataTypeParser.parseUnsignedShort(data);
			result.language = _dataTypeParser.parseUnsignedShort(data);
			
			var subHeaderKeys:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < 256; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				subHeaderKeys.push(value);
			}
			result.subHeaderKeys = subHeaderKeys;
			
			result.subHeaders = parseHighByteSubheaders(data, result.subHeaderKeys);
			
			// TODO: Implement parsing of sub headers and glyph index array
			
			return result;
		}
		
		private function parseHighByteSubheaders(data:ByteArray, subHeaderKeys:Vector.<uint>):Vector.<HighByteSubHeader> 
		{
			// parse subheaders from current position
			var offset:uint = data.position;
			
			var subHeaders:Vector.<HighByteSubHeader> =  new Vector.<HighByteSubHeader>();
			
			const l:uint = subHeaderKeys.length; // should always be 256
			for (var i:uint = 0; i < l; i++)
			{
				var key:uint = subHeaderKeys[i];
				var index:uint = key >> 3;
				
				// does index already exist?
				if (index < subHeaders.length)
				{
					continue;
				}
				
				subHeaders.length = index + 1;
				
				data.position = offset + key;
				
				var subHeader:HighByteSubHeader = new HighByteSubHeader();
				
				subHeader.firstCode = _dataTypeParser.parseUnsignedShort(data);
				subHeader.entryCount = _dataTypeParser.parseUnsignedShort(data);
				subHeader.idDelta = _dataTypeParser.parseShort(data);
				subHeader.idRangeOffset = _dataTypeParser.parseUnsignedShort(data);
				
				var glyphIndexArray:Vector.<uint> = new Vector.<uint>();
				data.position += subHeader.idRangeOffset;
				for (var g:uint = 0; g < subHeader.entryCount; g++)
				{
					var glyphIndex:uint = _dataTypeParser.parseUnsignedShort(data);
					glyphIndexArray.push(glyphIndex);
				}
				
				subHeader.glyphIndexArray = glyphIndexArray;
				
				subHeaders[index] = subHeader;
			}
			
			return subHeaders;
		}
		
		private function parseByteEncodingTable(data:ByteArray):ByteEncodingTableData 
		{
			var result:ByteEncodingTableData = new ByteEncodingTableData();
			
			result.length = _dataTypeParser.parseUnsignedShort(data);
			result.language = _dataTypeParser.parseUnsignedShort(data);
			
			var glyphIDs:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < 256; i++)
			{
				glyphIDs.push(_dataTypeParser.parseByte(data));
			}
			result.glyphIDs = glyphIDs;
			
			return result;
		}
		
		private function parseSubTableEncodingRecords(data:ByteArray, numTables:uint):Vector.<CharacterIndexMappingSubtable> 
		{
			var subTables:Vector.<CharacterIndexMappingSubtable> = new Vector.<CharacterIndexMappingSubtable>();
			
			for (var i:uint = 0; i < numTables; i++)
			{
				var subTable:CharacterIndexMappingSubtable = new CharacterIndexMappingSubtable();
				
				subTable.platformID = _dataTypeParser.parseUnsignedShort(data);
				subTable.encodingID = _dataTypeParser.parseUnsignedShort(data);
				
				subTable.offset = _dataTypeParser.parseUnsignedLong(data);
				
				subTables.push(subTable);
			}
			
			return subTables;
		}
		
	}

}