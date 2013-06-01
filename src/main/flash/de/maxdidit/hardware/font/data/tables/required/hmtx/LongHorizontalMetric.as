package de.maxdidit.hardware.font.data.tables.required.hmtx 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LongHorizontalMetric 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _advanceWidth:uint;
		private var _leftSideBearing:int;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LongHorizontalMetric() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get advanceWidth():uint 
		{
			return _advanceWidth;
		}
		
		public function set advanceWidth(value:uint):void 
		{
			_advanceWidth = value;
		}
		
		public function get leftSideBearing():int 
		{
			return _leftSideBearing;
		}
		
		public function set leftSideBearing(value:int):void 
		{
			_leftSideBearing = value;
		}
		
	}

}