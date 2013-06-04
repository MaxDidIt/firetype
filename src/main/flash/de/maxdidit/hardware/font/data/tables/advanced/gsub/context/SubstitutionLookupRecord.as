package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SubstitutionLookupRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _sequenceIndex:uint;
		private var _lookupListIndex:uint;
		private var _lookupTable:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SubstitutionLookupRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get sequenceIndex():uint 
		{
			return _sequenceIndex;
		}
		
		public function set sequenceIndex(value:uint):void 
		{
			_sequenceIndex = value;
		}
		
		public function get lookupListIndex():uint 
		{
			return _lookupListIndex;
		}
		
		public function set lookupListIndex(value:uint):void 
		{
			_lookupListIndex = value;
		}
		
		public function get lookupTable():LookupTable 
		{
			return _lookupTable;
		}
		
		public function set lookupTable(value:LookupTable):void 
		{
			_lookupTable = value;
		}
		
	}

}