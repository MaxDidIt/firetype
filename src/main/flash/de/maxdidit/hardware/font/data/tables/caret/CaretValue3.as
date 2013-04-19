package de.maxdidit.hardware.font.data.tables.caret 
{
	import de.maxdidit.hardware.font.data.tables.device.DeviceTableData;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CaretValue3 implements ICaretValue
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _format:uint;
		private var _coordinate:int;
		
		private var _deviceTableOffset:uint;
		private var _deviceTable:DeviceTableData;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CaretValue3() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// format
		
		public function get format():uint 
		{
			return 3;
		}
		
		// coordinate
		
		public function get coordinate():int 
		{
			return _coordinate;
		}
		
		public function set coordinate(value:int):void 
		{
			_coordinate = value;
		}
		
		// deviceTableOffset
		
		public function get deviceTableOffset():uint 
		{
			return _deviceTableOffset;
		}
		
		public function set deviceTableOffset(value:uint):void 
		{
			_deviceTableOffset = value;
		}
		
		// deviceTable
		
		public function get deviceTable():DeviceTableData 
		{
			return _deviceTable;
		}
		
		public function set deviceTable(value:DeviceTableData):void 
		{
			_deviceTable = value;
		}
		
	}

}