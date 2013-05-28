package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
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
		
	}

}