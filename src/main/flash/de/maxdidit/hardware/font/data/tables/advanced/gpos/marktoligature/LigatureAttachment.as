package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureAttachment
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _componentCount:uint;
		private var _componentRecords:Vector.<ComponentRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureAttachment() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get componentCount():uint 
		{
			return _componentCount;
		}
		
		public function set componentCount(value:uint):void 
		{
			_componentCount = value;
		}
		
		public function get componentRecords():Vector.<ComponentRecord> 
		{
			return _componentRecords;
		}
		
		public function set componentRecords(value:Vector.<ComponentRecord>):void 
		{
			_componentRecords = value;
		}
		
	}

}