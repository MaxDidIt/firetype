/* 
Copyright ©2013 Max Knoblich 
 
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
 
package de.maxdidit.hardware.font.data.tables.advanced 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ExtensionSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _extensionLookupType:uint;
		private var _extensionOffset:uint;
		private var _extensionSubtable:ILookupSubtable;
		
		private var _parent:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ExtensionSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get extensionLookupType():uint 
		{
			return _extensionLookupType;
		}
		
		public function set extensionLookupType(value:uint):void 
		{
			_extensionLookupType = value;
		}
		
		public function get extensionOffset():uint 
		{
			return _extensionOffset;
		}
		
		public function set extensionOffset(value:uint):void 
		{
			_extensionOffset = value;
		}
		
		public function get extensionSubtable():ILookupSubtable 
		{
			return _extensionSubtable;
		}
		
		public function set extensionSubtable(value:ILookupSubtable):void 
		{
			_extensionSubtable = value;
			if (_extensionSubtable)
			{
				_extensionSubtable.parent = _parent;
			}
		}
		
		public function get parent():LookupTable 
		{
			return _parent;
		}
		
		public function set parent(value:LookupTable):void 
		{
			_parent = value;
			if (_extensionSubtable)
			{
				_extensionSubtable.parent = _parent;
			}
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		//public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		//{
			//_extensionSubtable.performLookup(characterInstances, parent);
		//}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			_extensionSubtable.resolveDependencies(parent, font);
		}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup 
		{
			return _extensionSubtable.retrieveGlyphLookup(glyphIndex, coverageIndex, font);
		}
		
	}

}