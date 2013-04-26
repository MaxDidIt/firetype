package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.NotYetImplementedTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NotYetImplementedParser implements ITableParser 
	{
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NotYetImplementedParser() 
		{
			
		}
		
		///////////////////////
		// Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):* 
		{
			return new NotYetImplementedTableData();
		}
		
	}

}