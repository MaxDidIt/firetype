package de.maxdidit.hardware.font.data.tables.truetype 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LocationTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _offsets:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LocationTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// offsets
		
		public function get offsets():Vector.<uint> 
		{
			return _offsets;
		}
		
		public function set offsets(value:Vector.<uint>):void 
		{
			_offsets = value;
		}
		
	}

}