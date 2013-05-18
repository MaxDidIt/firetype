package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class BaseArray 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _baseCount:uint;
		private var _baseRecords:Vector.<BaseRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function BaseArray() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get baseCount():uint 
		{
			return _baseCount;
		}
		
		public function set baseCount(value:uint):void 
		{
			_baseCount = value;
		}
		
		public function get baseRecords():Vector.<BaseRecord> 
		{
			return _baseRecords;
		}
		
		public function set baseRecords(value:Vector.<BaseRecord>):void 
		{
			_baseRecords = value;
		}
		
	}

}