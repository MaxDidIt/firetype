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