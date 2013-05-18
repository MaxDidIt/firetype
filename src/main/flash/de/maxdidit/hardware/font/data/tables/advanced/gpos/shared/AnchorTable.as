package de.maxdidit.hardware.font.data.tables.advanced.gpos.shared 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AnchorTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _xCoordinate:int;
		private var _yCoordinate:int;
		
		private var _anchorPointIndex:int;
		
		private var _xDeviceTableOffset:uint;
		private var _yDeviceTableOffset:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AnchorTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get xCoordinate():int 
		{
			return _xCoordinate;
		}
		
		public function set xCoordinate(value:int):void 
		{
			_xCoordinate = value;
		}
		
		public function get yCoordinate():int 
		{
			return _yCoordinate;
		}
		
		public function set yCoordinate(value:int):void 
		{
			_yCoordinate = value;
		}
		
		public function get anchorPointIndex():int 
		{
			return _anchorPointIndex;
		}
		
		public function set anchorPointIndex(value:int):void 
		{
			_anchorPointIndex = value;
		}
		
		public function get xDeviceTableOffset():uint 
		{
			return _xDeviceTableOffset;
		}
		
		public function set xDeviceTableOffset(value:uint):void 
		{
			_xDeviceTableOffset = value;
		}
		
		public function get yDeviceTableOffset():uint 
		{
			return _yDeviceTableOffset;
		}
		
		public function set yDeviceTableOffset(value:uint):void 
		{
			_yDeviceTableOffset = value;
		}
		
	}

}