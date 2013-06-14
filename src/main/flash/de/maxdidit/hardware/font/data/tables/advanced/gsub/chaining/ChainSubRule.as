/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
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
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ChainSubRule  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
	 
		private var _backtrackGlyphCount:uint; 
		private var _backtrackGlyphIDs:Vector.<uint>; 
		 
		private var _inputGlyphCount:uint; 
		private var _inputGlyphIDs:Vector.<uint>; 
		 
		private var _lookaheadGlyphCount:uint; 
		private var _lookaheadGlyphIDs:Vector.<uint>; 
		 
		private var _substitutionCount:uint; 
		private var _substitutionLookupRecords:Vector.<SubstitutionLookupRecord>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ChainSubRule()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get backtrackGlyphCount():uint  
		{ 
			return _backtrackGlyphCount; 
		} 
		 
		public function set backtrackGlyphCount(value:uint):void  
		{ 
			_backtrackGlyphCount = value; 
		} 
		 
		public function get backtrackGlyphIDs():Vector.<uint>  
		{ 
			return _backtrackGlyphIDs; 
		} 
		 
		public function set backtrackGlyphIDs(value:Vector.<uint>):void  
		{ 
			_backtrackGlyphIDs = value; 
		} 
		 
		public function get inputGlyphCount():uint  
		{ 
			return _inputGlyphCount; 
		} 
		 
		public function set inputGlyphCount(value:uint):void  
		{ 
			_inputGlyphCount = value; 
		} 
		 
		public function get inputGlyphIDs():Vector.<uint>  
		{ 
			return _inputGlyphIDs; 
		} 
		 
		public function set inputGlyphIDs(value:Vector.<uint>):void  
		{ 
			_inputGlyphIDs = value; 
		} 
		 
		public function get lookaheadGlyphCount():uint  
		{ 
			return _lookaheadGlyphCount; 
		} 
		 
		public function set lookaheadGlyphCount(value:uint):void  
		{ 
			_lookaheadGlyphCount = value; 
		} 
		 
		public function get lookaheadGlyphIDs():Vector.<uint>  
		{ 
			return _lookaheadGlyphIDs; 
		} 
		 
		public function set lookaheadGlyphIDs(value:Vector.<uint>):void  
		{ 
			_lookaheadGlyphIDs = value; 
		} 
		 
		public function get substitutionCount():uint  
		{ 
			return _substitutionCount; 
		} 
		 
		public function set substitutionCount(value:uint):void  
		{ 
			_substitutionCount = value; 
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
