package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.GlyphDefinitionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.LongHorizontalMetric;
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
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFont
	{
		///////////////////////
		// Constant
		///////////////////////
		
		static public const RANDOM_TAG_LENGTH:uint = 8;
		
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
			
			if (!_uniqueIdentifier || _uniqueIdentifier == "")
			{
				// generate random tag
				var start:int = getTimer(); // use get timer to prevent collisions with other random tags.
				_uniqueIdentifier = "fontID 0x" + start.toString(16);
			}
			else if(_fontSubFamily || _fontSubFamily == "")
			{
				_uniqueIdentifier += " " + _fontSubFamily;
			}
			else
			{
				_uniqueIdentifier += " ID 0x" + getTimer().toString(16);
			}
			
			// resolve dependencies between tables/compile font values
			applyHorizontalMetrics();
			applyGlyphClassDefinitions();
			resolveComponentDependencies();
			resolveSubstitutionDependencies();
			resolvePositioningDependencies();
		}
		
		private function resolveSubstitutionDependencies():void 
		{
			var glyphSubstitutionTableData:GlyphSubstitutionTableData = _data.retrieveTableData(TableNames.GLYPH_SUBSTITUTION_DATA) as GlyphSubstitutionTableData;
			if (!glyphSubstitutionTableData)
			{
				return;
			}
			
			var glyphTableData:GlyphTableData = _data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
			if (!glyphTableData)
			{
				return;
			}
			
			var lookupTables:Vector.<LookupTable> = glyphSubstitutionTableData.lookupListTable.lookupTables;
			const ll:uint = lookupTables.length;
			
			for (var j:uint = 0; j < ll; j++)
			{
				lookupTables[j].resolveDependencies(glyphSubstitutionTableData, this);
			}
		}
		
		private function resolvePositioningDependencies():void 
		{
			var glyphPositioningTableData:GlyphPositioningTableData = _data.retrieveTableData(TableNames.GLYPH_POSITIONING_DATA) as GlyphPositioningTableData;
			if (!glyphPositioningTableData)
			{
				return;
			}
			
			var glyphTableData:GlyphTableData = _data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
			if (!glyphTableData)
			{
				return;
			}
			
			var lookupTables:Vector.<LookupTable> = glyphPositioningTableData.lookupListTable.lookupTables;
			const ll:uint = lookupTables.length;
			
			for (var j:uint = 0; j < ll; j++)
			{
				lookupTables[j].resolveDependencies(glyphPositioningTableData, this);
			}
		}
		
		private function resolveComponentDependencies():void 
		{
			var glyphTableData:GlyphTableData = _data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
			if (!glyphTableData)
			{
				return;
			}
			
			const l:uint = glyphTableData.glyphs.length;
			for (var i:uint = 0; i < l; i++)
			{
				glyphTableData.retrieveGlyph(i).resolveDependencies(glyphTableData);
			}
		}
		
		private function applyGlyphClassDefinitions():void 
		{
			var glyphTableData:GlyphTableData = _data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
			if (!glyphTableData)
			{
				return;
			}
			
			var glyphDefinitionData:GlyphDefinitionTableData = _data.retrieveTableData(TableNames.GLYPH_DEFINITION_DATA) as GlyphDefinitionTableData;
			if (!glyphDefinitionData)
			{
				return;
			}
			
			if (!glyphDefinitionData.glyphClassDefinitionTable)
			{
				return;
			}
			
			var glyphClassDefinitionTable:IClassDefinitionTable = glyphDefinitionData.glyphClassDefinitionTable;
			
			// This is the brute force approach: go through ALL glyphs and assign them a glyph class.
			// It would be more efficient if this operation was performed only for the glyphs actually stored in the class definition table.
			// However, the coverage is stored in the class definition table depending on the implementation, making a general approach difficult.
			const l:uint = glyphTableData.glyphs.length; 
			for (var i:uint = 0; i < l; i++)
			{
				var glyphClass:uint = glyphClassDefinitionTable.getGlyphClassByID(i);
				var glyph:Glyph = glyphTableData.retrieveGlyph(i);
				glyph.glyphClass = glyphClass;
			}
		}
		
		private function applyHorizontalMetrics():void
		{
			var horizontalMetrics:HorizontalMetricsData = _data.retrieveTableData(TableNames.HORIZONTAL_METRICS) as HorizontalMetricsData;
			
			var glyphTableData:GlyphTableData = _data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
			if (!glyphTableData)
			{
				return
			}
			
			var longHorizontalMetrics:Vector.<LongHorizontalMetric> = horizontalMetrics.longHorizontalMetrics;
			const l:uint = longHorizontalMetrics.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				var glyphIndex:uint = i;
				var glyph:Glyph = glyphTableData.retrieveGlyph(glyphIndex);
				
				var longHorizontalMetric:LongHorizontalMetric = longHorizontalMetrics[i];
				
				var advanceWidth:uint = longHorizontalMetric.advanceWidth;
				var leftSideBearing:int = longHorizontalMetric.leftSideBearing;
				
				glyph.advanceWidth = advanceWidth;
				glyph.leftSideBearing = leftSideBearing;
			}
			
			var leftSideBearings:Vector.<int> = horizontalMetrics.leftSideBearings;
			const ll:uint = leftSideBearings.length;
			
			for (i = 0; i < ll; i++)
			{
				glyphIndex = i + l;
				glyph = glyphTableData.retrieveGlyph(glyphIndex);
				
				leftSideBearing = leftSideBearings[i];
				
				glyph.advanceWidth = advanceWidth;
				glyph.leftSideBearing = leftSideBearing;
			}
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
		
		public function getAdvancedFeatures(standardScript:String, standardLanguage:String):Vector.<FeatureRecord> 
		{
			var gsubTableData:GlyphSubstitutionTableData = _data.retrieveTableData(TableNames.GLYPH_SUBSTITUTION_DATA) as GlyphSubstitutionTableData;
			var gposTableData:GlyphPositioningTableData = _data.retrieveTableData(TableNames.GLYPH_POSITIONING_DATA) as GlyphPositioningTableData;
			
			var result:Vector.<FeatureRecord> = new Vector.<FeatureRecord>();
			
			if (gsubTableData)
			{
				var features:Vector.<FeatureRecord> = gsubTableData.retrieveFeatures(standardScript, standardLanguage);
				if (features)
				{
					result = features.concat(result);
				}
			}
			
			if (gposTableData)
			{
				features = gposTableData.retrieveFeatures(standardScript, standardLanguage);
				if (features)
				{
					result = features.concat(result);
				}
			}
			
			return result;
		}
	}

}