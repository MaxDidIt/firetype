package de.maxdidit.hardware.font.data.tables.advanced.gsub.single 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleSubstitutionLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _substitutionGlyph:Glyph;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SingleSubstitutionLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get substitutionGlyph():Glyph 
		{
			return _substitutionGlyph;
		}
		
		public function set substitutionGlyph(value:Glyph):void 
		{
			_substitutionGlyph = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void
		{
			var currentCharacter:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstance);
			currentCharacter.glyph = _substitutionGlyph;
		}
	}

}