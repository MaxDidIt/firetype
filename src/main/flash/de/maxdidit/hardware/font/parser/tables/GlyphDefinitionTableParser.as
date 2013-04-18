package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.tables.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.data.tables.gdef.GlyphDefinitionHeader;
	import de.maxdidit.hardware.font.data.tables.gdef.GlyphDefinitionTableData;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
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
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:GlyphDefinitionTableData = new GlyphDefinitionTableData();
			
			result.header = parseGlyphDefinitionTableHeader(data);
			result.glyphClassDefinitionTable = parseGlyphClassDefinitionTable(data, offset, result.header.glyphClassDefinitionsOffset);
			
			return result;
		}
		
		private function parseGlyphDefinitionTableHeader(data:ByteArray):GlyphDefinitionHeader 
		{
			var header:GlyphDefinitionHeader = new GlyphDefinitionHeader();
			
			header.version = _dataTypeParser.parseUnsignedLong(data);
			
			header.glyphClassDefinitionsOffset = _dataTypeParser.parseUnsignedShort(data);
			header.attachementPointListOffset = _dataTypeParser.parseUnsignedShort(data);
			header.ligatureCaretListOffset = _dataTypeParser.parseUnsignedShort(data);
			header.markAttachementsClassDefinitionsOffset = _dataTypeParser.parseUnsignedShort(data);
			
			if (header.version == 0x00010002)
			{
				header.markGlyphSetsOffset = _dataTypeParser.parseUnsignedShort(data);
			}
			
			return header;
		}
		
		private function parseGlyphClassDefinitionTable(data:ByteArray, offset:uint, glyphClassDefinitionsOffset:uint):IClassDefinitionTable 
		{
			var parser:ClassDefinitionTableParser = new ClassDefinitionTableParser(_dataTypeParser);
			var result:IClassDefinitionTable = parser.parseTable(data, offset + glyphClassDefinitionsOffset);
			
			return result;
		}
		
	}

}