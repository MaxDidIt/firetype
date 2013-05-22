package de.maxdidit.hardware.font.parser.tables.required 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.cmap.CharacterIndexMappingTableData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.ByteEncodingTableData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.CharacterIndexMappingSubtable;
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.HighByteMappingTableData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.HighByteSubHeader;
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.ICharacterIndexMappingSubtableData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.SegmentToDeltaMappingSubtableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
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
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			data.position = record.offset;
			
			var result:CharacterIndexMappingTableData = new CharacterIndexMappingTableData();
			
			result.version = _dataTypeParser.parseUnsignedShort(data);
			result.numTables = _dataTypeParser.parseUnsignedShort(data);
			
			result.subTables = parseSubTableEncodingRecords(data, result.numTables);
			
			parseSubTables(data, record.offset, result.subTables);
			
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
			// *(idRangeOffset[i]/2 + (c - startCount[i]) + &idRangeOffset[i])
			var idRangeOffset:Vector.<uint> = new Vector.<uint>();
			var glyphIdArray:Vector.<uint> = new Vector.<uint>();
			var segmentStartIndex:Vector.<uint> = new Vector.<uint>();
			for (i = 0; i < segCount; i++)
			{
				value = _dataTypeParser.parseUnsignedShort(data);
				idRangeOffset.push(value);
				
				segmentStartIndex.push(glyphIdArray.length);
				
				value /= 2;
				if (value != 0)
				{
					var currentPosition:int = data.position - 2; // rewind to offset of id range offset value.
					
					var range:int = endCount[i] - startCount[i];
					for (var c:uint = 0; c <= range; c++)
					{
						var offset:uint = ((c + value) * 2);
						data.position = currentPosition + offset;
						var glyphID:uint = _dataTypeParser.parseUnsignedShort(data);
						glyphIdArray.push(glyphID);
					}
						
					data.position = currentPosition + 2;
				}
			}
			result.idRangeOffset = idRangeOffset;
			result.glyphIdArray = glyphIdArray;
			result.segmentStartIndex = segmentStartIndex;
			
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