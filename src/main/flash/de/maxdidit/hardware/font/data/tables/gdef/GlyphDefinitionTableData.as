package de.maxdidit.hardware.font.data.tables.gdef 
{
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
		
	}

}