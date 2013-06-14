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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair  
{ 
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup; 
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance; 
	import de.maxdidit.list.LinkedList; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class PairAdjustmentPositioningLookup1 implements IGlyphLookup  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _pairSet:PairSet; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function PairAdjustmentPositioningLookup1()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get pairSet():PairSet  
		{ 
			return _pairSet; 
		} 
		 
		public function set pairSet(value:PairSet):void  
		{ 
			_pairSet = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */ 
		 
		public function performLookup(characterInstances:LinkedList):void  
		{ 
			var currentCharacter:HardwareCharacterInstance = characterInstances.currentElement as HardwareCharacterInstance; 
			var nextCharacter:HardwareCharacterInstance = currentCharacter.next as HardwareCharacterInstance; 
			 
			if (!nextCharacter) 
			{ 
				return; 
			} 
			 
			const l:uint = _pairSet.pairValueCount; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var pair:PairValueRecord = _pairSet.pairValueRecords[i]; 
				if (pair.secondGlyphID == nextCharacter.glyph.header.index) 
				{ 
					currentCharacter.applyAdjustmentValue(pair.value1); 
					nextCharacter.applyAdjustmentValue(pair.value2); 
					return; 
				} 
			} 
		} 
	} 
} 
