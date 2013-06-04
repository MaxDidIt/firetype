package de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SequenceTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCount:uint;
		private var _substituteGlyphIDs:Vector.<uint>;
		private var _substituteGlyphs:Vector.<Glyph>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SequenceTable() 
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
		
		public function get substituteGlyphIDs():Vector.<uint> 
		{
			return _substituteGlyphIDs;
		}
		
		public function set substituteGlyphIDs(value:Vector.<uint>):void 
		{
			_substituteGlyphIDs = value;
		}
		
		public function get substituteGlyphs():Vector.<Glyph> 
		{
			return _substituteGlyphs;
		}
		
		public function set substituteGlyphs(value:Vector.<Glyph>):void 
		{
			_substituteGlyphs = value;
		}
		
	}

}