package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.extension.ExtensionSubstitutionSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ExtensionSubstitutionSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _glyphSubstitutionTableParser:GlyphSubstitutionTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ExtensionSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $glyphSubstitutionTableParser:GlyphSubstitutionTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._glyphSubstitutionTableParser = $glyphSubstitutionTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:ExtensionSubstitutionSubtable = new ExtensionSubstitutionSubtable();
			
			var substitutionFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var extensionLookupType:uint = _dataTypeParser.parseUnsignedShort(data);
			result.extensionLookupType = extensionLookupType;
			
			var extensionOffset:uint = _dataTypeParser.parseUnsignedLong(data);
			result.extensionOffset = extensionOffset;
			
			var subtableParser:ISubTableParser = _glyphSubstitutionTableParser.getSubtableParser(String(extensionLookupType));
			var extensionTable:ILookupSubtable = subtableParser.parseTable(data, offset + extensionOffset);
			result.extensionSubtable = extensionTable;
			
			return result;
		}
		
	}

}