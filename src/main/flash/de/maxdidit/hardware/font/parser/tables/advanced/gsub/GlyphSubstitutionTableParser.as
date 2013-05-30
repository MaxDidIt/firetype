package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.GlyphSubstitutionLookupType;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.GlyphSubstitutionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.ExtensionSubtableParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.NotYetImplementedLookupTableParser;
	import de.maxdidit.hardware.font.parser.tables.advanced.ScriptFeatureLookupTableParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.NotYetImplementedSubtableParser;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphSubstitutionTableParser extends ScriptFeatureLookupTableParser
	{
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphSubstitutionTableParser($dataTypeParser:DataTypeParser) 
		{
			super($dataTypeParser);
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override protected function instantiateResult():ScriptFeatureLookupTable 
		{
			return new GlyphSubstitutionTableData();
		}
		
		protected override function initSubtableParser():void 
		{
			var notYetImplementedParser:NotYetImplementedLookupTableParser = new NotYetImplementedLookupTableParser();
			
			_subtableParserMap = new Object();
			
			_subtableParserMap[String(GlyphSubstitutionLookupType.SINGLE_SUBSTITUTION)]					= new SingleSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.MULTIPLE_SUBSTITUTION)]				= new MultipleSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.ALTERNATE_SUBSTITUTION)]				= new AlternateSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.LIGATURE_SUBSTITUTION)]				= new LigatureSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.CONTEXTUAL_SUBSTITUTION)]				= new ContextualSubstitutionTableSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.CHAINING_CONTEXTUAL_SUBSTITUTION)]	= new ChaningContextualSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.EXTENSION_SUBSTITUTION)]				= new ExtensionSubtableParser(_dataTypeParser, this);
		}
		
	}

}