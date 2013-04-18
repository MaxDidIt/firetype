package de.maxdidit.hardware.font.data 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SFNTWrapper 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:String;
		private var _numTables:uint;
		private var _searchRange:uint;
		private var _entrySelector:uint;
		private var _rangeShift:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SFNTWrapper() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// version
		
		public function get version():String 
		{
			return _version;
		}
		
		public function set version(value:String):void 
		{
			_version = value;
		}
		
		// numTables
		
		public function get numTables():uint 
		{
			return _numTables;
		}
		
		public function set numTables(value:uint):void 
		{
			_numTables = value;
		}
		
		// searchRange
		
		public function get searchRange():uint 
		{
			return _searchRange;
		}
		
		public function set searchRange(value:uint):void 
		{
			_searchRange = value;
		}
		
		// entrySelector
		
		public function get entrySelector():uint 
		{
			return _entrySelector;
		}
		
		public function set entrySelector(value:uint):void 
		{
			_entrySelector = value;
		}
		
		// rangeShift
		
		public function get rangeShift():uint 
		{
			return _rangeShift;
		}
		
		public function set rangeShift(value:uint):void 
		{
			_rangeShift = value;
		}
		
	}

}