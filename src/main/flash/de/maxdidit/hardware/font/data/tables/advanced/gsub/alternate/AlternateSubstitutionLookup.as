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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AlternateSubstitutionLookup implements IGlyphLookup
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _alternateSet:AlternateSetTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AlternateSubstitutionLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get alternateSet():AlternateSetTable 
		{
			return _alternateSet;
		}
		
		public function set alternateSet(value:AlternateSetTable):void 
		{
			_alternateSet = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		// not sure yet how to handle this/how to give the user the choice of which alternate to use
		public function performLookup(characterInstances:LinkedList):void 
		{
		}
	}

}