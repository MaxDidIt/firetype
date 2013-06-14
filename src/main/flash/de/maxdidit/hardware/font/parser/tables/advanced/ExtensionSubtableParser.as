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