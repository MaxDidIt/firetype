/* 
Copyright ©2013 Max Knoblich 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature.ComponentRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature.LigatureArray;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature.LigatureAttachment;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature.MarkToLigatureAttachmentPositioningSubtable;
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
	public class MarkToLigatureAttachmentPositioningSubtableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageTableParser:CoverageTableParser;
		private var _anchorTableParser:AnchorTableParser;
		private var _markArrayTableParser:MarkArrayTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToLigatureAttachmentPositioningSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser, $anchorTableParser:AnchorTableParser, $markArrayTableParser:MarkArrayTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._coverageTableParser = $coverageTableParser;
			this._anchorTableParser = $anchorTableParser;
			this._markArrayTableParser = $markArrayTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:MarkToLigatureAttachmentPositioningSubtable = new MarkToLigatureAttachmentPositioningSubtable();
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var markCoverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markCoverageOffset = markCoverageOffset;
			
			var ligatureCoverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureCoverageOffset = ligatureCoverageOffset;
			
			var classCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.classCount = classCount;
			
			var markArrayOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.markArrayOffset = markArrayOffset;
			
			var ligatureArrayOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureArrayOffset = ligatureArrayOffset;
			
			if (markCoverageOffset != 0)
			{
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + markCoverageOffset);
				result.markCoverage = coverage;
			}
			
			if (ligatureCoverageOffset != 0)
			{
				coverage = _coverageTableParser.parseTable(data, offset + ligatureCoverageOffset);
				result.ligatureCoverage = coverage;
			}
			
			if (markArrayOffset != 0)
			{
				var markArray:MarkArray = _markArrayTableParser.parseTable(data, offset + markArrayOffset);
				result.markArray = markArray;
			}
			
			if (ligatureArrayOffset != 0)
			{
				var ligatureArray:LigatureArray = parseLigatureArray(data, offset + ligatureArrayOffset, classCount);
				result.ligatureArray = ligatureArray;
			}
			
			return result;
		}
		
		private function parseLigatureArray(data:ByteArray, ligatureArrayOffset:uint, classCount:uint):LigatureArray
		{
			data.position = ligatureArrayOffset;
			
			var result:LigatureArray = new LigatureArray();
			
			var ligatureCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.ligatureCount = ligatureCount;
			
			var ligatureAttachementOffsets:Vector.<uint> = new Vector.<uint>(ligatureCount);
			for (var i:uint = 0; i < ligatureCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				ligatureAttachementOffsets[i] = offset;
			}
			result.ligatureAttachmentOffsets = ligatureAttachementOffsets;
			
			var ligatureAttachments:Vector.<LigatureAttachment> = parseLigatureAttachements(data, ligatureArrayOffset, ligatureAttachementOffsets, classCount);
			result.ligatureAttachments = ligatureAttachments;
			
			return result;
		}
		
		private function parseLigatureAttachements(data:ByteArray, ligatureArrayOffset:uint, ligatureAttachementOffsets:Vector.<uint>, classCount:uint):Vector.<LigatureAttachment> 
		{
			const l:uint = ligatureAttachementOffsets.length;
			
			var ligatureAttachments:Vector.<LigatureAttachment> = new Vector.<LigatureAttachment>(l);
			for (var i:uint = 0; i < l; i++)
			{
				var attachement:LigatureAttachment = parseLigatureAttachement(data, ligatureArrayOffset + ligatureAttachementOffsets[i], classCount);
				ligatureAttachments[i] = attachement;
			}
			
			return ligatureAttachments;
		}
		
		private function parseLigatureAttachement(data:ByteArray, offset:uint, classCount:uint):LigatureAttachment 
		{
			data.position = offset;
			
			var result:LigatureAttachment = new LigatureAttachment();
			
			var componentCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.componentCount = componentCount;
			
			var componentRecords:Vector.<ComponentRecord> = parseComponentRecords(data, offset, componentCount, classCount);
			result.componentRecords = componentRecords;
			
			return result;
		}
		
		private function parseComponentRecords(data:ByteArray, offset:uint, componentCount:uint, classCount:uint):Vector.<ComponentRecord> 
		{
			var result:Vector.<ComponentRecord> = new Vector.<ComponentRecord>(componentCount);
			
			for (var i:uint = 0; i < componentCount; i++)
			{
				var componentRecord:ComponentRecord = parseComponentRecord(data, classCount);
				result[i] = componentRecord;
			}
			
			parseComponentRecordAnchors(data, result, offset);
			
			return result;
		}
		
		private function parseComponentRecordAnchors(data:ByteArray, result:Vector.<ComponentRecord>, offset:uint):void 
		{
			const l:uint = result.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var record:ComponentRecord = result[i];
				
				var rl:uint = record.ligatureAnchorOffsets.length;
				var anchors:Vector.<AnchorTable> = new Vector.<AnchorTable>(rl);
				for (var r:uint = 0; r < rl; r++)
				{
					var anchor:AnchorTable = _anchorTableParser.parseTable(data, offset + record.ligatureAnchorOffsets[r]);
					anchors[r] = anchor;
				}
				
				record.ligatureAnchors = anchors;
			}
		}
		
		private function parseComponentRecord(data:ByteArray, classCount:uint):ComponentRecord 
		{
			var result:ComponentRecord = new ComponentRecord();
			
			var ligatureAnchorOffsets:Vector.<uint> = new Vector.<uint>(classCount);
			for (var i:uint = 0; i < classCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				ligatureAnchorOffsets[i] = offset;
			}
			result.ligatureAnchorOffsets = ligatureAnchorOffsets;
			
			return result;
		}
		
	}

}