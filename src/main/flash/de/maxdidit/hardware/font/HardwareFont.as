package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.GlyphDefinitionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.text.format.HardwareFontFeatures;
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
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
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
		
		private var _ascender:int;
		private var _descender:int;
		
		private var _fontFamily:String;
		private var _fontSubFamily:String;
		private var _uniqueIdentifier:String;
		
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
			return _fontFamily;
		}
		
		public function get fontSubFamily():String
		{
			return _fontSubFamily;
		}
		
		public function get uniqueIdentifier():String
		{
			return _uniqueIdentifier
		}
		
		public function get ascender():int
		{
			return _ascender;
		}
		
		public function get descender():int
		{
			return _descender;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function finalize():void
		{
			var horizontalHeaderData:HorizontalHeaderData = _data.retrieveTable(TableNames.HORIZONTAL_HEADER).data as HorizontalHeaderData;
			_ascender = horizontalHeaderData.ascender;
			_descender = horizontalHeaderData.descender;
			
			var namingTableData:NamingTableData = _data.retrieveTable(TableNames.NAMING_TABLE).data as NamingTableData;
			_fontFamily = namingTableData.retrieveString("1", "0", "0", NamingTableNameID.FONT_FAMILY);
			_fontSubFamily = namingTableData.retrieveString("1", "0", "0", NamingTableNameID.FONT_SUBFAMILY);
			_uniqueIdentifier = namingTableData.retrieveString("1", "0", "0", NamingTableNameID.UNIQUE_FONT_IDENTIFIER);
		}
		
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
		
		public function performCharacterSubstitutions(characterInstances:LinkedList, scriptTag:String, languageTag:String, activatedFeatures:HardwareFontFeatures ):void 
		{
			var gsubTableData:GlyphSubstitutionTableData = _data.retrieveTableData(TableNames.GLYPH_SUBSTITUTION_DATA) as GlyphSubstitutionTableData;
			if (!gsubTableData)
			{
				return;
			}
			
			gsubTableData.applyTable(characterInstances, scriptTag, languageTag, activatedFeatures);
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
		
		public function getAdvancedFeatures(standardScript:String, standardLanguage:String):Vector.<FeatureRecord> 
		{
			var gsubTableData:GlyphSubstitutionTableData = _data.retrieveTableData(TableNames.GLYPH_SUBSTITUTION_DATA) as GlyphSubstitutionTableData;
			var gposTableData:GlyphPositioningTableData = _data.retrieveTableData(TableNames.GLYPH_POSITIONING_DATA) as GlyphPositioningTableData;
			
			var result:Vector.<FeatureRecord> = new Vector.<FeatureRecord>();
			
			if (gsubTableData)
			{
				result = gsubTableData.retrieveFeatures(standardScript, standardLanguage).concat(result);
			}
			
			if (gposTableData)
			{
				result = gposTableData.retrieveFeatures(standardScript, standardLanguage).concat(result);
			}
			
			return result;
		}
	}

}