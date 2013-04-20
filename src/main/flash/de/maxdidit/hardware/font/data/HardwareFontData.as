package de.maxdidit.hardware.font.data 
{
	import de.maxdidit.hardware.font.data.tables.Table;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontData 
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
		// Member Properties
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
		
		
		
	}

}