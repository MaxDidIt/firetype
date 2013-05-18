package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairSet 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _pairValueCount:uint;
		private var _pairValueRecords:Vector.<PairValueRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairSet() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get pairValueCount():uint 
		{
			return _pairValueCount;
		}
		
		public function set pairValueCount(value:uint):void 
		{
			_pairValueCount = value;
		}
		
		public function get pairValueRecords():Vector.<PairValueRecord> 
		{
			return _pairValueRecords;
		}
		
		public function set pairValueRecords(value:Vector.<PairValueRecord>):void 
		{
			_pairValueRecords = value;
		}
		
	}

}