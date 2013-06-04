package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface IGlyphLookup 
	{
		function performLookup(characterInstances:LinkedList):void;
	}
	
}