package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.GlyphDefinitionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.GlyphSubstitutionTableData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.CharacterIndexMappingTableData;
	import de.maxdidit.hardware.font.data.tables.required.hhea.HorizontalHeaderData;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.HorizontalMetricsData;
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
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
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
		
		public function get ascender():int
		{
			var horizontalHeaderData:HorizontalHeaderData = _data.retrieveTable(TableNames.HORIZONTAL_HEADER).data as HorizontalHeaderData;
			return horizontalHeaderData.ascender;
		}
		
		public function get descender():int
		{
			var horizontalHeaderData:HorizontalHeaderData = _data.retrieveTable(TableNames.HORIZONTAL_HEADER).data as HorizontalHeaderData;
			return horizontalHeaderData.descender;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function retrieveGlyph(index:uint):Glyph
		{
			var glyfTable:Table = _data.retrieveTable(TableNames.GLYPH_DATA);
			if (!glyfTable)
			{
				throw new Error("Cannot retrieve glyph, no glyph data table found.");
			}
			
			var glyf:Glyph = (glyfTable.data as GlyphTableData).retrieveGlyph(index);
			
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
		
		// deprecated
		public function getGlyphAdvanceWidth(index:uint):uint
		{
			var horizontalMetricsData:HorizontalMetricsData = _data.retrieveTable(TableNames.HORIZONTAL_METRICS).data as HorizontalMetricsData;
			return horizontalMetricsData.getAdvanceWidth(index);
		}
		
		// deprecated
		public function getGlyphLeftSideBearing(index:uint):int
		{
			var horizontalMetricsData:HorizontalMetricsData = _data.retrieveTable(TableNames.HORIZONTAL_METRICS).data as HorizontalMetricsData;
			return horizontalMetricsData.getLeftSideBearing(index);
		}
		
		public function performCharacterSubstitutions(characterInstances:LinkedList, scriptTag:String, languageTag:String):void 
		{
			var gsubTableData:GlyphSubstitutionTableData = _data.retrieveTableData(TableNames.GLYPH_SUBSTITUTION_DATA) as GlyphSubstitutionTableData;
			if (!gsubTableData)
			{
				return;
			}
			
			gsubTableData.applyTable(characterInstances, scriptTag, languageTag);
		}
		
		public function retrieveCharacterDefinitions(characterInstances:LinkedList):void 
		{
			var gdefTableData:GlyphDefinitionTableData = _data.retrieveTableData(TableNames.GLYPH_DEFINITION_DATA) as GlyphDefinitionTableData;
			if (!gdefTableData)
			{
				return;
			}
			
			gdefTableData.applyTable(characterInstances);
		}
	}

}