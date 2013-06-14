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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ComponentRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ligatureAnchorOffsets:Vector.<uint> ;
		private var _ligatureAnchors:Vector.<AnchorTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ComponentRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ligatureAnchorOffsets():Vector.<uint> 
		{
			return _ligatureAnchorOffsets;
		}
		
		public function set ligatureAnchorOffsets(value:Vector.<uint>):void 
		{
			_ligatureAnchorOffsets = value;
		}
		
		public function get ligatureAnchors():Vector.<AnchorTable>
		{
			return _ligatureAnchors;
		}
		
		public function set ligatureAnchors(value:Vector.<AnchorTable>):void 
		{
			_ligatureAnchors = value;
		}
		
	}

}