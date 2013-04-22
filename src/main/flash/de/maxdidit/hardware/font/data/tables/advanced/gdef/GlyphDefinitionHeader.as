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