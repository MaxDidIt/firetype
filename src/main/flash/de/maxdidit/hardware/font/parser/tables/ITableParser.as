package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ITableParser 
	{
		function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):*;
	}

}