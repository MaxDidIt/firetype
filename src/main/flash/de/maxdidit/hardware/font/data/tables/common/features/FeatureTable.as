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