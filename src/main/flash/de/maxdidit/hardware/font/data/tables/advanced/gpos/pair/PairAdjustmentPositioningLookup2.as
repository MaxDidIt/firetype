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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairAdjustmentPositioningLookup2 implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _classDefinition2:IClassDefinitionTable;
		private var _class1Record:Class1Record;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairAdjustmentPositioningLookup2() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get classDefinition2():IClassDefinitionTable 
		{
			return _classDefinition2;
		}
		
		public function set classDefinition2(value:IClassDefinitionTable):void 
		{
			_classDefinition2 = value;
		}
		
		public function get class1Record():Class1Record
		{
			return _class1Record;
		}
		
		public function set class1Record(value:Class1Record):void 
		{
			_class1Record = value;
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
			
			var class2:uint = _classDefinition2.getGlyphClassByID(nextCharacter.glyph.header.index);
			
			var class2Record:Class2Record = _class1Record.class2Records[class2];
			
			currentCharacter.applyAdjustmentValue(class2Record.value1);
			nextCharacter.applyAdjustmentValue(class2Record.value2);
		}
	}

}