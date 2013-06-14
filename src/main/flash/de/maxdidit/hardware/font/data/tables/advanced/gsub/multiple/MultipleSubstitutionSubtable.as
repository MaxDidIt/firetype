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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	import de.maxdidit.hardware.font.HardwareFont; 
	import de.maxdidit.hardware.font.parser.tables.TableNames; 
	import de.maxdidit.list.LinkedList; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class MultipleSubstitutionSubtable implements ILookupSubtable  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _coverageOffset:uint; 
		private var _coverage:ICoverageTable; 
		 
		private var _sequenceCount:uint; 
		private var _sequenceOffsets:Vector.<uint>; 
		private var _sequences:Vector.<SequenceTable>; 
		 
		private var _parent:LookupTable; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function MultipleSubstitutionSubtable()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get coverageOffset():uint  
		{ 
			return _coverageOffset; 
		} 
		 
		public function set coverageOffset(value:uint):void  
		{ 
			_coverageOffset = value; 
		} 
		 
		public function get coverage():ICoverageTable  
		{ 
			return _coverage; 
		} 
		 
		public function set coverage(value:ICoverageTable):void  
		{ 
			_coverage = value; 
		} 
		 
		public function get sequenceCount():uint  
		{ 
			return _sequenceCount; 
		} 
		 
		public function set sequenceCount(value:uint):void  
		{ 
			_sequenceCount = value; 
		} 
		 
		public function get sequenceOffsets():Vector.<uint>  
		{ 
			return _sequenceOffsets; 
		} 
		 
		public function set sequenceOffsets(value:Vector.<uint>):void  
		{ 
			_sequenceOffsets = value; 
		} 
		 
		public function get sequences():Vector.<SequenceTable>  
		{ 
			return _sequences; 
		} 
		 
		public function set sequences(value:Vector.<SequenceTable>):void  
		{ 
			_sequences = value; 
		} 
		 
		public function get parent():LookupTable  
		{ 
			return _parent; 
		} 
		 
		public function set parent(value:LookupTable):void  
		{ 
			_parent = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */ 
		 
		//public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		//{ 
			//var currentInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance; 
			//var coverageIndex:int = _coverage.getCoverageIndex(currentInstance.glyphID); 
			//if (coverageIndex == -1) 
			//{ 
				//return; 
			//} 
			// 
			//var sequence:SequenceTable = _sequences[coverageIndex]; 
			//currentInstance.glyphID = sequence.substituteGlyphIDs[0]; 
			// 
			//for (var i:uint = 1; i < sequence.glyphCount; i++) 
			//{ 
				//var glyphID:uint = sequence.substituteGlyphIDs[i]; 
				// 
				//currentInstance = HardwareCharacterInstance.getHardwareCharacterInstance(null); 
				//currentInstance.glyphID = glyphID; 
				// 
				//var newElement:HardwareCharacterInstanceListElement = new HardwareCharacterInstanceListElement(currentInstance); 
				//characterInstances.addElementAfter(newElement, characterInstances.currentElement); 
				// 
				//characterInstances.gotoNextElement(); 
			//} 
		//} 
		 
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup 
		{ 
			var actualCoverageIndex:int = coverageIndex; 
			if (coverageIndex == -1) 
			{ 
				actualCoverageIndex = _coverage.getCoverageIndex(glyphIndex); 
			} 
			 
			var sequence:SequenceTable = _sequences[actualCoverageIndex]; 
			 
			var result:MultipleSubstitutionLookup = new MultipleSubstitutionLookup(); 
			result.sequence = sequence; 
			 
			return result; 
		} 
		 
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{ 
			const l:uint = _sequenceCount; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var sequence:SequenceTable = _sequences[i]; 
				 
				var gl:uint = sequence.glyphCount; 
				var substituteGlyphs:Vector.<Glyph> = new Vector.<Glyph>(gl); 
				 
				for (var g:uint = 0; g < gl; g++) 
				{ 
					var glyph:Glyph = font.retrieveGlyph(sequence.substituteGlyphIDs[g]); 
					substituteGlyphs[g] = glyph; 
				} 
				 
				sequence.substituteGlyphs = substituteGlyphs; 
			} 
			 
			_coverage.iterateOverCoveredIndices(assignGlyphLookup, font); 
		} 
		 
		private function assignGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):void  
		{ 
			var targetGlyph:Glyph = font.retrieveGlyph(glyphIndex); 
			targetGlyph.addGlyphLookup(TableNames.GLYPH_SUBSTITUTION_DATA, _parent.lookupIndex, retrieveGlyphLookup(glyphIndex, coverageIndex, font)); 
		} 
	} 
} 
