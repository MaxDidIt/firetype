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
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment.AttachmentListTableData;
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.GlyphDefinitionHeader;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.GlyphDefinitionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureCaretListTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.ClassDefinitionTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphDefinitionTableParser implements ITableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphDefinitionTableParser(dataTypeParser:DataTypeParser) 
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
			
			var result:GlyphDefinitionTableData = new GlyphDefinitionTableData();
			
			result.header = parseGlyphDefinitionTableHeader(data);
			result.glyphClassDefinitionTable = parseGlyphClassDefinitionTable(data, record.offset, result.header.glyphClassDefinitionsOffset);
			result.attachmentListTable = parseAttachmentListTable(data, record.offset, result.header.attachmentListTableOffset);
			result.ligatureCaretList = parseLigatureGlyphTable(data, record.offset, result.header.ligatureCaretListOffset);
			
			return result;
		}
		
		private function parseLigatureGlyphTable(data:ByteArray, offset:uint, ligatureCaretListOffset:uint):LigatureCaretListTableData 
		{
			if (ligatureCaretListOffset == 0)
			{
				return null;
			}
			
			var parser:LigatureCaretListTableParser = new LigatureCaretListTableParser(_dataTypeParser);
			var result:LigatureCaretListTableData = parser.parseTable(data, offset + ligatureCaretListOffset);
			return result;
		}
		
		private function parseAttachmentListTable(data:ByteArray, offset:uint, attachmentListTableOffset:uint):AttachmentListTableData 
		{
			if (attachmentListTableOffset == 0)
			{
				return null;
			}
			
			var parser:AttachmentListTableParser = new AttachmentListTableParser(_dataTypeParser);
			var result:AttachmentListTableData = parser.parseTable(data, offset + attachmentListTableOffset);
			return result;
		}
		
		private function parseGlyphDefinitionTableHeader(data:ByteArray):GlyphDefinitionHeader 
		{
			var header:GlyphDefinitionHeader = new GlyphDefinitionHeader();
			
			header.version = _dataTypeParser.parseUnsignedLong(data);
			
			header.glyphClassDefinitionsOffset = _dataTypeParser.parseUnsignedShort(data);
			header.attachmentListTableOffset = _dataTypeParser.parseUnsignedShort(data);
			header.ligatureCaretListOffset = _dataTypeParser.parseUnsignedShort(data);
			header.markAttachmentsClassDefinitionsOffset = _dataTypeParser.parseUnsignedShort(data);
			
			if (header.version == 0x00010002)
			{
				header.markGlyphSetsOffset = _dataTypeParser.parseUnsignedShort(data);
			}
			
			return header;
		}
		
		private function parseGlyphClassDefinitionTable(data:ByteArray, offset:uint, glyphClassDefinitionsOffset:uint):IClassDefinitionTable 
		{
			if (glyphClassDefinitionsOffset == 0)
			{
				return null;
			}
			
			var parser:ClassDefinitionTableParser = new ClassDefinitionTableParser(_dataTypeParser);
			var result:IClassDefinitionTable = parser.parseTable(data, offset + glyphClassDefinitionsOffset);
			
			return result;
		}
		
	}

}