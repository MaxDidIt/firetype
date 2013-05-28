package de.maxdidit.hardware.font.parser.tables.advanced 
{
	import de.maxdidit.hardware.font.data.tables.NotYetImplementedLookupTableData;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NotYetImplementedLookupTableParser implements ISubTableParser 
	{
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NotYetImplementedLookupTableParser() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			return new NotYetImplementedLookupTableData();
		}
		
	}

}