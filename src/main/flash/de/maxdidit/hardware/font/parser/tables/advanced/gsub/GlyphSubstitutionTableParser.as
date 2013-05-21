package de.maxdidit.hardware.font.parser.tables.advanced.gsub 
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.GlyphSubstitutionLookupType;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
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
		
		protected override function initSubtableParser():void 
		{
			var notYetImplementedParser:NotYetImplementedSubtableParser = new NotYetImplementedSubtableParser();
			
			_subtableParserMap = new Object();
			
			_subtableParserMap[String(GlyphSubstitutionLookupType.SINGLE_SUBSTITUTION)]					= new SingleSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.MULTIPLE_SUBSTITUTION)]				= new MultipleSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.ALTERNATE_SUBSTITUTION)]				= new AlternateSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.LIGATURE_SUBSTITUTION)]				= new LigatureSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser);
			_subtableParserMap[String(GlyphSubstitutionLookupType.CONTEXTUAL_SUBSTITUTION)]				= notYetImplementedParser;
			_subtableParserMap[String(GlyphSubstitutionLookupType.CHAINING_CONTEXTUAL_SUBSTITUTION)]	= notYetImplementedParser;
			_subtableParserMap[String(GlyphSubstitutionLookupType.EXTENSION_SUBSTITUTION)]				= notYetImplementedParser;
		}
		
	}

}