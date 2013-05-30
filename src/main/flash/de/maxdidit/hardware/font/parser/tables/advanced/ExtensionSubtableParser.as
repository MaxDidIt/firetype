package de.maxdidit.hardware.font.parser.tables.advanced 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ExtensionSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.ScriptFeatureLookupTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ExtensionSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _scriptFeatureLookupTableParser:ScriptFeatureLookupTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ExtensionSubtableParser($dataTypeParser:DataTypeParser, $scriptFeatureLookupTableParser:ScriptFeatureLookupTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._scriptFeatureLookupTableParser = $scriptFeatureLookupTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:ExtensionSubtable = new ExtensionSubtable();
			
			var substitutionFormat:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var extensionLookupType:uint = _dataTypeParser.parseUnsignedShort(data);
			result.extensionLookupType = extensionLookupType;
			
			var extensionOffset:uint = _dataTypeParser.parseUnsignedLong(data);
			result.extensionOffset = extensionOffset;
			
			var subtableParser:ISubTableParser = _scriptFeatureLookupTableParser.getSubtableParser(String(extensionLookupType));
			var extensionTable:ILookupSubtable = subtableParser.parseTable(data, offset + extensionOffset);
			result.extensionSubtable = extensionTable;
			
			return result;
		}
		
	}

}