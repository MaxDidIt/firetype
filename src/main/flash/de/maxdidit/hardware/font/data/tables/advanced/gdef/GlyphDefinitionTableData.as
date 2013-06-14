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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment.AttachmentListTableData; 
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable; 
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureCaretListTableData; 
	import de.maxdidit.list.LinkedList; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class GlyphDefinitionTableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _header:GlyphDefinitionHeader; 
		 
		private var _glyphClassDefinitionTable:IClassDefinitionTable; 
		private var _attachmentListTable:AttachmentListTableData; 
		private var _ligatureCaretList:LigatureCaretListTableData; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function GlyphDefinitionTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// header 
		 
		public function get header():GlyphDefinitionHeader  
		{ 
			return _header; 
		} 
		 
		public function set header(value:GlyphDefinitionHeader):void  
		{ 
			_header = value; 
		} 
		 
		// glyphClassDefinitionTable 
		 
		public function get glyphClassDefinitionTable():IClassDefinitionTable  
		{ 
			return _glyphClassDefinitionTable; 
		} 
		 
		public function set glyphClassDefinitionTable(value:IClassDefinitionTable):void  
		{ 
			_glyphClassDefinitionTable = value; 
		} 
		 
		// attachmentListTable 
		 
		public function get attachmentListTable():AttachmentListTableData  
		{ 
			return _attachmentListTable; 
		} 
		 
		public function set attachmentListTable(value:AttachmentListTableData):void  
		{ 
			_attachmentListTable = value; 
		} 
		 
		// ligatureCaretList 
		 
		public function get ligatureCaretList():LigatureCaretListTableData  
		{ 
			return _ligatureCaretList; 
		} 
		 
		public function set ligatureCaretList(value:LigatureCaretListTableData):void  
		{ 
			_ligatureCaretList = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
	} 
} 
