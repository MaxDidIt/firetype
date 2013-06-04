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
				var newCharacter:HardwareCharacterInstance = new HardwareCharacterInstance();
				
				newCharacter.charCode = 0;
				newCharacter.glyph = _sequence.substituteGlyphs[i];
				//newCharacter.textFormat = currentCharacter.textFormat;
				
				characterInstances.addElementAfter(newCharacter, currentCharacter);
			}
			
		}
	}

}