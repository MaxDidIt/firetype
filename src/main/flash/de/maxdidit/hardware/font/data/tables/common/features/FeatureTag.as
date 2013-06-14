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
 
package de.maxdidit.hardware.font.data.tables.common.features 
{ 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class FeatureTag 
	{ 
		/////////////////////// 
		// Constants 
		/////////////////////// 
		 
		public static const ACCESS_ALL_ALTERNATES:FeatureTag = new FeatureTag("aalt", "Access All Alternates"); 
		public static const ABOVE_BASE_FORMS:FeatureTag = new FeatureTag("abvf", "Above-base Forms"); 
		public static const ABOVE_BASE_MARK_POSITIONING:FeatureTag = new FeatureTag("abvm", "Above-base Mark Positioning"); 
		public static const ABOVE_BASE_SUBSTITUTIONS:FeatureTag = new FeatureTag("abvs", "Above-base Substitutions"); 
		public static const ALTERNATIVE_FRACTIONS:FeatureTag = new FeatureTag("afrc", "Alternative Fractions"); 
		public static const AKHANDS:FeatureTag = new FeatureTag("akhn", "Akhands"); 
		public static const BELOW_BASE_FORMS:FeatureTag = new FeatureTag("blwf", "Below-base Forms"); 
		public static const BELOW_BASE_MARK_POSITIONING:FeatureTag = new FeatureTag("blwm", "Below-base Mark Positioning"); 
		public static const BELOW_BASE_SUBSTITUTIONS:FeatureTag = new FeatureTag("blws", "Below-base Substitutions"); 
		public static const CONTEXTUAL_ALTERNATES:FeatureTag = new FeatureTag("calt", "Contextual Alternates"); 
		public static const CASE_SENSITIVE_FORMS:FeatureTag = new FeatureTag("case", "Case-Sensitive Forms"); 
		public static const GLYPH_COMPOSITION_DECOMPOSITION:FeatureTag = new FeatureTag("ccmp", "Glyph Composition / Decomposition"); 
		public static const CONJUNCT_FORM_AFTER_RO:FeatureTag = new FeatureTag("cfar", "Conjunct Form After Ro"); 
		public static const CONJUNCT_FORMS:FeatureTag = new FeatureTag("cjct", "Conjunct Forms"); 
		public static const CONTEXTUAL_LIGATURES:FeatureTag = new FeatureTag("clig", "Contextual Ligatures"); 
		public static const CENTERED_CJK_PUNCTUATION:FeatureTag = new FeatureTag("cpct", "Centered CJK Punctuation"); 
		public static const CAPITAL_SPACING:FeatureTag = new FeatureTag("cpsp", "Capital Spacing"); 
		public static const CONTEXTUAL_SWASH:FeatureTag = new FeatureTag("cswh", "Contextual Swash"); 
		public static const CURSIVE_POSITIONING:FeatureTag = new FeatureTag("curs", "Cursive Positioning"); 
		public static const PETITE_CAPITALS_FROM_CAPITALS:FeatureTag = new FeatureTag("c2pc", "Petite Capitals From Capitals"); 
		public static const SMALL_CAPITALS_FROM_CAPITALS:FeatureTag = new FeatureTag("c2sc", "Small Capitals From Capitals"); 
		public static const DISTANCES:FeatureTag = new FeatureTag("dist", "Distances"); 
		public static const DISCRETIONARY_LIGATURES:FeatureTag = new FeatureTag("dlig", "Discretionary Ligatures"); 
		public static const DENOMINATORS:FeatureTag = new FeatureTag("dnom", "Denominators"); 
		public static const EXPERT_FORMS:FeatureTag = new FeatureTag("expt", "Expert Forms"); 
		public static const FINAL_GLYPH_ON_LINE_ALTERNATES:FeatureTag = new FeatureTag("falt", "Final Glyph on Line Alternates"); 
		public static const TERMINAL_FORMS_2:FeatureTag = new FeatureTag("fin2", "Terminal Forms #2"); 
		public static const TERMINAL_FORMS_3:FeatureTag = new FeatureTag("fin3", "Terminal Forms #3"); 
		public static const TERMINAL_FORMS:FeatureTag = new FeatureTag("fina", "Terminal Forms"); 
		public static const FRACTIONS:FeatureTag = new FeatureTag("frac", "Fractions"); 
		public static const FULL_WIDTHS:FeatureTag = new FeatureTag("fwid", "Full Widths"); 
		public static const HALF_FORMS:FeatureTag = new FeatureTag("half", "Half Forms"); 
		public static const HALANT_FORMS:FeatureTag = new FeatureTag("haln", "Halant Forms"); 
		public static const ALTERNATE_HALF_WIDTHS:FeatureTag = new FeatureTag("halt", "Alternate Half Widths"); 
		public static const HISTORICAL_FORMS:FeatureTag = new FeatureTag("hist", "Historical Forms"); 
		public static const HORIZONTAL_KANA_ALTERNATES:FeatureTag = new FeatureTag("hkna", "Horizontal Kana Alternates"); 
		public static const HISTORICAL_LIGATURES:FeatureTag = new FeatureTag("hlig", "Historical Ligatures"); 
		public static const HANGUL:FeatureTag = new FeatureTag("hngl", "Hangul"); 
		public static const HOJO_KANJI_FORMS_JIS_X_0212_1990_KANJI_FORMS:FeatureTag = new FeatureTag("hojo", "Hojo Kanji Forms (JIS X 0212-1990 Kanji Forms)"); 
		public static const HALF_WIDTHS:FeatureTag = new FeatureTag("hwid", "Half Widths"); 
		public static const INITIAL_FORMS:FeatureTag = new FeatureTag("init", "Initial Forms"); 
		public static const ISOLATED_FORMS:FeatureTag = new FeatureTag("isol", "Isolated Forms"); 
		public static const ITALICS:FeatureTag = new FeatureTag("ital", "Italics"); 
		public static const JUSTIFICATION_ALTERNATES:FeatureTag = new FeatureTag("jalt", "Justification Alternates"); 
		public static const JIS78_FORMS:FeatureTag = new FeatureTag("jp78", "JIS78 Forms"); 
		public static const JIS83_FORMS:FeatureTag = new FeatureTag("jp83", "JIS83 Forms"); 
		public static const JIS90_FORMS:FeatureTag = new FeatureTag("jp90", "JIS90 Forms"); 
		public static const JIS2004_FORMS:FeatureTag = new FeatureTag("jp04", "JIS2004 Forms"); 
		public static const KERNING:FeatureTag = new FeatureTag("kern", "Kerning"); 
		public static const LEFT_BOUNDS:FeatureTag = new FeatureTag("lfbd", "Left Bounds"); 
		public static const STANDARD_LIGATURES:FeatureTag = new FeatureTag("liga", "Standard Ligatures"); 
		public static const LEADING_JAMO_FORMS:FeatureTag = new FeatureTag("ljmo", "Leading Jamo Forms"); 
		public static const LINING_FIGURES:FeatureTag = new FeatureTag("lnum", "Lining Figures"); 
		public static const LOCALIZED_FORMS:FeatureTag = new FeatureTag("locl", "Localized Forms"); 
		public static const LEFT_TO_RIGHT_ALTERNATES:FeatureTag = new FeatureTag("ltra", "Left-to-right alternates"); 
		public static const LEFT_TO_RIGHT_MIRRORED_FORMS:FeatureTag = new FeatureTag("ltrm", "Left-to-right mirrored forms"); 
		public static const MARK_POSITIONING:FeatureTag = new FeatureTag("mark", "Mark Positioning"); 
		public static const MEDIAL_FORMS_2:FeatureTag = new FeatureTag("med2", "Medial Forms #2"); 
		public static const MEDIAL_FORMS:FeatureTag = new FeatureTag("medi", "Medial Forms"); 
		public static const MATHEMATICAL_GREEK:FeatureTag = new FeatureTag("mgrk", "Mathematical Greek"); 
		public static const MARK_TO_MARK_POSITIONING:FeatureTag = new FeatureTag("mkmk", "Mark to Mark Positioning"); 
		public static const MARK_POSITIONING_VIA_SUBSTITUTION:FeatureTag = new FeatureTag("mset", "Mark Positioning via Substitution"); 
		public static const ALTERNATE_ANNOTATION_FORMS:FeatureTag = new FeatureTag("nalt", "Alternate Annotation Forms"); 
		public static const NLC_KANJI_FORMS:FeatureTag = new FeatureTag("nlck", "NLC Kanji Forms"); 
		public static const NUKTA_FORMS:FeatureTag = new FeatureTag("nukt", "Nukta Forms"); 
		public static const NUMERATORS:FeatureTag = new FeatureTag("numr", "Numerators"); 
		public static const OLDSTYLE_FIGURES:FeatureTag = new FeatureTag("onum", "Oldstyle Figures"); 
		public static const OPTICAL_BOUNDS:FeatureTag = new FeatureTag("opbd", "Optical Bounds"); 
		public static const ORDINALS:FeatureTag = new FeatureTag("ordn", "Ordinals"); 
		public static const ORNAMENTS:FeatureTag = new FeatureTag("ornm", "Ornaments"); 
		public static const PROPORTIONAL_ALTERNATE_WIDTHS:FeatureTag = new FeatureTag("palt", "Proportional Alternate Widths"); 
		public static const PETITE_CAPITALS:FeatureTag = new FeatureTag("pcap", "Petite Capitals"); 
		public static const PROPORTIONAL_KANA:FeatureTag = new FeatureTag("pkna", "Proportional Kana"); 
		public static const PROPORTIONAL_FIGURES:FeatureTag = new FeatureTag("pnum", "Proportional Figures"); 
		public static const PRE_BASE_FORMS:FeatureTag = new FeatureTag("pref", "Pre-Base Forms"); 
		public static const PRE_BASE_SUBSTITUTIONS:FeatureTag = new FeatureTag("pres", "Pre-base Substitutions"); 
		public static const POST_BASE_FORMS:FeatureTag = new FeatureTag("pstf", "Post-base Forms"); 
		public static const POST_BASE_SUBSTITUTIONS:FeatureTag = new FeatureTag("psts", "Post-base Substitutions"); 
		public static const PROPORTIONAL_WIDTHS:FeatureTag = new FeatureTag("pwid", "Proportional Widths"); 
		public static const QUARTER_WIDTHS:FeatureTag = new FeatureTag("qwid", "Quarter Widths"); 
		public static const RANDOMIZE:FeatureTag = new FeatureTag("rand", "Randomize"); 
		public static const RAKAR_FORMS:FeatureTag = new FeatureTag("rkrf", "Rakar Forms"); 
		public static const REQUIRED_LIGATURES:FeatureTag = new FeatureTag("rlig", "Required Ligatures"); 
		public static const REPH_FORMS:FeatureTag = new FeatureTag("rphf", "Reph Forms"); 
		public static const RIGHT_BOUNDS:FeatureTag = new FeatureTag("rtbd", "Right Bounds"); 
		public static const RIGHT_TO_LEFT_ALTERNATES:FeatureTag = new FeatureTag("rtla", "Right-to-left alternates"); 
		public static const RIGHT_TO_LEFT_MIRRORED_FORMS:FeatureTag = new FeatureTag("rtlm", "Right-to-left mirrored forms"); 
		public static const RUBY_NOTATION_FORMS:FeatureTag = new FeatureTag("ruby", "Ruby Notation Forms"); 
		public static const STYLISTIC_ALTERNATES:FeatureTag = new FeatureTag("salt", "Stylistic Alternates"); 
		public static const SCIENTIFIC_INFERIORS:FeatureTag = new FeatureTag("sinf", "Scientific Inferiors"); 
		public static const OPTICAL_SIZE:FeatureTag = new FeatureTag("size", "Optical size"); 
		public static const SMALL_CAPITALS:FeatureTag = new FeatureTag("smcp", "Small Capitals"); 
		public static const SIMPLIFIED_FORMS:FeatureTag = new FeatureTag("smpl", "Simplified Forms"); 
		public static const STYLISTIC_SET_1:FeatureTag = new FeatureTag("ss01", "Stylistic Set 1"); 
		public static const STYLISTIC_SET_2:FeatureTag = new FeatureTag("ss02", "Stylistic Set 2"); 
		public static const STYLISTIC_SET_3:FeatureTag = new FeatureTag("ss03", "Stylistic Set 3"); 
		public static const STYLISTIC_SET_4:FeatureTag = new FeatureTag("ss04", "Stylistic Set 4"); 
		public static const STYLISTIC_SET_5:FeatureTag = new FeatureTag("ss05", "Stylistic Set 5"); 
		public static const STYLISTIC_SET_6:FeatureTag = new FeatureTag("ss06", "Stylistic Set 6"); 
		public static const STYLISTIC_SET_7:FeatureTag = new FeatureTag("ss07", "Stylistic Set 7"); 
		public static const STYLISTIC_SET_8:FeatureTag = new FeatureTag("ss08", "Stylistic Set 8"); 
		public static const STYLISTIC_SET_9:FeatureTag = new FeatureTag("ss09", "Stylistic Set 9"); 
		public static const STYLISTIC_SET_10:FeatureTag = new FeatureTag("ss10", "Stylistic Set 10"); 
		public static const STYLISTIC_SET_11:FeatureTag = new FeatureTag("ss11", "Stylistic Set 11"); 
		public static const STYLISTIC_SET_12:FeatureTag = new FeatureTag("ss12", "Stylistic Set 12"); 
		public static const STYLISTIC_SET_13:FeatureTag = new FeatureTag("ss13", "Stylistic Set 13"); 
		public static const STYLISTIC_SET_14:FeatureTag = new FeatureTag("ss14", "Stylistic Set 14"); 
		public static const STYLISTIC_SET_15:FeatureTag = new FeatureTag("ss15", "Stylistic Set 15"); 
		public static const STYLISTIC_SET_16:FeatureTag = new FeatureTag("ss16", "Stylistic Set 16"); 
		public static const STYLISTIC_SET_17:FeatureTag = new FeatureTag("ss17", "Stylistic Set 17"); 
		public static const STYLISTIC_SET_18:FeatureTag = new FeatureTag("ss18", "Stylistic Set 18"); 
		public static const STYLISTIC_SET_19:FeatureTag = new FeatureTag("ss19", "Stylistic Set 19"); 
		public static const STYLISTIC_SET_20:FeatureTag = new FeatureTag("ss20", "Stylistic Set 20"); 
		public static const SUBSCRIPT:FeatureTag = new FeatureTag("subs", "Subscript"); 
		public static const SUPERSCRIPT:FeatureTag = new FeatureTag("sups", "Superscript"); 
		public static const SWASH:FeatureTag = new FeatureTag("swsh", "Swash"); 
		public static const TITLING:FeatureTag = new FeatureTag("titl", "Titling"); 
		public static const TRAILING_JAMO_FORMS:FeatureTag = new FeatureTag("tjmo", "Trailing Jamo Forms"); 
		public static const TRADITIONAL_NAME_FORMS:FeatureTag = new FeatureTag("tnam", "Traditional Name Forms"); 
		public static const TABULAR_FIGURES:FeatureTag = new FeatureTag("tnum", "Tabular Figures"); 
		public static const TRADITIONAL_FORMS:FeatureTag = new FeatureTag("trad", "Traditional Forms"); 
		public static const THIRD_WIDTHS:FeatureTag = new FeatureTag("twid", "Third Widths"); 
		public static const UNICASE:FeatureTag = new FeatureTag("unic", "Unicase"); 
		public static const ALTERNATE_VERTICAL_METRICS:FeatureTag = new FeatureTag("valt", "Alternate Vertical Metrics"); 
		public static const VATTU_VARIANTS:FeatureTag = new FeatureTag("vatu", "Vattu Variants"); 
		public static const VERTICAL_WRITING:FeatureTag = new FeatureTag("vert", "Vertical Writing"); 
		public static const ALTERNATE_VERTICAL_HALF_METRICS:FeatureTag = new FeatureTag("vhal", "Alternate Vertical Half Metrics"); 
		public static const VOWEL_JAMO_FORMS:FeatureTag = new FeatureTag("vjmo", "Vowel Jamo Forms"); 
		public static const VERTICAL_KANA_ALTERNATES:FeatureTag = new FeatureTag("vkna", "Vertical Kana Alternates"); 
		public static const VERTICAL_KERNING:FeatureTag = new FeatureTag("vkrn", "Vertical Kerning"); 
		public static const PROPORTIONAL_ALTERNATE_VERTICAL_METRICS:FeatureTag = new FeatureTag("vpal", "Proportional Alternate Vertical Metrics"); 
		public static const VERTICAL_ALTERNATES_AND_ROTATION:FeatureTag = new FeatureTag("vrt2", "Vertical Alternates and Rotation"); 
		public static const SLASHED_ZERO:FeatureTag = new FeatureTag("zero", "Slashed Zero"); 
		 
		/////////////////////// 
		// Static Functions 
		/////////////////////// 
		 
		public static function getFeatureTag(tag:String):FeatureTag 
		{ 
			switch (tag) 
			{ 
				case "aalt":  
					return ACCESS_ALL_ALTERNATES; 
					break; 
				 
				case "abvf":  
					return ABOVE_BASE_FORMS; 
					break; 
				 
				case "abvm":  
					return ABOVE_BASE_MARK_POSITIONING; 
					break; 
				 
				case "abvs":  
					return ABOVE_BASE_SUBSTITUTIONS; 
					break; 
				 
				case "afrc":  
					return ALTERNATIVE_FRACTIONS; 
					break; 
				 
				case "akhn":  
					return AKHANDS; 
					break; 
				 
				case "blwf":  
					return BELOW_BASE_FORMS; 
					break; 
				 
				case "blwm":  
					return BELOW_BASE_MARK_POSITIONING; 
					break; 
				 
				case "blws":  
					return BELOW_BASE_SUBSTITUTIONS; 
					break; 
				 
				case "calt":  
					return CONTEXTUAL_ALTERNATES; 
					break; 
				 
				case "case":  
					return CASE_SENSITIVE_FORMS; 
					break; 
				 
				case "ccmp":  
					return GLYPH_COMPOSITION_DECOMPOSITION; 
					break; 
				 
				case "cfar":  
					return CONJUNCT_FORM_AFTER_RO; 
					break; 
				 
				case "cjct":  
					return CONJUNCT_FORMS; 
					break; 
				 
				case "clig":  
					return CONTEXTUAL_LIGATURES; 
					break; 
				 
				case "cpct":  
					return CENTERED_CJK_PUNCTUATION; 
					break; 
				 
				case "cpsp":  
					return CAPITAL_SPACING; 
					break; 
				 
				case "cswh":  
					return CONTEXTUAL_SWASH; 
					break; 
				 
				case "curs":  
					return CURSIVE_POSITIONING; 
					break; 
				 
				case "c2pc":  
					return PETITE_CAPITALS_FROM_CAPITALS; 
					break; 
				 
				case "c2sc":  
					return SMALL_CAPITALS_FROM_CAPITALS; 
					break; 
				 
				case "dist":  
					return DISTANCES; 
					break; 
				 
				case "dlig":  
					return DISCRETIONARY_LIGATURES; 
					break; 
				 
				case "dnom":  
					return DENOMINATORS; 
					break; 
				 
				case "expt":  
					return EXPERT_FORMS; 
					break; 
				 
				case "falt":  
					return FINAL_GLYPH_ON_LINE_ALTERNATES; 
					break; 
				 
				case "fin2":  
					return TERMINAL_FORMS_2; 
					break; 
				 
				case "fin3":  
					return TERMINAL_FORMS_3; 
					break; 
				 
				case "fina":  
					return TERMINAL_FORMS; 
					break; 
				 
				case "frac":  
					return FRACTIONS; 
					break; 
				 
				case "fwid":  
					return FULL_WIDTHS; 
					break; 
				 
				case "half":  
					return HALF_FORMS; 
					break; 
				 
				case "haln":  
					return HALANT_FORMS; 
					break; 
				 
				case "halt":  
					return ALTERNATE_HALF_WIDTHS; 
					break; 
				 
				case "hist":  
					return HISTORICAL_FORMS; 
					break; 
				 
				case "hkna":  
					return HORIZONTAL_KANA_ALTERNATES; 
					break; 
				 
				case "hlig":  
					return HISTORICAL_LIGATURES; 
					break; 
				 
				case "hngl":  
					return HANGUL; 
					break; 
				 
				case "hojo":  
					return HOJO_KANJI_FORMS_JIS_X_0212_1990_KANJI_FORMS; 
					break; 
				 
				case "hwid":  
					return HALF_WIDTHS; 
					break; 
				 
				case "init":  
					return INITIAL_FORMS; 
					break; 
				 
				case "isol":  
					return ISOLATED_FORMS; 
					break; 
				 
				case "ital":  
					return ITALICS; 
					break; 
				 
				case "jalt":  
					return JUSTIFICATION_ALTERNATES; 
					break; 
				 
				case "jp78":  
					return JIS78_FORMS; 
					break; 
				 
				case "jp83":  
					return JIS83_FORMS; 
					break; 
				 
				case "jp90":  
					return JIS90_FORMS; 
					break; 
				 
				case "jp04":  
					return JIS2004_FORMS; 
					break; 
				 
				case "kern":  
					return KERNING; 
					break; 
				 
				case "lfbd":  
					return LEFT_BOUNDS; 
					break; 
				 
				case "liga":  
					return STANDARD_LIGATURES; 
					break; 
				 
				case "ljmo":  
					return LEADING_JAMO_FORMS; 
					break; 
				 
				case "lnum":  
					return LINING_FIGURES; 
					break; 
				 
				case "locl":  
					return LOCALIZED_FORMS; 
					break; 
				 
				case "ltra":  
					return LEFT_TO_RIGHT_ALTERNATES; 
					break; 
				 
				case "ltrm":  
					return LEFT_TO_RIGHT_MIRRORED_FORMS; 
					break; 
				 
				case "mark":  
					return MARK_POSITIONING; 
					break; 
				 
				case "med2":  
					return MEDIAL_FORMS_2; 
					break; 
				 
				case "medi":  
					return MEDIAL_FORMS; 
					break; 
				 
				case "mgrk":  
					return MATHEMATICAL_GREEK; 
					break; 
				 
				case "mkmk":  
					return MARK_TO_MARK_POSITIONING; 
					break; 
				 
				case "mset":  
					return MARK_POSITIONING_VIA_SUBSTITUTION; 
					break; 
				 
				case "nalt":  
					return ALTERNATE_ANNOTATION_FORMS; 
					break; 
				 
				case "nlck":  
					return NLC_KANJI_FORMS; 
					break; 
				 
				case "nukt":  
					return NUKTA_FORMS; 
					break; 
				 
				case "numr":  
					return NUMERATORS; 
					break; 
				 
				case "onum":  
					return OLDSTYLE_FIGURES; 
					break; 
				 
				case "opbd":  
					return OPTICAL_BOUNDS; 
					break; 
				 
				case "ordn":  
					return ORDINALS; 
					break; 
				 
				case "ornm":  
					return ORNAMENTS; 
					break; 
				 
				case "palt":  
					return PROPORTIONAL_ALTERNATE_WIDTHS; 
					break; 
				 
				case "pcap":  
					return PETITE_CAPITALS; 
					break; 
				 
				case "pkna":  
					return PROPORTIONAL_KANA; 
					break; 
				 
				case "pnum":  
					return PROPORTIONAL_FIGURES; 
					break; 
				 
				case "pref":  
					return PRE_BASE_FORMS; 
					break; 
				 
				case "pres":  
					return PRE_BASE_SUBSTITUTIONS; 
					break; 
				 
				case "pstf":  
					return POST_BASE_FORMS; 
					break; 
				 
				case "psts":  
					return POST_BASE_SUBSTITUTIONS; 
					break; 
				 
				case "pwid":  
					return PROPORTIONAL_WIDTHS; 
					break; 
				 
				case "qwid":  
					return QUARTER_WIDTHS; 
					break; 
				 
				case "rand":  
					return RANDOMIZE; 
					break; 
				 
				case "rkrf":  
					return RAKAR_FORMS; 
					break; 
				 
				case "rlig":  
					return REQUIRED_LIGATURES; 
					break; 
				 
				case "rphf":  
					return REPH_FORMS; 
					break; 
				 
				case "rtbd":  
					return RIGHT_BOUNDS; 
					break; 
				 
				case "rtla":  
					return RIGHT_TO_LEFT_ALTERNATES; 
					break; 
				 
				case "rtlm":  
					return RIGHT_TO_LEFT_MIRRORED_FORMS; 
					break; 
				 
				case "ruby":  
					return RUBY_NOTATION_FORMS; 
					break; 
				 
				case "salt":  
					return STYLISTIC_ALTERNATES; 
					break; 
				 
				case "sinf":  
					return SCIENTIFIC_INFERIORS; 
					break; 
				 
				case "size":  
					return OPTICAL_SIZE; 
					break; 
				 
				case "smcp":  
					return SMALL_CAPITALS; 
					break; 
				 
				case "smpl":  
					return SIMPLIFIED_FORMS; 
					break; 
				 
				case "ss01":  
					return STYLISTIC_SET_1; 
					break; 
				 
				case "ss02":  
					return STYLISTIC_SET_2; 
					break; 
				 
				case "ss03":  
					return STYLISTIC_SET_3; 
					break; 
				 
				case "ss04":  
					return STYLISTIC_SET_4; 
					break; 
				 
				case "ss05":  
					return STYLISTIC_SET_5; 
					break; 
				 
				case "ss06":  
					return STYLISTIC_SET_6; 
					break; 
				 
				case "ss07":  
					return STYLISTIC_SET_7; 
					break; 
				 
				case "ss08":  
					return STYLISTIC_SET_8; 
					break; 
				 
				case "ss09":  
					return STYLISTIC_SET_9; 
					break; 
				 
				case "ss10":  
					return STYLISTIC_SET_10; 
					break; 
				 
				case "ss11":  
					return STYLISTIC_SET_11; 
					break; 
				 
				case "ss12":  
					return STYLISTIC_SET_12; 
					break; 
				 
				case "ss13":  
					return STYLISTIC_SET_13; 
					break; 
				 
				case "ss14":  
					return STYLISTIC_SET_14; 
					break; 
				 
				case "ss15":  
					return STYLISTIC_SET_15; 
					break; 
				 
				case "ss16":  
					return STYLISTIC_SET_16; 
					break; 
				 
				case "ss17":  
					return STYLISTIC_SET_17; 
					break; 
				 
				case "ss18":  
					return STYLISTIC_SET_18; 
					break; 
				 
				case "ss19":  
					return STYLISTIC_SET_19; 
					break; 
				 
				case "ss20":  
					return STYLISTIC_SET_20; 
					break; 
				 
				case "subs":  
					return SUBSCRIPT; 
					break; 
				 
				case "sups":  
					return SUPERSCRIPT; 
					break; 
				 
				case "swsh":  
					return SWASH; 
					break; 
				 
				case "titl":  
					return TITLING; 
					break; 
				 
				case "tjmo":  
					return TRAILING_JAMO_FORMS; 
					break; 
				 
				case "tnam":  
					return TRADITIONAL_NAME_FORMS; 
					break; 
				 
				case "tnum":  
					return TABULAR_FIGURES; 
					break; 
				 
				case "trad":  
					return TRADITIONAL_FORMS; 
					break; 
				 
				case "twid":  
					return THIRD_WIDTHS; 
					break; 
				 
				case "unic":  
					return UNICASE; 
					break; 
				 
				case "valt":  
					return ALTERNATE_VERTICAL_METRICS; 
					break; 
				 
				case "vatu":  
					return VATTU_VARIANTS; 
					break; 
				 
				case "vert":  
					return VERTICAL_WRITING; 
					break; 
				 
				case "vhal":  
					return ALTERNATE_VERTICAL_HALF_METRICS; 
					break; 
				 
				case "vjmo":  
					return VOWEL_JAMO_FORMS; 
					break; 
				 
				case "vkna":  
					return VERTICAL_KANA_ALTERNATES; 
					break; 
				 
				case "vkrn":  
					return VERTICAL_KERNING; 
					break; 
				 
				case "vpal":  
					return PROPORTIONAL_ALTERNATE_VERTICAL_METRICS; 
					break; 
				 
				case "vrt2":  
					return VERTICAL_ALTERNATES_AND_ROTATION; 
					break; 
				 
				case "zero":  
					return SLASHED_ZERO; 
					break; 
			 
			} 
			 
			return null; 
		} 
		 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _tag:String; 
		private var _description:String; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function FeatureTag($featureTag:String, $featureDescription:String) 
		{ 
			this._description = $featureDescription; 
			this._tag = $featureTag; 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get tag():String  
		{ 
			return _tag; 
		} 
		 
		public function get description():String  
		{ 
			return _description; 
		} 
	 
	} 
} 
