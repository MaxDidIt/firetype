package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.GlyphSubstitutionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable;
	import de.maxdidit.hardware.font.data.tables.other.kern.KerningTableData;
	import de.maxdidit.hardware.font.data.tables.required.cmap.CharacterIndexMappingTableData;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.HorizontalMetricsData;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.GlyphTableData;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.components.HardwareLine;
	import de.maxdidit.hardware.text.components.HardwareWord;
	import de.maxdidit.hardware.text.components.TextSpan;
	import de.maxdidit.hardware.text.format.HardwareFontFeatures;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.format.HardwareTextFormatListElement;
	import de.maxdidit.hardware.text.tags.FormatTag;
	import de.maxdidit.hardware.text.tags.TextTag;
	import de.maxdidit.list.LinkedList;
	import flash.text.engine.BreakOpportunity;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Typesetter
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const CHAR_CODE_SPACE:uint = Keyboard.SPACE;
		public static const CHAR_CODE_NEWLINE:uint = "\n".charCodeAt(0);
		public static const CHAR_CODE_OPEN_ANGLE_BRACKET:uint = "<".charCodeAt(0);
		public static const CHAR_CODE_CLOSED_ANGLE_BRACKET:uint = ">".charCodeAt(0);
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Typesetter()
		{
		
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function applyCharacterSubstitutions(textSpans:Vector.<TextSpan>):void
		{
			var lookupIndices:Vector.<int> = new Vector.<int>();
			
			const l:uint = textSpans.length;
			for (var i:uint = 0; i < l; i++)
			{
				// set up
				var textSpan:TextSpan = textSpans[i];
				
				var textFormat:HardwareTextFormat = textSpan.textFormat;
				var font:HardwareFont = textFormat.font;
				
				var gsubData:GlyphSubstitutionTableData = font.data.retrieveTableData(TableNames.GLYPH_SUBSTITUTION_DATA) as GlyphSubstitutionTableData;
				if (!gsubData)
				{
					continue;
				}
				
				retrieveLookupIndices(gsubData, lookupIndices, textFormat);
				var ll:uint = lookupIndices.length;
				if (ll == 0)
				{
					continue
				}
				
				var characterInstances:LinkedList = textSpan.characterInstances;
				characterInstances.gotoFirstElement();
				
				while (characterInstances.currentElement)
				{
					var currentCharacter:de.maxdidit.hardware.text.components.HardwareCharacterInstance = characterInstances.currentElement as de.maxdidit.hardware.text.components.HardwareCharacterInstance;
					for (var j:uint = 0; j < ll; j++)
					{
						currentCharacter.glyph.applyGlyphLookup(TableNames.GLYPH_SUBSTITUTION_DATA, characterInstances, lookupIndices[j]);
					}
					characterInstances.gotoNextElement();
				}
			}
		}
		
		private function retrieveLookupIndices(scriptFeatureLookup:ScriptFeatureLookupTable, lookupIndices:Vector.<int>, textFormat:HardwareTextFormat):void
		{
			lookupIndices.length = 0;
			if (!scriptFeatureLookup)
			{
				return;
			}
			
			var scriptTable:ScriptTable = scriptFeatureLookup.scriptListTable.retrieveScriptTable(textFormat.scriptTag);
			if (!scriptTable)
			{
				return;
			}
			var languageSystemTable:LanguageSystemTable = scriptTable.retrieveLanguageSystemTable(textFormat.languageTag);
			
			var featureIndices:Vector.<uint> = languageSystemTable.featureIndices;
			
			const l:uint = featureIndices.length;
			for (var i:uint = 0; i < l; i++)
			{
				var feature:FeatureRecord = scriptFeatureLookup.featureListTable.featureRecords[featureIndices[i]];
				if (!textFormat.features.hasFeatureTag(feature.featureTag.tag))
				{
					continue;
				}
				
				var featureLookupIndices:Vector.<uint> = feature.featureTable.lookupListIndices;
				var fl:uint = featureLookupIndices.length;
				
				for (var f:uint = 0; f < fl; f++)
				{
					lookupIndices.push(featureLookupIndices[f]);
				}
			}
		}
		
		public function createTextSpans(text:String, standardTextFormat:HardwareTextFormat, cache:HardwareCharacterCache):Vector.<TextSpan>
		{
			var fontStack:LinkedList = new LinkedList();
			fontStack.addElement(new HardwareTextFormatListElement(standardTextFormat));
			if (!cache.textColorMap.hasTextColorId(standardTextFormat.textColor.id))
			{
				cache.textColorMap.addTextColor(standardTextFormat.textColor);
			}
			
			var result:Vector.<TextSpan> = new Vector.<TextSpan>();
			
			var switchFont:Boolean = true;
			
			const l:uint = text.length;
			for (var i:uint = 0; i < l; i++)
			{
				// react to tag
				if (switchFont)
				{
					var currentFontFormat:HardwareTextFormat = (fontStack.lastElement as HardwareTextFormatListElement).hardwareTextFormat;
					
					if (currentFontFormat)
					{
						var cmapData:CharacterIndexMappingTableData = currentFontFormat.font.data.retrieveTableData(TableNames.CHARACTER_INDEX_MAPPING) as CharacterIndexMappingTableData;
						var glyfData:GlyphTableData = currentFontFormat.font.data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
						
						var currentSpan:TextSpan = new TextSpan();
						currentSpan.textFormat = currentFontFormat;
						
						var currentCharacterInstances:LinkedList = new LinkedList();
						currentSpan.characterInstances = currentCharacterInstances;
						
						result.push(currentSpan);
					}
					
					switchFont = false;
				}
				
				var charCode:uint = text.charCodeAt(i);
				// check if a tag is starting
				if (charCode == CHAR_CODE_OPEN_ANGLE_BRACKET)
				{
					// check which tag this is.
					var closingIndex:uint = text.indexOf(">", i);
					if (closingIndex != -1)
					{
						var tagContent:String = text.substring(i + 1, closingIndex);
						var textTag:TextTag = parseTagContent(tagContent);
						if (textTag)
						{
							switch (textTag.id)
							{
								case TextTag.ID_FORMAT: 
									var formatTag:FormatTag = textTag as FormatTag;
									processFormatTag(formatTag, fontStack, cache);
									
									switchFont = true;
									break;
								
								case TextTag.ID_FORMAT_CLOSED: 
									fontStack.removeElement(fontStack.lastElement);
									switchFont = true;
									break;
							}
							
							i = closingIndex;
							continue;
						}
					}
				}
				
				var glyphIndex:int = cmapData.getGlyphIndex(charCode, 3, 1);
				
				var glyph:Glyph = glyfData.retrieveGlyph(glyphIndex);
				
				var currentCharacter:HardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance();
				currentCharacter.glyph = glyph;
				currentCharacter.charCode = charCode;
				
				currentCharacterInstances.addElement(currentCharacter);
				
				var lastCharacter:HardwareCharacterInstance = currentCharacter;
			}
			
			// apply character substitution
			applyCharacterSubstitutions(result);
			
			return result;
		}
		
		private function processFormatTag(formatTag:FormatTag, fontStack:LinkedList, cache:HardwareCharacterCache):void
		{
			var parentFormat:HardwareTextFormat;
			var newTextFormat:HardwareTextFormat;
			if (formatTag.isFormatIdSet)
			{
				newTextFormat = cache.textFormatMap.getTextFormatById(formatTag.formatId);
				
				if (formatTag.extendsReferencedFormat || !newTextFormat)
				{
					// create new text format with the referenced format as parent
					parentFormat = newTextFormat;
					newTextFormat = new HardwareTextFormat(parentFormat);
				}
			}
			else
			{
				parentFormat = (fontStack.lastElement as HardwareTextFormatListElement).hardwareTextFormat;
				newTextFormat = new HardwareTextFormat(parentFormat);
			}
			
			// pass on values
			if (formatTag.isColorIdSet)
			{
				if (cache.textColorMap.hasTextColorId(formatTag.colorId))
				{
					newTextFormat.textColor = cache.textColorMap.getTextColorById(formatTag.colorId);
				}
			}
			else if (formatTag.isColorSet)
			{
				newTextFormat.color = formatTag.color;
			}
			
			if (!cache.textColorMap.hasTextColorId(newTextFormat.textColor.id))
			{
				cache.textColorMap.addTextColor(newTextFormat.textColor);
			}
			
			if (formatTag.isScaleSet)
			{
				newTextFormat.scale = formatTag.scale;
			}
			
			if (formatTag.isTextAlignSet)
			{
				newTextFormat.textAlign = formatTag.textAlign;
			}
			
			if (formatTag.isVertexDistanceSet)
			{
				newTextFormat.vertexDistance = formatTag.vertexDistance;
			}
			
			if (formatTag.areFeaturesSet)
			{
				newTextFormat.features.copyFrom(formatTag.features);
			}
			if (parentFormat)
			{
				newTextFormat.features.parent = parentFormat.features;
			}
			
			if (formatTag.isScriptTagSet)
			{
				newTextFormat.scriptTag = formatTag.scriptTag;
			}
			
			if (formatTag.isLanguageTagSet)
			{
				newTextFormat.languageTag = formatTag.languageTag;
			}
			
			if (formatTag.isFontIdSet)
			{
				if (cache.fontMap.hasFontId(formatTag.fontId))
				{
					var font:HardwareFont = cache.fontMap.getFontById(formatTag.fontId);
					newTextFormat.font = font;
				}
			}
			
			if (formatTag.isShearXSet)
			{
				newTextFormat.shearX = formatTag.shearX;
			}
			
			if (formatTag.isShearYSet)
			{
				newTextFormat.shearY = formatTag.shearY;
			}
			
			fontStack.addElement(new HardwareTextFormatListElement(newTextFormat));
		}
		
		private function parseTagContent(tagContent:String):TextTag
		{
			//var tagElements:Array = tagContent.split(/ +/);
			//const l:uint = tagElements.length;
			//if (l < 1)
			//{
			//return null;
			//}
			
			var spaceIndex:int = tagContent.indexOf(" ");
			
			var tagName:String;
			var tagParameters:String;
			
			if (spaceIndex != -1)
			{
				tagName = tagContent.substring(0, spaceIndex);
				tagParameters = tagContent.substring(spaceIndex + 1);
			}
			else
			{
				tagName = tagContent;
			}
			
			switch (tagName)
			{
				// Parse the format tag.
				case FormatTag.TAG: 
					var formatTag:FormatTag = parseTagFormatParameters(tagParameters);
					return formatTag;
				
				case FormatTag.TAG_CLOSE: 
					var tag:TextTag = new FormatTag();
					tag.id = TextTag.ID_FORMAT_CLOSED;
					return tag;
			}
			
			return null;
		}
		
		private function parseTagFormatParameters(tagParameters:String):FormatTag
		{
			var parameters:Array = tagParameters.match(/([\w]+=["']?[-\w\s,.:]+["']?)/g);
			const l:uint = parameters.length;
			
			var formatTag:FormatTag = new FormatTag();
			
			for (var i:uint = 0; i < l; i++)
			{
				var parameter:String = parameters[i];
				parseFormatParameter(parameter, formatTag);
			}
			
			return formatTag;
		}
		
		private function parseFormatParameter(parameter:String, formatTag:FormatTag):void
		{
			var indexOfEqualSign:int = parameter.indexOf("=");
			if (indexOfEqualSign == -1)
			{
				return;
			}
			
			var parameterName:String = parameter.substring(0, indexOfEqualSign).toLowerCase();
			var parameterValue:String = parameter.substr(indexOfEqualSign + 1);
			parameterValue = parameterValue.replace(/[(\\")']/g, "");
			
			switch (parameterName)
			{
				case FormatTag.ATTRIBUTE_SCALE: 
					var number:Number = Number(parameterValue);
					formatTag.scale = number;
					
					break;
				
				case FormatTag.ATTRIBUTE_COLOR: 
					var unsignedInt:uint = uint(parameterValue);
					formatTag.color = unsignedInt;
					
					break;
				
				case FormatTag.ATTRIBUTE_TEXTALIGN: 
					unsignedInt = uint(parameterValue);
					formatTag.textAlign = unsignedInt;
					
					break;
				
				case FormatTag.ATTRIBUTE_VERTEXDISTANCE: 
					unsignedInt = uint(parameterValue);
					formatTag.vertexDistance = unsignedInt;
					
					break;
				
				case FormatTag.ATTRIBUTE_FEATURES: 
					var array:Array = parameterValue.split(/,\s*/g);
					var fontFeatures:HardwareFontFeatures = new HardwareFontFeatures();
					
					unsignedInt = array.length;
					for (var i:uint = 0; i < unsignedInt; i++)
					{
						var featureTag:FeatureTag = FeatureTag.getFeatureTag(array[i]);
						if (featureTag)
						{
							fontFeatures.addFeature(featureTag);
						}
					}
					
					formatTag.features = fontFeatures;
					
					break;
				
				case FormatTag.ATTRIBUTE_SCRIPT: 
					var string:String = parameterValue;
					formatTag.scriptTag = string;
					
					break;
				
				case FormatTag.ATTRIBUTE_LANGUAGE: 
					string = parameterValue;
					formatTag.languageTag = string;
					
					break;
				
				case FormatTag.ATTRIBUTE_FONT: 
					string = parameterValue;
					formatTag.fontId = string;
					
					break;
				
				case FormatTag.ATTRIBUTE_FORMATID: 
					string = parameterValue;
					formatTag.formatId = string;
					
					break;
				
				case FormatTag.ATTRIBUTE_COLORID: 
					string = parameterValue;
					formatTag.colorId = string;
					
					break;
					
				case FormatTag.ATTRIBUTE_SHEARX: 
					number = Number(parameterValue);
					formatTag.shearX = number;
					
					break;
					
				case FormatTag.ATTRIBUTE_SHEARY: 
					number = Number(parameterValue);
					formatTag.shearY = number;
					
					break;
			}
		}
	}

}