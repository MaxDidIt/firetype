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
 
package de.maxdidit.hardware.font.data.tables.required.cmap.sub 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ByteEncodingTableData implements ICharacterIndexMappingSubtableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _length:uint;
		private var _language:uint;
		
		private var _glyphIDs:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ByteEncodingTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.cmap.sub.ICharacterIndexMappingSubtableData */
		
		public function get format():uint 
		{
			return 0;
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
		
		// glyphIDs
		
		public function get glyphIDs():Vector.<uint> 
		{
			return _glyphIDs;
		}
		
		public function set glyphIDs(value:Vector.<uint>):void 
		{
			_glyphIDs = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.required.cmap.sub.ICharacterIndexMappingSubtableData */
		
		public function getGlyphIndex(charCode:Number):int 
		{
			if (charCode >= _glyphIDs.length)
			{
				return 0;
			}
			
			var glyphIndex:int = _glyphIDs[charCode];
			return glyphIndex;
		}
		
	}

}