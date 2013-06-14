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
	public class SubRuleTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCount:uint;
		private var _substitutionLookupCount:uint;
		
		private var _inputGlyphIDs:Vector.<uint>;
		private var _substitutionLookupRecords:Vector.<SubstitutionLookupRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SubRuleTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get glyphCount():uint 
		{
			return _glyphCount;
		}
		
		public function set glyphCount(value:uint):void 
		{
			_glyphCount = value;
		}
		
		public function get substitutionLookupCount():uint 
		{
			return _substitutionLookupCount;
		}
		
		public function set substitutionLookupCount(value:uint):void 
		{
			_substitutionLookupCount = value;
		}
		
		public function get inputGlyphIDs():Vector.<uint> 
		{
			return _inputGlyphIDs;
		}
		
		public function set inputGlyphIDs(value:Vector.<uint>):void 
		{
			_inputGlyphIDs = value;
		}
		
		public function get substitutionLookupRecords():Vector.<SubstitutionLookupRecord> 
		{
			return _substitutionLookupRecords;
		}
		
		public function set substitutionLookupRecords(value:Vector.<SubstitutionLookupRecord>):void 
		{
			_substitutionLookupRecords = value;
		}
		
	}

}