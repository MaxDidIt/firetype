package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase.BaseArray;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase.BaseRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase.MarkToBaseAttachmentPositioningSubtable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToBaseAttachmentPositioningSubtableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _anchorTableParser:AnchorTableParser;
		private var _markArrayTableParser:MarkArrayTableParser;
		private var _coverageTableParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToBaseAttachmentPositioningSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser, $anchorTableParser:AnchorTableParser, $markArrayTableParser:MarkArrayTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._anchorTableParser = $anchorTableParser;
			this._markArrayTableParser = $markArrayTableParser;
			this._coverageTableParser = $coverageTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
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
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + markCoverageOffset);
				result.markCoverage = coverage;
			}
			
			if (baseCoverageOffset != 0)
			{
				coverage = _coverageTableParser.parseTable(data, offset + baseCoverageOffset);
				result.baseCoverage = coverage;
			}
			
			if (markArrayOffset != 0)
			{
				var markArray:MarkArray = _markArrayTableParser.parseTable(data, offset + markArrayOffset);
				result.markArray = markArray;
			}
			
			if (baseArrayOffset != 0)
			{
				var baseArray:BaseArray = parseBaseArray(data, offset + baseArrayOffset, classCount);
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
		
		private function parseBaseRecordAnchors(data:ByteArray, offset:uint, baseRecords:Vector.<BaseRecord>):void 
		{
			const l:uint = baseRecords.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var baseRecord:BaseRecord = baseRecords[i];
				
				var al:uint = baseRecord.baseAnchorOffsets.length;
				var anchors:Vector.<AnchorTable> = new Vector.<AnchorTable>(al);
				for (var a:uint = 0; a < al; a++)
				{
					var anchor:AnchorTable = _anchorTableParser.parseTable(data, offset + baseRecord.baseAnchorOffsets[a]);
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
		
	}

}