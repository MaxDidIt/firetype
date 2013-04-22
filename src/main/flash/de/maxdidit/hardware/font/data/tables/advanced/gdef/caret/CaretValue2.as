package de.maxdidit.hardware.font.data.tables.advanced.gdef.caret 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CaretValue2 implements ICaretValue
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _format:uint;
		private var _pointIndex:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CaretValue2() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// format
		
		public function get format():uint 
		{
			return 2;
		}
		
		// pointIndex
		
		public function get pointIndex():uint 
		{
			return _pointIndex;
		}
		
		public function set pointIndex(value:uint):void 
		{
			_pointIndex = value;
		}
		
	}

}