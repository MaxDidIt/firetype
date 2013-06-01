package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	import de.maxdidit.math.AxisAlignedBoundingBox;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
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
		
		private var _glyphClass:uint;
		
		private var _advanceWidth:uint;
		private var _leftSideBearing:int;
		
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
		
		public function get advanceWidth():uint 
		{
			return _advanceWidth;
		}
		
		public function set advanceWidth(value:uint):void 
		{
			_advanceWidth = value;
		}
		
		public function get leftSideBearing():int 
		{
			return _leftSideBearing;
		}
		
		public function set leftSideBearing(value:int):void 
		{
			_leftSideBearing = value;
		}
		
		public function get glyphClass():uint 
		{
			return _glyphClass;
		}
		
		public function set glyphClass(value:uint):void 
		{
			_glyphClass = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function resolveDependencies(glyphTableData:GlyphTableData):void
		{
			// This glyph doesn't have any dependencies, everything is awesome;
		}
		
		public function retrievePaths(subdivisions:uint):Vector.<Vector.<Vertex>> 
		{
			throw new Error("Can't execute retrieveShape for Glyph. Extend the Glyph class and implement this function.");
		}
		
		public function retrieveHardwareCharacter(font:HardwareFont, subdivisions:uint, cache:HardwareCharacterCache):HardwareCharacter
		{
			throw new Error("Can't execute retrieveHardwareCharacter for Glyph. Extend the Glyph class and implement this function.");
		}
		
	}

}