package de.maxdidit.hardware.font.data.tables.coverage 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class RangeRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _start:uint;
		private var _end:uint;
		private var _startCoverageIndex:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function RangeRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
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
		
		// startCoverageIndex
		
		public function get startCoverageIndex():uint 
		{
			return _startCoverageIndex;
		}
		
		public function set startCoverageIndex(value:uint):void 
		{
			_startCoverageIndex = value;
		}
		
		
		
	}

}