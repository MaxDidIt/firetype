package de.maxdidit.hardware.font.data.tables.truetype 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ControlValueTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _fwords:Vector.<int>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ControlValueTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// fwords
		
		public function get fwords():Vector.<int> 
		{
			return _fwords;
		}
		
		public function set fwords(value:Vector.<int>):void 
		{
			_fwords = value;
		}
		
	}

}