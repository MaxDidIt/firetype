package de.maxdidit.hardware.font.data.tables.gdef 
{
	import de.maxdidit.hardware.font.data.tables.attachment.AttachmentListTableData;
	import de.maxdidit.hardware.font.data.tables.classes.IClassDefinitionTable;
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
		
	}

}