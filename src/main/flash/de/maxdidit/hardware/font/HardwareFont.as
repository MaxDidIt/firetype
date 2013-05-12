package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.CharacterIndexMappingTableData;
	import de.maxdidit.hardware.font.data.tables.required.name.NamingTableData;
	import de.maxdidit.hardware.font.data.tables.required.name.NamingTableNameID;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.GlyphTableData;
	import de.maxdidit.hardware.font.parser.IFontParser;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.hardware.text.HardwareCharacterCache;
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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFont()
		{
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
		
		// fontFamily
		
		public function get fontFamily():String
		{
			var namingTableData:NamingTableData = _data.retrieveTable(TableNames.NAMING_TABLE).data as NamingTableData;
			return namingTableData.retrieveString("1", "0", "0", NamingTableNameID.FONT_FAMILY);
		}
		
		public function get fontSubFamily():String
		{
			var namingTableData:NamingTableData = _data.retrieveTable(TableNames.NAMING_TABLE).data as NamingTableData;
			return namingTableData.retrieveString("1", "0", "0", NamingTableNameID.FONT_SUBFAMILY);
		}
		
		public function get uniqueIdentifier():String
		{
			var namingTableData:NamingTableData = _data.retrieveTable(TableNames.NAMING_TABLE).data as NamingTableData;
			return namingTableData.retrieveString("1", "0", "0", NamingTableNameID.UNIQUE_FONT_IDENTIFIER);
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		//public function getHardwareGlyph(index:uint, subdivisions:uint):HardwareGlyph
		//{
			// TODO: only do this if glyph hasn't been cached yet
			//var id:uint = getGlyphIndex(charCode);
			//var glyph:Glyph = retrieveGlyph(index);
			//
			//var paths:Vector.<Vector.<Vertex>> = glyph.retrievePaths(subdivisions);
			//
			//if (paths)
			//{
				//var hardwareGlyph:HardwareGlyph = new HardwareGlyph();
				//hardwareGlyph.initialize(paths, context3d, _triangulator);
				//
				//return hardwareGlyph;
			//}
			//
			//return null;
		//}
		
		public function retrieveGlyph(id:uint):Glyph
		{
			var glyfTable:Table = _data.retrieveTable(TableNames.GLYPH_DATA);
			if (!glyfTable)
			{
				throw new Error("Cannot retrieve glyph, no glyph data table found.");
			}
			
			var glyf:Glyph = (glyfTable.data as GlyphTableData).retrieveGlyph(id);
			if (!glyf.header.hasContour)
			{
				glyf = (glyfTable.data as GlyphTableData).retrieveGlyph(0);
			}
			
			return glyf;
		}
		
		public function getGlyphIndex(charCode:Number):int
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