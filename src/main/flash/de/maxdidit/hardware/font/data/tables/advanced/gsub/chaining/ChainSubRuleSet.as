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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainSubRuleSet 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _chainSubRuleCount:uint;
		private var _chainSubRuleOffsets:Vector.<uint>;
		private var _chainSubRules:Vector.<ChainSubRule>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainSubRuleSet() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get chainSubRuleCount():uint 
		{
			return _chainSubRuleCount;
		}
		
		public function set chainSubRuleCount(value:uint):void 
		{
			_chainSubRuleCount = value;
		}
		
		public function get chainSubRuleOffsets():Vector.<uint> 
		{
			return _chainSubRuleOffsets;
		}
		
		public function set chainSubRuleOffsets(value:Vector.<uint>):void 
		{
			_chainSubRuleOffsets = value;
		}
		
		public function get chainSubRules():Vector.<ChainSubRule> 
		{
			return _chainSubRules;
		}
		
		public function set chainSubRules(value:Vector.<ChainSubRule>):void 
		{
			_chainSubRules = value;
		}
		
	}

}