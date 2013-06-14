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
 
package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LookupListTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _lookupCount:uint;
		private var _lookupOffsets:Vector.<uint>;
		private var _lookupTables:Vector.<LookupTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LookupListTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get lookupCount():uint 
		{
			return _lookupCount;
		}
		
		public function set lookupCount(value:uint):void 
		{
			_lookupCount = value;
		}
		
		public function get lookupOffsets():Vector.<uint> 
		{
			return _lookupOffsets;
		}
		
		public function set lookupOffsets(value:Vector.<uint>):void 
		{
			_lookupOffsets = value;
		}
		
		public function get lookupTables():Vector.<LookupTable> 
		{
			return _lookupTables;
		}
		
		public function set lookupTables(value:Vector.<LookupTable>):void 
		{
			_lookupTables = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function retrieveLookupTables(indices:Vector.<uint>):Vector.<LookupTable>
		{
			const l:uint = indices.length;
			var result:Vector.<LookupTable> = new Vector.<LookupTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var index:uint = indices[i];
				result[i] = _lookupTables[index];
			}
			
			return result;
		}
	}

}