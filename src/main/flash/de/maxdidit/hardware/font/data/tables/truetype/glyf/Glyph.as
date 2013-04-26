package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Glyph
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _header:GlyphHeader;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Glyph() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// header
		
		public function get header():GlyphHeader 
		{
			return _header;
		}
		
		public function set header(value:GlyphHeader):void 
		{
			_header = value;
		}
		
	}

}