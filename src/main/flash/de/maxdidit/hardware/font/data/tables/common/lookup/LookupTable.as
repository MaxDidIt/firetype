/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
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
		 
		public function addGlyphLookups(glyphIndex:uint, coverageIndex:int, lookups:Vector.<IGlyphLookup>, font:HardwareFont):void  
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
