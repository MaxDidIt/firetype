package de.maxdidit.hardware.font.data.tables.advanced.gpos 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ValueRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _xPlacement:int = 0;
		private var _yPlacement:int = 0;
		
		private var _xAdvance:int = 0;
		private var _yAdvance:int = 0;
		
		private var _xPlacementDeviceOffset:uint = 0;
		private var _yPlacementDeviceOffset:uint = 0;
		
		private var _xAdvanceDeviceOffset:uint = 0;
		private var _yAdvanceDeviceOffset:uint = 0;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ValueRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get xPlacement():int 
		{
			return _xPlacement;
		}
		
		public function set xPlacement(value:int):void 
		{
			_xPlacement = value;
		}
		
		public function get yPlacement():int 
		{
			return _yPlacement;
		}
		
		public function set yPlacement(value:int):void 
		{
			_yPlacement = value;
		}
		
		public function get xAdvance():int 
		{
			return _xAdvance;
		}
		
		public function set xAdvance(value:int):void 
		{
			_xAdvance = value;
		}
		
		public function get yAdvance():int 
		{
			return _yAdvance;
		}
		
		public function set yAdvance(value:int):void 
		{
			_yAdvance = value;
		}
		
		public function get xPlacementDeviceOffset():uint 
		{
			return _xPlacementDeviceOffset;
		}
		
		public function set xPlacementDeviceOffset(value:uint):void 
		{
			_xPlacementDeviceOffset = value;
		}
		
		public function get yPlacementDeviceOffset():uint 
		{
			return _yPlacementDeviceOffset;
		}
		
		public function set yPlacementDeviceOffset(value:uint):void 
		{
			_yPlacementDeviceOffset = value;
		}
		
		public function get xAdvanceDeviceOffset():uint 
		{
			return _xAdvanceDeviceOffset;
		}
		
		public function set xAdvanceDeviceOffset(value:uint):void 
		{
			_xAdvanceDeviceOffset = value;
		}
		
		public function get yAdvanceDeviceOffset():uint 
		{
			return _yAdvanceDeviceOffset;
		}
		
		public function set yAdvanceDeviceOffset(value:uint):void 
		{
			_yAdvanceDeviceOffset = value;
		}
		
	}

}