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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MultipleSubstitutionLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _sequence:SequenceTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MultipleSubstitutionLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get sequence():SequenceTable 
		{
			return _sequence;
		}
		
		public function set sequence(value:SequenceTable):void 
		{
			_sequence = value;
		}
		
		///////////////////////
		// 
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void 
		{
			var currentCharacter:HardwareCharacterInstance = characterInstances.currentElement as HardwareCharacterInstance;
			currentCharacter.glyph = _sequence.substituteGlyphs[0];
			
			const l:uint = _sequence.glyphCount;
			for (var i:uint = 1; i < _sequence.glyphCount; i++)
			{
				var newCharacter:HardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance();
				
				newCharacter.charCode = 0;
				newCharacter.glyph = _sequence.substituteGlyphs[i];
				//newCharacter.textFormat = currentCharacter.textFormat;
				
				characterInstances.addElementAfter(newCharacter, currentCharacter);
			}
			
		}
	}

}