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
 
package de.maxdidit.hardware.font.data.tables.common.classes  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ClassDefinitionTableData1 implements IClassDefinitionTable 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _classFormat:uint; 
		private var _startGlyphID:uint; 
		private var _glyphCount:uint; 
		 
		private var _classValues:Vector.<uint>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ClassDefinitionTableData1()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// classFormat 
		 
		public function get classFormat():uint  
		{ 
			return _classFormat; 
		} 
		 
		public function set classFormat(value:uint):void  
		{ 
			// TODO: If this is set to anything else than 1, something's wrong 
			_classFormat = value; 
		} 
		 
		// startGlyphID 
		 
		public function get startGlyphID():uint  
		{ 
			return _startGlyphID; 
		} 
		 
		public function set startGlyphID(value:uint):void  
		{ 
			_startGlyphID = value; 
		} 
		 
		// glyphCount 
		 
		public function get glyphCount():uint  
		{ 
			return _glyphCount; 
		} 
		 
		public function set glyphCount(value:uint):void  
		{ 
			_glyphCount = value; 
		} 
		 
		// classValues 
		 
		public function get classValues():Vector.<uint>  
		{ 
			return _classValues; 
		} 
		 
		public function set classValues(value:Vector.<uint>):void  
		{ 
			_classValues = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable */ 
		 
		public function getGlyphClassByID(glyphID:uint):uint  
		{ 
			if (glyphID < _startGlyphID) 
			{ 
				return 0; 
			} 
			 
			if (glyphID - _startGlyphID >= _glyphCount) 
			{ 
				return 0; 
			} 
			 
			return _classValues[glyphID - _startGlyphID]; 
		} 
	} 
} 
