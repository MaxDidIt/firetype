package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphs:Vector.<Glyph>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// glyphs
		
		public function get glyphs():Vector.<Glyph> 
		{
			return _glyphs;
		}
		
		public function set glyphs(value:Vector.<Glyph>):void 
		{
			_glyphs = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function retrieveGlyph(id:uint):Glyph 
		{
			if (id >= _glyphs.length)
			{
				return null;
			}
			
			return _glyphs[id];
		}
		
	}

}