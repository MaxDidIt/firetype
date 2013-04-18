package de.maxdidit.hardware.font.data.tables 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TableRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _tag:String;
		private var _checkSum:uint;
		private var _offset:uint;
		private var _length:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TableRecord()
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// tag
		
		public function get tag():String 
		{
			return _tag;
		}
		
		public function set tag(value:String):void 
		{
			_tag = value;
		}
		
		// checkSum
		
		public function get checkSum():uint 
		{
			return _checkSum;
		}
		
		public function set checkSum(value:uint):void 
		{
			_checkSum = value;
		}
		
		// offset
		
		public function get offset():uint 
		{
			return _offset;
		}
		
		public function set offset(value:uint):void 
		{
			_offset = value;
		}
		
		// length
		
		public function get length():uint 
		{
			return _length;
		}
		
		public function set length(value:uint):void 
		{
			_length = value;
		}
		
	}

}