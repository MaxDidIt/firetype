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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphDefinitionHeader 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:uint;
		
		private var _glyphClassDefinitionsOffset:uint;
		private var _attachmentListTableOffset:uint;
		private var _ligatureCaretListOffset:uint;
		private var _markAttachmentsClassDefinitionsOffset:uint;
		private var _markGlyphSetsOffset:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphDefinitionHeader() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// version
		
		public function get version():uint 
		{
			return _version;
		}
		
		public function set version(value:uint):void 
		{
			_version = value;
		}
		
		// glyphClassDefinitionsOffset
		
		public function get glyphClassDefinitionsOffset():uint 
		{
			return _glyphClassDefinitionsOffset;
		}
		
		public function set glyphClassDefinitionsOffset(value:uint):void 
		{
			_glyphClassDefinitionsOffset = value;
		}
		
		// attachmentPointListOffset
		
		public function get attachmentListTableOffset():uint 
		{
			return _attachmentListTableOffset;
		}
		
		public function set attachmentListTableOffset(value:uint):void 
		{
			_attachmentListTableOffset = value;
		}
		
		// ligatureCaretListOffset
		
		public function get ligatureCaretListOffset():uint 
		{
			return _ligatureCaretListOffset;
		}
		
		public function set ligatureCaretListOffset(value:uint):void 
		{
			_ligatureCaretListOffset = value;
		}
		
		// markAttachmentsClassDefinitionsOffset
		
		public function get markAttachmentsClassDefinitionsOffset():uint 
		{
			return _markAttachmentsClassDefinitionsOffset;
		}
		
		public function set markAttachmentsClassDefinitionsOffset(value:uint):void 
		{
			_markAttachmentsClassDefinitionsOffset = value;
		}
		
		// markGlyphSetsOffset
		
		public function get markGlyphSetsOffset():uint 
		{
			return _markGlyphSetsOffset;
		}
		
		public function set markGlyphSetsOffset(value:uint):void 
		{
			_markGlyphSetsOffset = value;
		}
		
	}

}