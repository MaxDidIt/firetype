package de.maxdidit.hardware.font.data.tables.gdef 
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
		private var _attachementPointListOffset:uint;
		private var _ligatureCaretListOffset:uint;
		private var _markAttachementsClassDefinitionsOffset:uint;
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
		
		// attachementPointListOffset
		
		public function get attachementPointListOffset():uint 
		{
			return _attachementPointListOffset;
		}
		
		public function set attachementPointListOffset(value:uint):void 
		{
			_attachementPointListOffset = value;
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
		
		// markAttachementsClassDefinitionsOffset
		
		public function get markAttachementsClassDefinitionsOffset():uint 
		{
			return _markAttachementsClassDefinitionsOffset;
		}
		
		public function set markAttachementsClassDefinitionsOffset(value:uint):void 
		{
			_markAttachementsClassDefinitionsOffset = value;
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