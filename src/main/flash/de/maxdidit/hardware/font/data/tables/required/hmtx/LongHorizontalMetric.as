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
		
		private var _advancedWidth:uint;
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
		
		public function get advancedWidth():uint 
		{
			return _advancedWidth;
		}
		
		public function set advancedWidth(value:uint):void 
		{
			_advancedWidth = value;
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