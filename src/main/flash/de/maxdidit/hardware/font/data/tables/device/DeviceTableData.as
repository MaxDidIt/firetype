package de.maxdidit.hardware.font.data.tables.device 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class DeviceTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _startSize:uint;
		private var _endSize:uint;
		
		private var _deltaFormat:uint;
		private var _deltaValues:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function DeviceTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// startSize
		
		public function get startSize():uint 
		{
			return _startSize;
		}
		
		public function set startSize(value:uint):void 
		{
			_startSize = value;
		}
		
		// endSize
		
		public function get endSize():uint 
		{
			return _endSize;
		}
		
		public function set endSize(value:uint):void 
		{
			_endSize = value;
		}
		
		// deltaFormat
		
		public function get deltaFormat():uint 
		{
			return _deltaFormat;
		}
		
		public function set deltaFormat(value:uint):void 
		{
			_deltaFormat = value;
			// TODO: can't be anything else than 1, 2 or 3
		}
		
		// deltaValues
		
		public function get deltaValues():Vector.<uint> 
		{
			return _deltaValues;
		}
		
		public function set deltaValues(value:Vector.<uint>):void 
		{
			_deltaValues = value;
		}
		
	}

}