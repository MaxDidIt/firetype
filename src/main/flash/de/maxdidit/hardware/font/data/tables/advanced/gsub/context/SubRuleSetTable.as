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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SubRuleSetTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _subRuleCount:uint;
		private var _subRuleOffsets:Vector.<uint>;
		private var _subRules:Vector.<SubRuleTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SubRuleSetTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get subRuleCount():uint 
		{
			return _subRuleCount;
		}
		
		public function set subRuleCount(value:uint):void 
		{
			_subRuleCount = value;
		}
		
		public function get subRuleOffsets():Vector.<uint> 
		{
			return _subRuleOffsets;
		}
		
		public function set subRuleOffsets(value:Vector.<uint>):void 
		{
			_subRuleOffsets = value;
		}
		
		public function get subRules():Vector.<SubRuleTable> 
		{
			return _subRules;
		}
		
		public function set subRules(value:Vector.<SubRuleTable>):void 
		{
			_subRules = value;
		}
		
	}

}