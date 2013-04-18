package de.maxdidit.hardware.font.data.tables 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Table 
	{
		///////////////////////
		// Member Properties
		///////////////////////
		
		private var _record:TableRecord;
		private var _data:*;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Table() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// record
		
		public function get record():TableRecord 
		{
			return _record;
		}
		
		public function set record(value:TableRecord):void 
		{
			_record = value;
		}
		
		//  data
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
	}

}