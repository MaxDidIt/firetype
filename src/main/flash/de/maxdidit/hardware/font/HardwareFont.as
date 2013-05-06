package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.CharacterIndexMappingTableData;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.GlyphTableData;
	import de.maxdidit.hardware.font.parser.IFontParser;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFont 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _data:HardwareFontData;
		private var context3d:Context3D;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFont(context3d:Context3D) 
		{
			this.context3d = context3d;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		// data
		
		public function get data():HardwareFontData 
		{
			return _data;
		}
		
		public function set data(value:HardwareFontData):void 
		{
			_data = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function getHardwareGlyph(charCode:Number, subdivisions:uint):HardwareGlyph
		{
			// TODO: only do this if glyph hasn't been cached yet
			var id:uint = getGlyphIndex(charCode);
			var glyph:Glyph = retrieveGlyph(id);
			
			var paths:Vector.<Vector.<Vertex>> = glyph.retrievePaths(subdivisions);
			
			var hardwareGlyph:HardwareGlyph = new HardwareGlyph();
			hardwareGlyph.initialize(paths, context3d);
			
			return hardwareGlyph;
		}
		
		private function retrieveGlyph(id:uint):Glyph 
		{
			var glyfTable:Table = _data.retrieveTable(TableNames.GLYPH_DATA);
			if (!glyfTable)
			{
				throw new Error("Cannot retrieve glyph, no glyph data table found.");
			}
			
			var glyf:Glyph = (glyfTable.data as GlyphTableData).retrieveGlyph(id);
			return glyf;
		}
		
		private function getGlyphIndex(charCode:Number):int 
		{
			var cmapTable:Table = _data.retrieveTable(TableNames.CHARACTER_INDEX_MAPPING);
			if (!cmapTable)
			{
				throw new Error("Cannot retrieve glyph ID, no character index mapping table found.");
			}
			
			var glyphIndex:int = (cmapTable.data as CharacterIndexMappingTableData).getGlyphIndex(charCode, 3, 1);
			return glyphIndex;
		}
	}

}