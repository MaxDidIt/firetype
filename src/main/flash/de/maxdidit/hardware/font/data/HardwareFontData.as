package de.maxdidit.hardware.font.data 
{
	import de.maxdidit.hardware.font.data.tables.Table;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _sfntWrapper:SFNTWrapper;
		private var _tables:Vector.<Table>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// sfntWrapper
		
		public function get sfntWrapper():SFNTWrapper 
		{
			return _sfntWrapper;
		}
		
		public function set sfntWrapper(value:SFNTWrapper):void 
		{
			_sfntWrapper = value;
		}
		
		// tables
		
		public function get tables():Vector.<Table> 
		{
			return _tables;
		}
		
		public function set tables(value:Vector.<Table>):void 
		{
			_tables = value;
		}
		
		
		
	}

}