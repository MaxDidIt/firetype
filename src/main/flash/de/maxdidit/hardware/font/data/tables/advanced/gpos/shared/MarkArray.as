package de.maxdidit.hardware.font.data.tables.advanced.gpos.shared 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkArray 
	{
		///////////////////////
		// Member Fields
		///////////////////////

		private var _markCount:uint;
		private var _markRecords:Vector.<MarkRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkArray() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get markCount():uint 
		{
			return _markCount;
		}
		
		public function set markCount(value:uint):void 
		{
			_markCount = value;
		}
		
		public function get markRecords():Vector.<MarkRecord> 
		{
			return _markRecords;
		}
		
		public function set markRecords(value:Vector.<MarkRecord>):void 
		{
			_markRecords = value;
		}
		
	}

}