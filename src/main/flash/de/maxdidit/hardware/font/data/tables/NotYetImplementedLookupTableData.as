package de.maxdidit.hardware.font.data.tables 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	
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
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):IGlyphLookup
		{
			throw new Error("This type of lookup table is not yet implemented");
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			//throw new Error("This type of lookup table is not yet implemented");
		}
		
		public function get parent():LookupTable 
		{
			throw new Error("This type of lookup table is not yet implemented");
		}
		
		public function set parent(value:LookupTable):void 
		{
			
		}
		
	}

}