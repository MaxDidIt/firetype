package de.maxdidit.hardware.font.data 
{
	import de.maxdidit.hardware.font.data.tables.Table;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontData implements ITableMap
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _sfntWrapper:SFNTWrapper;
		private var _tables:Vector.<Table>;
		private var _tableMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// sfntWrapper
		
		public function get sfntWrapper():SFNTWrapper 
		{
			return _sfntWrapper;
		}
		
		public function set sfntWrapper(value:SFNTWrapper):void 
		{
			_sfntWrapper = value;
		}
		
		// tables
		
		public function get tables():Vector.<Table> 
		{
			return _tables;
		}
		
		public function set tables(value:Vector.<Table>):void 
		{
			_tables = value;
			
			mapTables();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function mapTables():void 
		{
			if (!_tableMap)
			{
				_tableMap = new Object();
			}
			
			const l:uint = _tables.length;
			for (var i:uint = 0; i < l; i++)
			{
				_tableMap[_tables[i].record.tag] = _tables[i];
			}
		}
		
		/* INTERFACE de.maxdidit.hardware.font.data.ITableMap */
		
		public function retrieveTable(tag:String):Table 
		{
			if (!_tableMap.hasOwnProperty(tag))
			{
				// TODO: User feedback
				return null;
			}
			
			return _tableMap[tag];
		}
		
		public function registerTable(table:Table):void 
		{
			_tableMap[table.record.tag] = table;
		}
		
		public function retrieveTableData(tag:String):* 
		{
			var table:Table = retrieveTable(tag);
			if (!table)
			{
				return null;
			}
			
			return table.data;
		}
		
	}

}