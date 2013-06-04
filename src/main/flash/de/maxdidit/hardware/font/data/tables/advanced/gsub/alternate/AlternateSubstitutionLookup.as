package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AlternateSubstitutionLookup implements IGlyphLookup
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _alternateSet:AlternateSetTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AlternateSubstitutionLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get alternateSet():AlternateSetTable 
		{
			return _alternateSet;
		}
		
		public function set alternateSet(value:AlternateSetTable):void 
		{
			_alternateSet = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		// not sure yet how to handle this/how to give the user the choice of which alternate to use
		public function performLookup(characterInstances:LinkedList):void 
		{
		}
	}

}