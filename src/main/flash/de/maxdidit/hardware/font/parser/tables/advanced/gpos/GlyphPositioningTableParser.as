package de.maxdidit.hardware.font.parser.tables.advanced.gpos
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningLookupType;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.NotYetImplementedLookupTableParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.ScriptFeatureLookupTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.ClassDefinitionTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.FeatureListTableParser;
	import de.maxdidit.hardware.font.parser.tables.common.LookupListTableDataParser;
	import de.maxdidit.hardware.font.parser.tables.common.ScriptListTableParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.NotYetImplementedSubtableParser;
	import flash.utils.ByteArray;
	
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphPositioningTableParser extends ScriptFeatureLookupTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _valueFormatParser:ValueFormatParser;
		private var _valueRecordParser:ValueRecordParser;
		
		private var _anchorTableParser:AnchorTableParser;
		private var _markArrayTableParser:MarkArrayTableParser;
		
		private var _classDefinitionParser:ClassDefinitionTableParser;
			
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphPositioningTableParser($dataTypeParser:DataTypeParser)
		{
			super($dataTypeParser);
			
			_valueFormatParser = new ValueFormatParser();
			_valueRecordParser = new ValueRecordParser(_dataTypeParser);
			
			_anchorTableParser = new AnchorTableParser(_dataTypeParser);
			_markArrayTableParser = new MarkArrayTableParser(_dataTypeParser, _anchorTableParser);
			
			_classDefinitionParser = new ClassDefinitionTableParser(_dataTypeParser);
			
			initSubtableParser();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override protected function instantiateResult():ScriptFeatureLookupTable
		{
			return new GlyphPositioningTableData();
		}
		
		protected override function initSubtableParser():void 
		{
			var notYetImplementedParser:NotYetImplementedLookupTableParser = new NotYetImplementedLookupTableParser();
			
			_subtableParserMap = new Object();
			
			_subtableParserMap[String(GlyphPositioningLookupType.SINGLE_ADJUSTMENT)]			= new SingleAdjustmentPositioningSubtableParser(_dataTypeParser, _coverageTableParser, _valueFormatParser, _valueRecordParser);
			_subtableParserMap[String(GlyphPositioningLookupType.PAIR_ADJUSTMENT)]				= new PairAdjustmentPositioningSubtableParser(_dataTypeParser, _coverageTableParser, _classDefinitionParser, _valueFormatParser, _valueRecordParser);
			_subtableParserMap[String(GlyphPositioningLookupType.CURSIVE_ATTACHMENT)]			= new CursiveAttachmentPositioningSubtableParser(_dataTypeParser, _coverageTableParser, _anchorTableParser);
			_subtableParserMap[String(GlyphPositioningLookupType.MARK_TO_BASE_ATTACHMENT)]		= new MarkToBaseAttachmentPositioningSubtableParser(_dataTypeParser, _coverageTableParser, _anchorTableParser, _markArrayTableParser);
			_subtableParserMap[String(GlyphPositioningLookupType.MARK_TO_LIGATURE_ATTACHMENT)]	= new MarkToLigatureAttachmentPositioningSubtableParser(_dataTypeParser, _coverageTableParser, _anchorTableParser, _markArrayTableParser);
			_subtableParserMap[String(GlyphPositioningLookupType.MARK_TO_MARK_ATTACHMENT)]		= new MarkToMarkAttachmentPositioningSubtableParser(_dataTypeParser, _coverageTableParser, _anchorTableParser, _markArrayTableParser);
			_subtableParserMap[String(GlyphPositioningLookupType.CONTEXT_POSITIONING)]			= notYetImplementedParser;
			_subtableParserMap[String(GlyphPositioningLookupType.CHAINED_CONTEXT_POSITIONING)]	= notYetImplementedParser;
			_subtableParserMap[String(GlyphPositioningLookupType.EXTENSION_POSITIONING)]		= notYetImplementedParser;
		}
		
	}

}