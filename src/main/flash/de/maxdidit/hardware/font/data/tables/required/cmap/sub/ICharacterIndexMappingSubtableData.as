package de.maxdidit.hardware.font.data.tables.required.cmap.sub
{
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ICharacterIndexMappingSubtableData
	{
		function get format():uint;
		
		function get length():uint;
		function set length(value:uint):void;
		
		function get language():uint;
		function set language(value:uint):void;
	}

}