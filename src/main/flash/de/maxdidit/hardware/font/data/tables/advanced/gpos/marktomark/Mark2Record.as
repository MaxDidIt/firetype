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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Mark2Record 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _mark2AnchorOffsets:Vector.<uint>;
		private var _mark2Anchors:Vector.<AnchorTable>;

		///////////////////////
		// Constructor
		///////////////////////
		
		public function Mark2Record() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get mark2AnchorOffsets():Vector.<uint> 
		{
			return _mark2AnchorOffsets;
		}
		
		public function set mark2AnchorOffsets(value:Vector.<uint>):void 
		{
			_mark2AnchorOffsets = value;
		}
		
		public function get mark2Anchors():Vector.<AnchorTable> 
		{
			return _mark2Anchors;
		}
		
		public function set mark2Anchors(value:Vector.<AnchorTable>):void 
		{
			_mark2Anchors = value;
		}
		
	}

}