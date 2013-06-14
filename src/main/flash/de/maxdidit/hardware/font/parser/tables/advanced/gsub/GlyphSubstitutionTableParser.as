/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
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
			_subtableParserMap[String(GlyphSubstitutionLookupType.CHAINING_CONTEXTUAL_SUBSTITUTION)]	= new ChainingContextualSubstitutionSubtableParser(_dataTypeParser, _coverageTableParser); 
			_subtableParserMap[String(GlyphSubstitutionLookupType.EXTENSION_SUBSTITUTION)]				= new ExtensionSubtableParser(_dataTypeParser, this); 
		} 
		 
	} 
} 
