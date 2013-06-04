package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LookupTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _lookupType:uint;
		
		private var _lookupIndex:uint;
		private var _lookupFlagData:uint;
		private var _lookupFlags:LookupTableFlags;
		
		private var _subTableCount:uint;
		private var _subTableOffsets:Vector.<uint>;
		private var _subTables:Vector.<ILookupSubtable>;
		
		private var _markFilteringSet:uint;
		
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
		
		public function get subTables():Vector.<ILookupSubtable> 
		{
			return _subTables;
		}
		
		public function set subTables(value:Vector.<ILookupSubtable>):void 
		{
			_subTables = value;
		}
		
		public function get lookupType():uint 
		{
			return _lookupType;
		}
		
		public function set lookupType(value:uint):void 
		{
			_lookupType = value;
		}
		
		public function get lookupIndex():uint 
		{
			return _lookupIndex;
		}
		
		public function set lookupIndex(value:uint):void 
		{
			_lookupIndex = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		//public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		//{
			//for (var i:uint = 0; i < _subTableCount; i++)
			//{
				//var subTable:ILookupSubtable = _subTables[i];
				//if (subTable)
				//{
					//subTable.performLookup(characterInstances, parent);
				//}
			//}
		//}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			for (var i:uint = 0; i < _subTableCount; i++)
			{
				var subTable:ILookupSubtable = _subTables[i];
				if (subTable)
				{
					subTable.resolveDependencies(parent, font);
				}
			}
		}
		
		public function addGlyphLookups(glyphIndex:uint, coverageIndex:uint, lookups:Vector.<IGlyphLookup>, font:HardwareFont):void 
		{
			for (var i:uint = 0; i < _subTableCount; i++)
			{
				var subTable:ILookupSubtable = _subTables[i];
				if (subTable)
				{
					lookups.push(subTable.retrieveGlyphLookup(glyphIndex, coverageIndex, font));
				}
			}
		}
		
	}

}