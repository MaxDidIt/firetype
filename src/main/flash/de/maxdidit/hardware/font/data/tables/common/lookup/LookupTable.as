package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LookupTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _lookupFlagData:uint;
		
		private var _subTableCount:uint;
		private var _subTableOffsets:Vector.<uint>;
		
		private var _markFilteringSet:uint;
		
		private var _lookupFlags:LookupTableFlags;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LookupTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get lookupFlagData():uint 
		{
			return _lookupFlagData;
		}
		
		public function set lookupFlagData(value:uint):void 
		{
			_lookupFlagData = value;
		}
		
		public function get subTableCount():uint 
		{
			return _subTableCount;
		}
		
		public function set subTableCount(value:uint):void 
		{
			_subTableCount = value;
		}
		
		public function get subTableOffsets():Vector.<uint> 
		{
			return _subTableOffsets;
		}
		
		public function set subTableOffsets(value:Vector.<uint>):void 
		{
			_subTableOffsets = value;
		}
		
		public function get markFilteringSet():uint 
		{
			return _markFilteringSet;
		}
		
		public function set markFilteringSet(value:uint):void 
		{
			_markFilteringSet = value;
		}
		
		public function get lookupFlags():LookupTableFlags 
		{
			return _lookupFlags;
		}
		
		public function set lookupFlags(value:LookupTableFlags):void 
		{
			_lookupFlags = value;
		}
		
	}

}