package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Class2Record 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _value1:ValueRecord;
		private var _value2:ValueRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Class2Record() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get value1():ValueRecord 
		{
			return _value1;
		}
		
		public function set value1(value:ValueRecord):void 
		{
			_value1 = value;
		}
		
		public function get value2():ValueRecord 
		{
			return _value2;
		}
		
		public function set value2(value:ValueRecord):void 
		{
			_value2 = value;
		}
		
	}

}