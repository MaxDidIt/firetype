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
 
package de.maxdidit.hardware.font.parser.tables.advanced 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment.AttachmentListTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment.AttachmentPointTableData;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AttachmentListTableParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AttachmentListTableParser(dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member 
		///////////////////////
		
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:AttachmentListTableData = new AttachmentListTableData();
			
			result.glyphCoverageOffset = _dataTypeParser.parseUnsignedShort(data);
			result.glyphCount = _dataTypeParser.parseUnsignedShort(data);
			result.attachmentPointOffsets = parseAttachmentsPointOffsets(data, result.glyphCount);
			
			result.coverage = parseGlyphCoverage(data, offset, result.glyphCoverageOffset);
			
			result.attachmentPointTables = parseAttachmentPointTables(data, offset, result.attachmentPointOffsets);
		}
		
		private function parseAttachmentsPointOffsets(data:ByteArray, glyphCount:uint):Vector.<uint> 
		{
			var result:Vector.<uint> = new Vector.<uint>();
			
			for (var i:uint = 0; i < glyphCount; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				result.push(value);
			}
			
			return result;
		}
		
		private function parseGlyphCoverage(data:ByteArray, offset:uint, glyphCoverageOffset:uint):ICoverageTable 
		{
			var parser:CoverageTableParser = new CoverageTableParser(_dataTypeParser);
			var result:ICoverageTable = parser.parseTable(data, offset + glyphCoverageOffset);
			return result;
		}
		
		private function parseAttachmentPointTables(data:ByteArray, offset:uint, attachmentPointOffsets:Vector.<uint>):Vector.<AttachmentPointTableData> 
		{
			var result:Vector.<AttachmentPointTableData> = new Vector.<AttachmentPointTableData>();
			
			const l:uint = attachmentPointOffsets.length;
			for (var i:uint = 0; i < l; i++)
			{
				data.position = offset + attachmentPointOffsets[i];
				
				var attachmentPointTable:AttachmentPointTableData = new AttachmentPointTableData();
				attachmentPointTable.pointCount = _dataTypeParser.parseUnsignedShort(data);
				attachmentPointTable.pointIndices = parseAttachmentPointIndices(data, attachmentPointTable.pointCount);
				
				result.push(attachmentPointTable);
			}
			
			return result;
		}
		
		private function parseAttachmentPointIndices(data:ByteArray, pointCount:uint):Vector.<uint> 
		{
			var result:Vector.<uint> = new Vector.<uint>();
			
			for (var i:uint = 0; i < pointCount; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				result.push(value);
			}
			
			return result;
		}
	}

}