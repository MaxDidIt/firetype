package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ILookupSubtable 
	{
		function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void;
	}

}