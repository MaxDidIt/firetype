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
 
package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate.AlternateSetTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate.AlternateSubstitutionSubtable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AlternateSubstitutionSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		private var _coverageTableParser:CoverageTableParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AlternateSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser) 
		{
			this._dataTypeParser = $dataTypeParser;
			this._coverageTableParser = $coverageTableParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:AlternateSubstitutionSubtable = new AlternateSubstitutionSubtable();
			
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data);
			result.coverageOffset = coverageOffset;
			
			var alternateSetCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.alternateSetCount = alternateSetCount;
			
			var alternateSetOffsets:Vector.<uint> = new Vector.<uint>(alternateSetCount);
			for (var i:uint = 0; i < alternateSetCount; i++)
			{
				var offset:uint = _dataTypeParser.parseUnsignedShort(data);
				alternateSetOffsets[i] = offset;
			}
			result.alternateSetOffsets = alternateSetOffsets;
			
			if (coverageOffset > 0)
			{
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + coverageOffset);
				result.coverage = coverage;
			}
			
			var alternateSets:Vector.<AlternateSetTable> = parseSequences(data, alternateSetOffsets, offset);
			result.alternateSets = alternateSets;
			
			return result;
		}
		
		private function parseSequences(data:ByteArray, alternateSetOffsets:Vector.<uint>, offset:uint):Vector.<AlternateSetTable>
		{
			const l:uint = alternateSetOffsets.length;
			var result:Vector.<AlternateSetTable> = new Vector.<AlternateSetTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var sequenceOffset:uint = alternateSetOffsets[i];
				var sequence:AlternateSetTable = parseSequenceTable(data, sequenceOffset + offset);
				
				result[i] = sequence;
			}
			
			return result;
		}
		
		private function parseSequenceTable(data:ByteArray, offset:uint):AlternateSetTable 
		{
			data.position = offset;
			
			var result:AlternateSetTable = new AlternateSetTable();
			
			var glyphCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.glyphCount = glyphCount;
			
			var alternateGlyphIDs:Vector.<uint> = new Vector.<uint>(glyphCount);
			for (var i:uint = 0; i < glyphCount; i++)
			{
				var id:uint = _dataTypeParser.parseUnsignedShort(data);
				alternateGlyphIDs[i] = id;
			}
			result.alternateGlyphIDs = alternateGlyphIDs;
			
			return result;
		}
		
	}

}