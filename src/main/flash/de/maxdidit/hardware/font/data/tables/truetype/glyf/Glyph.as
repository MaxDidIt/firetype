package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.AxisAlignedBoundingBox;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function retrievePaths(subdivisions:uint):Vector.<Vector.<Vertex>> 
		{
			throw new Error("Can't execute retrieveShape for Glyph. Extend the glyph class and implement this function.");
		}
		
	}

}