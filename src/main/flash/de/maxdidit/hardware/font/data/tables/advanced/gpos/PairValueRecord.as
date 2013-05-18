package de.maxdidit.hardware.font.data.tables.advanced.gpos 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairValueRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _secondGlyphID:uint;
		private var _value1:ValueRecord;
		private var _value2:ValueRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairValueRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get secondGlyphID():uint 
		{
			return _secondGlyphID;
		}
		
		public function set secondGlyphID(value:uint):void 
		{
			_secondGlyphID = value;
		}
		
		public function get value1():ValueRecord 
		{
			return _value1;
		}
		
		public function set value1(value:ValueRecord):void 
		{
			_value1 = value;
		}
		
		public function get value2():ValueRecord 
		{
			return _value2;
		}
		
		public function set value2(value:ValueRecord):void 
		{
			_value2 = value;
		}
		
	}

}