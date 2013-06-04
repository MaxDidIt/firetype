package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainingContextSubstitutionLookupFormat1 implements IGlyphLookup
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _chainSubruleSetTable:ChainSubRuleSet;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainingContextSubstitutionLookupFormat1() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get chainSubruleSetTable():ChainSubRuleSet 
		{
			return _chainSubruleSetTable;
		}
		
		public function set chainSubruleSetTable(value:ChainSubRuleSet):void 
		{
			_chainSubruleSetTable = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void 
		{
			throw new Error("Not yet implemented.");
		}
	}

}