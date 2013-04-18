package de.maxdidit.hardware.font.parser.tables 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ITableParser 
	{
		function parseTable(data:ByteArray, offset:uint):*;
	}

}