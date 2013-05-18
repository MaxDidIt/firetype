package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Mark2Array 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _mark2Count:uint;
		private var _mark2Records:Vector.<Mark2Record>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Mark2Array() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get mark2Count():uint 
		{
			return _mark2Count;
		}
		
		public function set mark2Count(value:uint):void 
		{
			_mark2Count = value;
		}
		
		public function get mark2Records():Vector.<Mark2Record> 
		{
			return _mark2Records;
		}
		
		public function set mark2Records(value:Vector.<Mark2Record>):void 
		{
			_mark2Records = value;
		}
		
	}

}