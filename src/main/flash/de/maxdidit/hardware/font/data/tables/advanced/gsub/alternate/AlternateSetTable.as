package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AlternateSetTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCount:uint;
		private var _alternateGlyphIDs:Vector.<uint>;
		private var _alternateGlyphs:Vector.<Glyph>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AlternateSetTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get glyphCount():uint 
		{
			return _glyphCount;
		}
		
		public function set glyphCount(value:uint):void 
		{
			_glyphCount = value;
		}
		
		public function get alternateGlyphIDs():Vector.<uint> 
		{
			return _alternateGlyphIDs;
		}
		
		public function set alternateGlyphIDs(value:Vector.<uint>):void 
		{
			_alternateGlyphIDs = value;
		}
		
		public function get alternateGlyphs():Vector.<Glyph> 
		{
			return _alternateGlyphs;
		}
		
		public function set alternateGlyphs(value:Vector.<Glyph>):void 
		{
			_alternateGlyphs = value;
		}
		
	}

}