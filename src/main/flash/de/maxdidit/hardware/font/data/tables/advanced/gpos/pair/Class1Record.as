package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Class1Record 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _class2Records:Vector.<Class2Record>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Class1Record() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get class2Records():Vector.<Class2Record> 
		{
			return _class2Records;
		}
		
		public function set class2Records(value:Vector.<Class2Record>):void 
		{
			_class2Records = value;
		}
		
	}

}