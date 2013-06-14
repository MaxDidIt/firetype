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
 
package de.maxdidit.hardware.font.data.tables.required.cmap.sub  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class HighByteMappingTableData implements ICharacterIndexMappingSubtableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _length:uint; 
		private var _language:uint; 
		 
		private var _subHeaderKeys:Vector.<uint>; 
		 
		private var _subHeaders:Vector.<HighByteSubHeader>; 
		private var _glyphIndexArray:Vector.<uint>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function HighByteMappingTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.cmap.sub.ICharacterIndexMappingSubtableData */ 
		 
		// format 
		 
		public function get format():uint  
		{ 
			return 2; 
		} 
		 
		// length 
		 
		public function get length():uint  
		{ 
			return _length; 
		} 
		 
		public function set length(value:uint):void  
		{ 
			_length = value; 
		} 
		 
		// language 
		 
		public function get language():uint  
		{ 
			return _language; 
		} 
		 
		public function set language(value:uint):void  
		{ 
			_language = value; 
		} 
		 
		// subHeaderKeys 
		 
		public function get subHeaderKeys():Vector.<uint>  
		{ 
			return _subHeaderKeys; 
		} 
		 
		public function set subHeaderKeys(value:Vector.<uint>):void  
		{ 
			_subHeaderKeys = value; 
		} 
		 
		// subHeaders 
		 
		public function get subHeaders():Vector.<HighByteSubHeader>  
		{ 
			return _subHeaders; 
		} 
		 
		public function set subHeaders(value:Vector.<HighByteSubHeader>):void  
		{ 
			_subHeaders = value; 
		} 
		 
		// glyphIndexArray 
		 
		public function get glyphIndexArray():Vector.<uint>  
		{ 
			return _glyphIndexArray; 
		} 
		 
		public function set glyphIndexArray(value:Vector.<uint>):void  
		{ 
			_glyphIndexArray = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.data.tables.required.cmap.sub.ICharacterIndexMappingSubtableData */ 
		 
		public function getGlyphIndex(charCode:Number):int  
		{ 
			throw new Error("This function is not yet implemented."); 
		} 
	} 
} 
