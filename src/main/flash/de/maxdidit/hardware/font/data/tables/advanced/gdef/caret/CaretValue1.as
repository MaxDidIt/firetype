package de.maxdidit.hardware.font.data.tables.advanced.gdef.caret 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CaretValue1 implements ICaretValue
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _format:uint;
		private var _coordinate:int;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CaretValue1() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// format
		
		public function get format():uint 
		{
			return 1;
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
		
	}

}