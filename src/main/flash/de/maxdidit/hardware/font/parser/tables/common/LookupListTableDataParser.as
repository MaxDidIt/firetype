/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
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
 
package de.maxdidit.hardware.font.parser.tables.common  
{ 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTableFlags; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LookupListTableDataParser implements ISubTableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LookupListTableDataParser($dataTypeParser:DataTypeParser)  
		{ 
			this._dataTypeParser = $dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */ 
		 
		public function parseTable(data:ByteArray, offset:uint):*  
		{ 
			data.position = offset; 
			 
			var result:LookupListTable = new LookupListTable(); 
			 
			var lookupCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.lookupCount = lookupCount; 
			 
			var lookupOffsets:Vector.<uint> = new Vector.<uint>(lookupCount); 
			for (var i:uint = 0; i < lookupCount; i++) 
			{ 
				lookupOffsets[i] = _dataTypeParser.parseUnsignedShort(data); 
			} 
			result.lookupOffsets = lookupOffsets; 
			 
			return result; 
		} 
		 
		public function parseLookupTable(data:ByteArray):LookupTable  
		{ 
			var result:LookupTable = new LookupTable(); 
			 
			var lookupType:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.lookupType = lookupType; 
			 
			var lookupFlagData:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.lookupFlagData = lookupFlagData; 
			 
			var lookupFlags:LookupTableFlags = parseLookupFlag(lookupFlagData); 
			result.lookupFlags = lookupFlags; 
			 
			var subTableCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.subTableCount = subTableCount; 
			 
			var subTableOffsets:Vector.<uint> = new Vector.<uint>(subTableCount); 
			for (var i:uint = 0; i < subTableCount; i++) 
			{ 
				subTableOffsets[i] = _dataTypeParser.parseUnsignedShort(data); 
			} 
			result.subTableOffsets = subTableOffsets; 
			 
			if (lookupFlags.useMarkFilteringSet) 
			{ 
				var markFilteringSet:uint = _dataTypeParser.parseUnsignedShort(data); 
				result.markFilteringSet = markFilteringSet; 
			} 
			 
			return result; 
		} 
		 
		private function parseLookupFlag(lookupFlagData:uint):LookupTableFlags  
		{ 
			var result:LookupTableFlags = new LookupTableFlags(); 
			 
			result.rightToLeft = (lookupFlagData & 0x1) == 1; 
			 
			result.ignoreBaseGlyphs = ((lookupFlagData >> 1) & 0x1) == 1; 
			result.ignoreLigatures = ((lookupFlagData >> 2) & 0x1) == 1; 
			result.ignoreMarks = ((lookupFlagData >> 3) & 0x1) == 1; 
			 
			result.useMarkFilteringSet = ((lookupFlagData >> 4) & 0x1) == 1; 
			 
			result.markAttachmentType = ((lookupFlagData >> 8) & 0x1) == 1; 
			 
			return result; 
		} 
		 
	} 
} 
