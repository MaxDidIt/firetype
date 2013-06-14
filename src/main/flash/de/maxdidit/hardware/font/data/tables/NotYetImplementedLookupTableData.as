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
 
package de.maxdidit.hardware.font.data.tables  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable; 
	import de.maxdidit.hardware.font.HardwareFont; 
	import de.maxdidit.list.LinkedList; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class NotYetImplementedLookupTableData implements ILookupSubtable  
	{ 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function NotYetImplementedLookupTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */ 
		 
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void  
		{ 
			throw new Error("This type of lookup table is not yet implemented"); 
		} 
		 
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup 
		{ 
			throw new Error("This type of lookup table is not yet implemented"); 
		} 
		 
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void  
		{ 
			//throw new Error("This type of lookup table is not yet implemented"); 
		} 
		 
		public function get parent():LookupTable  
		{ 
			throw new Error("This type of lookup table is not yet implemented"); 
		} 
		 
		public function set parent(value:LookupTable):void  
		{ 
			 
		} 
		 
	} 
} 
