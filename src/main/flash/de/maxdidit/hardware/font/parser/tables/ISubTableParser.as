package de.maxdidit.hardware.font.parser.tables 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ISubTableParser 
	{
		function parseTable(data:ByteArray, offset:uint):*;
	}
	
}