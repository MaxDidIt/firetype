package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive.CursiveAttachmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive.EntryExitRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CursiveAttachmentPositioningSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageParser:CoverageTableParser;
		private var _anchorTableParser:AnchorTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CursiveAttachmentPositioningSubtableParser($dataTypeParser:DataTypeParser, $coverageParser:CoverageTableParser, $anchorTableParser:AnchorTableParser) 
		{
			this._anchorTableParser = $anchorTableParser;
			this._coverageParser = $coverageParser;
			this._dataTypeParser = $dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
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
				var coverage:ICoverageTable = _coverageParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			parseEntryExitAnchors(data, offset, entryExitRecords);
			
			return result;
		}
		
		private function parseEntryExitAnchors(data:ByteArray, offset:uint, entryExitRecords:Vector.<EntryExitRecord>):void 
		{
			const l:uint = entryExitRecords.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var entryExitRecord:EntryExitRecord = entryExitRecords[i];
				entryExitRecord.entryAnchor = _anchorTableParser.parseTable(data, offset + entryExitRecord.entryAnchorOffset);
				entryExitRecord.exitAnchor = _anchorTableParser.parseTable(data, offset + entryExitRecord.exitAnchorOffset);
			}
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
		
	}

}