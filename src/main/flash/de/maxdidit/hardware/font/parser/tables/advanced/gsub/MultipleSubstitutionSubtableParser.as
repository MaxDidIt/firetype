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
 
package de.maxdidit.hardware.font.parser.tables.advanced.gsub  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple.MultipleSubstitutionSubtable; 
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple.SequenceTable; 
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class MultipleSubstitutionSubtableParser implements ISubTableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		private var _coverageTableParser:CoverageTableParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function MultipleSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser)  
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
			 
			var result:MultipleSubstitutionSubtable = new MultipleSubstitutionSubtable(); 
			 
			var format:uint = _dataTypeParser.parseUnsignedShort(data); 
			 
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.coverageOffset = coverageOffset; 
			 
			var sequenceCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.sequenceCount = sequenceCount; 
			 
			var sequenceOffsets:Vector.<uint> = new Vector.<uint>(sequenceCount); 
			for (var i:uint = 0; i < sequenceCount; i++) 
			{ 
				var sequenceOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
				sequenceOffsets[i] = sequenceOffset; 
			} 
			result.sequenceOffsets = sequenceOffsets; 
			 
			if (coverageOffset > 0) 
			{ 
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + coverageOffset); 
				result.coverage = coverage; 
			} 
			 
			var sequences:Vector.<SequenceTable> = parseSequences(data, sequenceOffsets, offset); 
			result.sequences = sequences; 
			 
			return result; 
		} 
		 
		private function parseSequences(data:ByteArray, sequenceOffsets:Vector.<uint>, offset:uint):Vector.<SequenceTable> 
		{ 
			const l:uint = sequenceOffsets.length; 
			var result:Vector.<SequenceTable> = new Vector.<SequenceTable>(l); 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var sequenceOffset:uint = sequenceOffsets[i]; 
				var sequence:SequenceTable = parseSequenceTable(data, sequenceOffset + offset); 
				 
				result[i] = sequence; 
			} 
			 
			return result; 
		} 
		 
		private function parseSequenceTable(data:ByteArray, offset:uint):SequenceTable  
		{ 
			data.position = offset; 
			 
			var result:SequenceTable = new SequenceTable(); 
			 
			var glyphCount:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.glyphCount = glyphCount; 
			 
			var substitutionGlyphIDs:Vector.<uint> = new Vector.<uint>(glyphCount); 
			for (var i:uint = 0; i < glyphCount; i++) 
			{ 
				var id:uint = _dataTypeParser.parseUnsignedShort(data); 
				substitutionGlyphIDs[i] = id; 
			} 
			result.substituteGlyphIDs = substitutionGlyphIDs; 
			 
			return result; 
		} 
		 
	} 
} 
