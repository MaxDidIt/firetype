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
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.single.SingleSubstitutionSubtable; 
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class SingleSubstitutionSubtableParser implements ISubTableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		private var _coverageTableParser:CoverageTableParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function SingleSubstitutionSubtableParser($dataTypeParser:DataTypeParser, $coverageTableParser:CoverageTableParser) 
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
			 
			var result:SingleSubstitutionSubtable = new SingleSubstitutionSubtable(); 
			 
			var format:uint = _dataTypeParser.parseUnsignedShort(data); 
			 
			var coverageOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.coverageOffset = coverageOffset; 
			 
			if (format == 1) 
			{ 
				var deltaGlyphID:int = _dataTypeParser.parseShort(data); 
				result.deltaGlyphID = deltaGlyphID; 
				 
				result.substituteGlyphCount = 0; 
			} 
			else if (format == 2) 
			{ 
				var glyphCount:uint = _dataTypeParser.parseUnsignedShort(data); 
				result.substituteGlyphCount = glyphCount; 
				 
				var substituteGlyphIDs:Vector.<uint> = new Vector.<uint>(glyphCount); 
				for (var i:uint = 0; i < glyphCount; i++) 
				{ 
					substituteGlyphIDs[i] = _dataTypeParser.parseUnsignedShort(data); 
				} 
				result.substituteGlyphIDs = substituteGlyphIDs; 
			} 
			 
			if (coverageOffset > 0) 
			{ 
				var coverage:ICoverageTable = _coverageTableParser.parseTable(data, offset + coverageOffset); 
				result.coverage = coverage; 
			} 
			 
			return result; 
		} 
		 
	} 
} 
