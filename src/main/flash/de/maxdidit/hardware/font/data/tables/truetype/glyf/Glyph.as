package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	import de.maxdidit.math.AxisAlignedBoundingBox;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.hardware.text.HardwareCharacterCache;
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
		
		public function retrieveHardwareCharacter(font:HardwareFont, subdivisions:uint, cache:HardwareCharacterCache):HardwareCharacter
		{
			throw new Error("Can't execute retrieveHardwareCharacter for Glyph. Extend the glyph class and implement this function.");
		}
		
	}

}