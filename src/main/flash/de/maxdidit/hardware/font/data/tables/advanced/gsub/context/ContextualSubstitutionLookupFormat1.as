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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.context  
{ 
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup; 
	import de.maxdidit.hardware.font.data.tables.required.cmap.CharacterIndexMappingTableData; 
	import de.maxdidit.hardware.font.HardwareFont; 
	import de.maxdidit.hardware.font.parser.tables.TableNames; 
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance; 
	import de.maxdidit.list.LinkedList; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ContextualSubstitutionLookupFormat1 implements IGlyphLookup  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _subruleSetTable:SubRuleSetTable; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ContextualSubstitutionLookupFormat1()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get subruleSetTable():SubRuleSetTable  
		{ 
			return _subruleSetTable; 
		} 
		 
		public function set subruleSetTable(value:SubRuleSetTable):void  
		{ 
			_subruleSetTable = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */ 
		 
		public function performLookup(characterInstances:LinkedList):void  
		{ 
			var subRules:Vector.<SubRuleTable> = _subruleSetTable.subRules; 
			const l:uint = subRules.length; 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var subRule:SubRuleTable = subRules[i]; 
				 
				if (!matchInputGlyphs(characterInstances, subRule.inputGlyphIDs)) 
				{ 
					continue; 
				} 
				 
				var rl:uint = subRule.substitutionLookupCount; 
				var substitutionLookupRecords:Vector.<SubstitutionLookupRecord> = subRule.substitutionLookupRecords; 
				for (var r:uint = 0; r < rl; r++) 
				{ 
					var substitutionLookupRecord:SubstitutionLookupRecord = substitutionLookupRecords[r]; 
					//substitutionLookupRecord.lookupTable.; 
				} 
			} 
		} 
		 
		private function matchInputGlyphs(characterInstances:LinkedList, inputGlyphIDs:Vector.<uint>):Boolean  
		{ 
			var currentCharacter:HardwareCharacterInstance = characterInstances.currentElement as HardwareCharacterInstance; 
			 
			var cc:uint = inputGlyphIDs.length; 
			 
			for (var c:uint = 0; c < cc; c++) 
			{ 
				currentCharacter = currentCharacter.next as HardwareCharacterInstance; 
				if (!currentCharacter) 
				{ 
					return false; 
				} 
				 
				if (currentCharacter.glyph.header.index != inputGlyphIDs[c]) 
				{ 
					return false; 
				} 
			} 
			 
			return true; 
		} 
		 
	} 
} 
