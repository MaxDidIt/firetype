package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ILookupSubtable 
	{
		function get parent():LookupTable;
		function set parent(value:LookupTable):void;
		
		function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup
		function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void
	}

}