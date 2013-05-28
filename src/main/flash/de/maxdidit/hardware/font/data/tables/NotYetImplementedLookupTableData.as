package de.maxdidit.hardware.font.data.tables 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NotYetImplementedLookupTableData implements ILookupSubtable 
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NotYetImplementedLookupTableData() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		{
			throw new Error("This type of lookup table is not yet implemented");
		}
		
	}

}