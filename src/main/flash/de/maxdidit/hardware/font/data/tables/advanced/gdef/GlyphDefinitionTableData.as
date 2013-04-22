package de.maxdidit.hardware.font.data.tables.advanced.gdef 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment.AttachmentListTableData;
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature.LigatureCaretListTableData;
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
		
	}

}