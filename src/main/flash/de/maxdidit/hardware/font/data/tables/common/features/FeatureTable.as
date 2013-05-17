package de.maxdidit.hardware.font.data.tables.common.features 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FeatureTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _lookupCount:uint;
		private var _lookupListIndices:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FeatureTable() 
		{
			
		}
		
		///////////////////////
		// Member Propertes
		///////////////////////
		
		// lookupCount
		
		public function get lookupCount():uint 
		{
			return _lookupCount;
		}
		
		public function set lookupCount(value:uint):void 
		{
			_lookupCount = value;
		}
		
		// lookupListIndex
		
		public function get lookupListIndices():Vector.<uint>
		{
			return _lookupListIndices;
		}
		
		public function set lookupListIndices(value:Vector.<uint>):void
		{
			_lookupListIndices = value;
		}
		
	}

}