package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.tables.NotYetImplementedTableData;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NotYetImplementedSubtableParser implements ISubTableParser 
	{
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NotYetImplementedSubtableParser() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			return new NotYetImplementedTableData();
		}
		
	}

}