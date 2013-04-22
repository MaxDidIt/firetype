package de.maxdidit.hardware.font.data.tables.advanced.gdef.classes 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ClassRangeRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _start:uint;
		private var _end:uint;
		private var _classValue:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ClassRangeRecord() 
		{
			
		}
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		// start
		
		public function get start():uint 
		{
			return _start;
		}
		
		public function set start(value:uint):void 
		{
			_start = value;
		}
		
		// end
		
		public function get end():uint 
		{
			return _end;
		}
		
		public function set end(value:uint):void 
		{
			_end = value;
		}
		
		// classValue
		
		public function get classValue():uint 
		{
			return _classValue;
		}
		
		public function set classValue(value:uint):void 
		{
			_classValue = value;
		}
		
	}

}