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
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark.Mark2Array;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark.Mark2Record;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark.MarkToMarkAttachmentPositioningSubtable;
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
	public class MarkToMarkAttachmentPositioningSubtableParser implements ISubTableParser 
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
		
		public function MarkToMarkAttachmentPositioningSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser, $anchorTableParser:AnchorTableParser, $markArrayTableParser:MarkArrayTableParser) 
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
			
			var result:MarkToMarkAttachmentPositioningSubtable = new MarkToMarkAttachmentPositioningSubtable();
			
			var posFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var mark1CoverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.mark1CoverageOffset = mark1CoverageOffset;
			
			var mark2CoverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.mark2CoverageOffset = mark2CoverageOffset;
			
			var classCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.classCount = classCount;
			
			var mark1ArrayOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.mark1ArrayOffset = mark1ArrayOffset;
			
			var mark2ArrayOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.mark2ArrayOffset = mark2ArrayOffset;
			
			if (mark1CoverageOffset != 0)
			{
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + mark1CoverageOffset);
				result.mark1Coverage = coverage;
			}
			
			if (mark2CoverageOffset != 0)
			{
				coverage = _coverageTableParser.parseTable(data, offset + mark2CoverageOffset);
				result.mark2Coverage = coverage;
			}
			
			if (mark1ArrayOffset != 0)
			{
				var markArray:MarkArray = _markArrayTableParser.parseTable(data, offset + mark1ArrayOffset);
				result.mark1Array = markArray;
			}
			
			if (mark2ArrayOffset != 0)
			{
				var mark2Array:Mark2Array = parseMark2Array(data, offset + mark2ArrayOffset, classCount);
				result.mark2Array = mark2Array;
			}
			
			return result;
		}
		
		private function parseMark2Array(data:ByteArray, mark2ArrayOffset:uint, classCount:uint):Mark2Array
		{
			data.position = mark2ArrayOffset;
			
			var result:Mark2Array = new Mark2Array();
			
			var mark2Count:uint = _dataTypeParser.parseUnsignedShort(data);
			result.mark2Count = mark2Count;
			
			var mark2Records:Vector.<Mark2Record> = parseMark2Records(data, mark2Count, mark2ArrayOffset, classCount);
			result.mark2Records = mark2Records;
			
			return result;
		}
		
		private function parseMark2Records(data:ByteArray, mark2Count:uint, mark2ArrayOffset:uint, classCount:uint):Vector.<Mark2Record> 
		{
			var result:Vector.<Mark2Record> = new Vector.<Mark2Record>(mark2Count);
			
			for (var i:uint = 0; i < mark2Count; i++)
			{
				var record:Mark2Record = parseMark2Record(data, classCount);
				result[i] = record;
			}
			
			parseMark2RecordAnchors(data, result, mark2ArrayOffset);
			
			return result;
		}
		
		private function parseMark2RecordAnchors(data:ByteArray, result:Vector.<Mark2Record>, mark2ArrayOffset:uint):void 
		{
			const l:uint = result.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var mark2Record:Mark2Record = result[i];
				var rl:uint = mark2Record.mark2AnchorOffsets.length;
				
				var anchors:Vector.<AnchorTable> = new Vector.<AnchorTable>(rl);
				for (var r:uint = 0; r < rl; r++)
				{
					var anchor:AnchorTable = _anchorTableParser.parseTable(data, mark2ArrayOffset + mark2Record.mark2AnchorOffsets[r]);
					anchors[r] = anchor;
				}
				
				mark2Record.mark2Anchors = anchors;
			}
		}
		
		private function parseMark2Record(data:ByteArray, classCount:uint):Mark2Record 
		{
			var result:Mark2Record = new Mark2Record();
			
			var mark2AnchorOffsets:Vector.<uint> = new Vector.<uint>(classCount);
			for (var i:uint = 0; i < classCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				mark2AnchorOffsets[i] = offset;
			}
			result.mark2AnchorOffsets = mark2AnchorOffsets;
			
			return result;
		}
		
	}

}