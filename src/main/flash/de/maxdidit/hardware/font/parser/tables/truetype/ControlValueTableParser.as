package de.maxdidit.hardware.font.parser.tables.truetype 
{
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.data.tables.truetype.ControlValueTableData;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ControlValueTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ControlValueTableParser(dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord):* 
		{
			var result:ControlValueTableData = new ControlValueTableData();
			
			const l:uint = record.length >> 1; // table is filled with 16 byte values
			
			var fwords:Vector.<int> = new Vector.<int>();
			for (var i:uint = 0; i < l; i++)
			{
				var value:int = _dataTypeParser.parseShort(data);
				fwords.push(value);
			}
			result.fwords = fwords;
			
			return result;
		}
		
	}

}