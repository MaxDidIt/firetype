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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.ICaretValue;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureGlyphTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _caretCount:uint;
		private var _caretValueOffsets:Vector.<uint>;
		private var _caretValues:Vector.<ICaretValue>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureGlyphTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// caretCount
		
		public function get caretCount():uint 
		{
			return _caretCount;
		}
		
		public function set caretCount(value:uint):void 
		{
			_caretCount = value;
		}
		
		// caretValueOffsets
		
		public function get caretValueOffsets():Vector.<uint> 
		{
			return _caretValueOffsets;
		}
		
		public function set caretValueOffsets(value:Vector.<uint>):void 
		{
			_caretValueOffsets = value;
		}
		
		// caretValues
		
		public function get caretValues():Vector.<ICaretValue> 
		{
			return _caretValues;
		}
		
		public function set caretValues(value:Vector.<ICaretValue>):void 
		{
			_caretValues = value;
		}
		
	}

}