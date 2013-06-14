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
 
package de.maxdidit.hardware.font.data.tables.common.script  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ScriptTag  
	{ 
		/////////////////////// 
		// Constants 
		/////////////////////// 
		 
		public static const ARABIC:String = "arab"; 
		public static const ARMENIAN:String = "armn"; 
		public static const AVESTAN:String = "avst"; 
		public static const BALINESE:String = "bali"; 
		public static const BAMUM:String = "bamu"; 
		public static const BATAK:String = "batk"; 
		public static const BENGALI:String = "beng"; 
		public static const BENGALI_V2:String = "bng2"; 
		public static const BOPOMOFO:String = "bopo"; 
		public static const BRAILLE:String = "brai"; 
		public static const BRAHMI:String = "brah"; 
		public static const BUGINESE:String = "bugi"; 
		public static const BUHID:String = "buhd"; 
		public static const BYZANTINE_MUSIC:String = "byzm"; 
		public static const CANADIAN_SYLLABICS:String = "cans"; 
		public static const CARIAN:String = "cari"; 
		public static const CHAKMA:String = "cakm"; 
		public static const CHAM:String = "cham"; 
		public static const CHEROKEE:String = "cher"; 
		public static const CJK_IDEOGRAPHIC:String = "hani"; 
		public static const COPTIC:String = "copt"; 
		public static const CYPRIOT_SYLLABARY:String = "cprt"; 
		public static const CYRILLIC:String = "cyrl"; 
		public static const DEFAULT:String = "DFLT"; 
		public static const DESERET:String = "dsrt"; 
		public static const DEVANAGARI:String = "deva"; 
		public static const DEVANAGARI_V2:String = "dev2"; 
		public static const EGYPTIAN_HEIROGLYPHS:String = "egyp"; 
		public static const ETHIOPIC:String = "ethi"; 
		public static const GEORGIAN:String = "geor"; 
		public static const GLAGOLITIC:String = "glag"; 
		public static const GOTHIC:String = "goth"; 
		public static const GREEK:String = "grek"; 
		public static const GUJARATI:String = "gujr"; 
		public static const GUJARATI_V2:String = "gjr2"; 
		public static const GURMUKHI:String = "guru"; 
		public static const GURMUKHI_V2:String = "gur2"; 
		public static const HANGUL:String = "hang"; 
		public static const HANGUL_JAMO:String = "jamo"; 
		public static const HANUNOO:String = "hano"; 
		public static const HEBREW:String = "hebr"; 
		public static const HIRAGANA:String = "kana"; 
		public static const IMPERIAL_ARAMAIC:String = "armi"; 
		public static const INSCRIPTIONAL_PAHLAVI:String = "phli"; 
		public static const INSCRIPTIONAL_PARTHIAN:String = "prti"; 
		public static const JAVANESE:String = "java"; 
		public static const KAITHI:String = "kthi"; 
		public static const KANNADA:String = "knda"; 
		public static const KANNADA_V2:String = "knd2"; 
		public static const KATAKANA:String = "kana"; 
		public static const KAYAH_LI:String = "kali"; 
		public static const KHAROSTHI:String = "khar"; 
		public static const KHMER:String = "khmr"; 
		public static const LAO:String = "lao "; 
		public static const LATIN:String = "latn"; 
		public static const LEPCHA:String = "lepc"; 
		public static const LIMBU:String = "limb"; 
		public static const LINEAR_B:String = "linb"; 
		public static const LISU_FRASER:String = "lisu"; 
		public static const LYCIAN:String = "lyci"; 
		public static const LYDIAN:String = "lydi"; 
		public static const MALAYALAM:String = "mlym"; 
		public static const MALAYALAM_V2:String = "mlm2"; 
		public static const MANDAIC_MANDAEAN:String = "mand"; 
		public static const MATHEMATICAL_ALPHANUMERIC_SYMBOLS:String = "math"; 
		public static const MEITEI_MAYEK_MEITHEI_MEETEI:String = "mtei"; 
		public static const MEROITIC_CURSIVE:String = "merc"; 
		public static const MEROITIC_HIEROGLYPHS:String = "mero"; 
		public static const MONGOLIAN:String = "mong"; 
		public static const MUSICAL_SYMBOLS:String = "musc"; 
		public static const MYANMAR:String = "mymr"; 
		public static const NEW_TAI_LUE:String = "talu"; 
		public static const NKO:String = "nko "; 
		public static const OGHAM:String = "ogam"; 
		public static const OL_CHIKI:String = "olck"; 
		public static const OLD_ITALIC:String = "ital"; 
		public static const OLD_PERSIAN_CUNEIFORM:String = "xpeo"; 
		public static const OLD_SOUTH_ARABIAN:String = "sarb"; 
		public static const OLD_TURKIC_ORKHON_RUNIC:String = "orkh"; 
		public static const ODIA_FORMERLY_ORIYA:String = "orya"; 
		public static const ODIA_V2_FORMERLY_ORIYA_V2:String = "ory2"; 
		public static const OSMANYA:String = "osma"; 
		public static const PHAGSPA:String = "phag"; 
		public static const PHOENICIAN:String = "phnx"; 
		public static const REJANG:String = "rjng"; 
		public static const RUNIC:String = "runr"; 
		public static const SAMARITAN:String = "samr"; 
		public static const SAURASHTRA:String = "saur"; 
		public static const SHARADA:String = "shrd"; 
		public static const SHAVIAN:String = "shaw"; 
		public static const SINHALA:String = "sinh"; 
		public static const SORA_SOMPENG:String = "sora"; 
		public static const SUMEROAKKADIAN_CUNEIFORM:String = "xsux"; 
		public static const SUNDANESE:String = "sund"; 
		public static const SYLOTI_NAGRI:String = "sylo"; 
		public static const SYRIAC:String = "syrc"; 
		public static const TAGALOG:String = "tglg"; 
		public static const TAGBANWA:String = "tagb"; 
		public static const TAI_LE:String = "tale"; 
		public static const TAI_THAM_LANNA:String = "lana"; 
		public static const TAI_VIET:String = "tavt"; 
		public static const TAKRI:String = "takr"; 
		public static const TAMIL:String = "taml"; 
		public static const TAMIL_V2:String = "tml2"; 
		public static const TELUGU:String = "telu"; 
		public static const TELUGU_V2:String = "tel2"; 
		public static const THAANA:String = "thaa"; 
		public static const THAI:String = "thai"; 
		public static const TIBETAN:String = "tibt"; 
		public static const TIFINAGH:String = "tfng"; 
		public static const UGARITIC_CUNEIFORM:String = "ugar"; 
		public static const VAI:String = "vai "; 
		public static const YI:String = "yi  "; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ScriptTag()  
		{ 
			throw new Error("This class should not be instantiated."); 
		} 
		 
	} 
} 
