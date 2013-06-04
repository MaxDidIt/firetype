package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.GlyphSubstitutionTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable;
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
		
		public static const TAG_FORMAT:String = "format";
		public static const TAG_FORMAT_CLOSE:String = "/format";
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Typesetter()
		{
		
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function assemble(hardwareText:HardwareText, cache:HardwareCharacterCache):void
		{
			var time:int = getTimer();
			
			var font:HardwareFont = hardwareText.standardFormat.font;
			
			var textSpans:Vector.<TextSpan> = createTextSpans(hardwareText.text, font, hardwareText.standardFormat, cache);
			applyCharacterSubstitutions(textSpans);
			layout(hardwareText, textSpans, cache);
			
			trace("Assembly time: " + (getTimer() - time));
		}
		
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
					currentCharacter.glyph.applyGlyphLookups(TableNames.GLYPH_SUBSTITUTION_DATA, characterInstances, lookupIndices);
					characterInstances.gotoNextElement();
				}
			}
		}
		
		private function retrieveLookupIndices(scriptFeatureLookup:ScriptFeatureLookupTable, lookupIndices:Vector.<int>, textFormat:HardwareTextFormat):void
		{
			lookupIndices.length = 0;
			
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
		
		private function layout(hardwareText:HardwareText, textSpans:Vector.<TextSpan>, cache:HardwareCharacterCache):void
		{
			var lookupIndices:Vector.<int> = new Vector.<int>();
			
			var wordX:int = 0;
			var lineX:int = 0;
			var y:int = 0;
			
			var currentWord:HardwareWord;
			
			const l:uint = textSpans.length;
			for (var i:uint = 0; i < l; i++)
			{
				// set up
				var textSpan:TextSpan = textSpans[i];
				
				var textFormat:HardwareTextFormat = textSpan.textFormat;
				var font:HardwareFont = textFormat.font;
				
				var gposData:GlyphPositioningTableData = font.data.retrieveTableData(TableNames.GLYPH_POSITIONING_DATA) as GlyphPositioningTableData;
				if (!gposData)
				{
					continue;
				}
				
				retrieveLookupIndices(gposData, lookupIndices, textFormat);
				
				var characterInstances:LinkedList = textSpan.characterInstances;
				characterInstances.gotoFirstElement();
				
				var glyphInstances:Vector.<HardwareGlyphInstance> = new Vector.<HardwareGlyphInstance>();
				
				while (characterInstances.currentElement)
				{
					var currentCharacter:de.maxdidit.hardware.text.components.HardwareCharacterInstance = characterInstances.currentElement as de.maxdidit.hardware.text.components.HardwareCharacterInstance;
					currentCharacter.glyph.applyGlyphLookups(TableNames.GLYPH_POSITIONING_DATA, characterInstances, lookupIndices);
					
					glyphInstances.length = 0;
					currentCharacter.glyph.retrieveGlyphInstances(glyphInstances);
					
					var il:uint = glyphInstances.length;
					for (var g:uint = 0; g < il; g++)
					{
						var glyphInstance:HardwareGlyphInstance = glyphInstances[g];
						var hardwareGlyph:HardwareGlyph = cache.getCachedHardwareGlyph(font, textFormat.subdivisions, currentCharacter.glyph.index);
						if (!hardwareGlyph)
						{
							var paths:Vector.<Vector.<Vertex>> = glyphInstance.glyph.retrievePaths(textFormat.subdivisions);
							hardwareGlyph = cache.addPathsAsHardwareGlyph(paths, font, textFormat.subdivisions, glyphInstance.glyph.index);
						}
						glyphInstance.hardwareGlyph = hardwareGlyph;
						
						cache.registerGlyphInstance(glyphInstance, font.uniqueIdentifier, textFormat.subdivisions, textFormat);
						currentCharacter.addChild(glyphInstance);
					}
					
					// iterate linked list, don't update currentCharacter variable yet.
					characterInstances.gotoNextElement();
					
					if (currentCharacter.charCode == CHAR_CODE_NEWLINE || lineX + wordX > hardwareText.width)
					{
						//start new line
						y -= font.ascender - font.descender;
						lineX = 0;
						
						if (currentCharacter.charCode == CHAR_CODE_NEWLINE)
						{
							wordX = 0;
								
							// start new word
							if (currentWord)
							{
								currentWord = null;
							}
							
							continue;
						}
						else
						{
							if (currentWord)
							{
								currentWord.x = 0;
								currentWord.y = y;
							}
							else
							{
								wordX = 0;
							}
						}
					}
					
					if (currentCharacter.charCode == CHAR_CODE_SPACE)
					{
						// start new word
						if (currentWord)
						{
							currentWord = null;
						}
					}
					else
					{
						if (!currentWord)
						{
							lineX += wordX; // add white space
							wordX = 0;
							
							currentWord = new HardwareWord();
							currentWord.x = lineX;
							currentWord.y = y;
							
							hardwareText.addChild(currentWord);
						}
						
						currentWord.addChild(currentCharacter);
					}
					
					currentCharacter.x = wordX;
					wordX += currentCharacter.advanceWidthAdjustment + currentCharacter.glyph.advanceWidth;
				}
			}
		}
		
		private function createTextSpans(text:String, font:HardwareFont, standardTextFormat:HardwareTextFormat, cache:HardwareCharacterCache):Vector.<TextSpan>
		{
			var fontStack:LinkedList = new LinkedList();
			fontStack.addElement(new HardwareTextFormatListElement(standardTextFormat));
			
			var result:Vector.<TextSpan> = new Vector.<TextSpan>();
			
			var switchFont:Boolean = true;
			
			const l:uint = text.length;
			for (var i:uint = 0; i < l; i++)
			{
				// react to tag
				if (switchFont)
				{
					var currentFontFormat:HardwareTextFormat = (fontStack.lastElement as HardwareTextFormatListElement).hardwareTextFormat;
					
					var cmapData:CharacterIndexMappingTableData = currentFontFormat.font.data.retrieveTableData(TableNames.CHARACTER_INDEX_MAPPING) as CharacterIndexMappingTableData;
					var glyfData:GlyphTableData = currentFontFormat.font.data.retrieveTableData(TableNames.GLYPH_DATA) as GlyphTableData;
					
					var currentSpan:TextSpan = new TextSpan();
					currentSpan.textFormat = currentFontFormat;
					
					var currentCharacterInstances:LinkedList = new LinkedList();
					currentSpan.characterInstances = currentCharacterInstances;
					
					result.push(currentSpan);
					
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
						var textTag:TextTag = parseTagContent_(tagContent);
						if (textTag)
						{
							switch (textTag.id)
							{
								case TextTag.ID_FORMAT: 
									var newTextFormat:HardwareTextFormat = cache.textFormatMap.getTextFormatById((textTag as FormatTag).formatId);
									fontStack.addElement(new HardwareTextFormatListElement(newTextFormat));
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
				
				var glyphIndex:uint = cmapData.getGlyphIndex(charCode, 3, 1);
				var glyph:Glyph = glyfData.retrieveGlyph(glyphIndex);
				
				var currentCharacter:de.maxdidit.hardware.text.components.HardwareCharacterInstance = new de.maxdidit.hardware.text.components.HardwareCharacterInstance();
				currentCharacter.glyph = glyph;
				currentCharacter.charCode = charCode;
				
				//currentCharacter.textFormat = currentFontFormat;
				
				currentCharacterInstances.addElement(currentCharacter);
				
				currentCharacter.previous = lastCharacter;
				var lastCharacter:de.maxdidit.hardware.text.components.HardwareCharacterInstance = currentCharacter;
			}
			
			return result;
		}
		
		private function parseTagContent_(tagContent:String):TextTag
		{
			var tagElements:Array = tagContent.split(/ +/);
			const l:uint = tagElements.length;
			if (l < 1)
			{
				return null;
			}
			
			var tagName:String = tagElements[0].toLowerCase();
			switch (tagName)
			{
				// Parse the format tag.
				case TAG_FORMAT: 
					if (l < 2)
					{
						return null;
					}
					
					var parameter:String = tagElements[1];
					var parameterElements:Array = parameter.split("=");
					
					if (parameterElements.length < 2)
					{
						return null;
					}
					
					if (parameterElements[0] != "id")
					{
						return null;
					}
					
					var id:String = (parameterElements[1] as String);
					id = id.replace(/[(\\")']/g, "");
					
					var formatTag:FormatTag = new FormatTag();
					formatTag.id = TextTag.ID_FORMAT;
					formatTag.formatId = id;
					
					return formatTag;
				
				case TAG_FORMAT_CLOSE: 
					var tag:TextTag = new FormatTag();
					tag.id = TextTag.ID_FORMAT_CLOSED;
					return tag;
			}
			
			return null;
		}
	
		///////////////////////
		// Deprecated
		///////////////////////
	
		//public function assemble(text:String, hardwareText:HardwareText, standardTextFormat:HardwareTextFormat, cache:HardwareCharacterCache):void
		//{
		//var font:HardwareFont = standardTextFormat.font;
		//var subdivision:uint = standardTextFormat.subdivisions;
		//var scriptTag:String = standardTextFormat.scriptTag;
		//var languageTag:String = standardTextFormat.languageTag;
		//
		//var startTime:uint = getTimer();
		//
		//var characterInstances:LinkedList = initializeCharacterInstances(text, font);
		//
		//font.performCharacterSubstitutions(characterInstances, scriptTag, languageTag, standardTextFormat.features);
		//collectGlyphs(characterInstances, hardwareText, standardTextFormat, subdivision, cache);
		//
		// layouting
		//layout(hardwareText, characterInstances, standardTextFormat, scriptTag, languageTag);
		//
		//trace("assembling time: " + (getTimer() - startTime));
		//}
		//
		//private function triggersNewWord(charCode:uint):Boolean
		//{
		//if (charCode == CHAR_CODE_SPACE)
		//{
		//return true;
		//}
		//
		//if (charCode == CHAR_CODE_NEWLINE)
		//{
		//return true;
		//}
		//
		//return false;
		//}
		//
		//private function layout(hardwareText:HardwareText, characterInstances:LinkedList, textFormat:HardwareTextFormat, scriptTag:String, languageTag:String):void
		//{
		// positioning tables
		//var font:HardwareFont = textFormat.font;
		//var fontAscender:int = font.ascender;
		//var fontDescender:int = font.descender;
		//var hmtxData:HorizontalMetricsData = font.data.retrieveTable(TableNames.HORIZONTAL_METRICS).data as HorizontalMetricsData;
		//
		//var gpos:Table = font.data.retrieveTable(TableNames.GLYPH_POSITIONING_DATA);
		//var gposData:GlyphPositioningTableData;
		//var gposLookupTables:Vector.<LookupTable>;
		//if (gpos)
		//{
		//gposData = gpos.data as GlyphPositioningTableData;
		//gposLookupTables = gposData.retrieveFeatureLookupTables(scriptTag, languageTag, textFormat.features)
		//}
		//
		//var kern:Table = font.data.retrieveTable(TableNames.KERNING);
		//var kernData:KerningTableData;
		//if (kern)
		//{
		//kernData = kern.data as KerningTableData;
		//}
		//
		// layouting
		//var x:int = 0;
		//var y:int = -fontAscender;
		//
		//var currentWord:HardwareWord;
		//
		//characterInstances.gotoFirstElement()
		//while (characterInstances.currentElement)
		//{
		//var xAdvance:int = applyWhitespace(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
		//if (xAdvance >= 0)
		//{
		//x += xAdvance;
		//}
		//else
		//{
		// goto next line
		//y -= fontAscender - fontDescender;
		//x = 0;
		//}
		//
		//currentWord = getNextWord(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
		//
		//if (currentWord)
		//{
		//if (x + currentWord.boundingBox.right > hardwareText.width)
		//{
		// goto next line
		//y -= fontAscender - fontDescender;
		//x = 0;
		//}
		//
		//currentWord.x = x;
		//currentWord.y = y;
		//
		//x += currentWord.boundingBox.right;
		//
		//hardwareText.addChild(currentWord);
		//}
		//}
		//}
		//
		//private function applyWhitespace(characterInstances:LinkedList, hmtxData:HorizontalMetricsData, gposData:GlyphPositioningTableData, gposLookupTables:Vector.<LookupTable>, kernData:KerningTableData):int
		//{
		// setup
		//var characterElement:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
		//if (!characterElement)
		//{
		//return 0;
		//}
		//var characterInstance:HardwareCharacterInstance = characterElement.hardwareCharacterInstance;
		//
		//var charCode:uint = characterInstance.charCode;
		//
		//var x:uint = 0;
		//
		//while (characterElement && triggersNewWord(charCode))
		//{
		//if (charCode == CHAR_CODE_NEWLINE)
		//{
		//characterInstances.gotoNextElement();
		//return -1;
		//}
		//
		//if (charCode == CHAR_CODE_SPACE)
		//{
		//applyTableData(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
		//}
		//
		// TODO: This if should not be necessary in the future; even whitespace should have a hardwareCharacter, just without geometry.
		//if (characterInstance.hardwareCharacter)
		//{
		//x += characterInstance.hardwareCharacter.glyph.advanceWidth;
		//}
		//else
		//{
		// WORKAROUND, remove ASAP.
		//x += 550;
		//}
		//x += characterInstance.advanceWidthAdjustment;
		//
		// iterate to next character
		//characterInstances.gotoNextElement();
		//characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
		//if (characterElement)
		//{
		//characterInstance = characterElement.hardwareCharacterInstance;
		//charCode = characterInstance.charCode;
		//}
		//}
		//
		//return x;
		//}
		//
		//private function getNextWord(characterInstances:LinkedList, hmtxData:HorizontalMetricsData, gposData:GlyphPositioningTableData, gposLookupTables:Vector.<LookupTable>, kernData:KerningTableData):HardwareWord
		//{
		// setup
		//var characterElement:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
		//if (!characterElement)
		//{
		//return null;
		//}
		//var characterInstance:HardwareCharacterInstance = characterElement.hardwareCharacterInstance;
		//
		//var charCode:uint = characterInstance.charCode;
		//var result:HardwareWord = new HardwareWord();
		//
		//var x:uint = 0;
		//
		//while (characterElement && !triggersNewWord(charCode))
		//{
		//if (characterInstance.formatID && characterInstance.formatID != "")
		//{
		//characterInstances.gotoNextElement();
		//characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
		//if (characterElement)
		//{
		//characterInstance = characterElement.hardwareCharacterInstance;
		//charCode = characterInstance.charCode;
		//}
		//continue;
		//}
		//
		//if (characterInstance.formatClosed)
		//{
		//characterInstances.gotoNextElement();
		//characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
		//if (characterElement)
		//{
		//characterInstance = characterElement.hardwareCharacterInstance;
		//charCode = characterInstance.charCode;
		//}
		//continue;
		//}
		//
		// apply table data
		//applyTableData(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
		//
		// This is confusing: the spacing between letters seems correct if I ignore the left side bearing.
		//characterInstance.x += x; //- characterInstance.leftSideBearing;
		//x += characterInstance.hardwareCharacter.glyph.advanceWidth + characterInstance.advanceWidthAdjustment;
		//
		//result.addChild(characterInstance);
		//
		// iterate to next character
		//characterInstances.gotoNextElement();
		//characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
		//if (characterElement)
		//{
		//characterInstance = characterElement.hardwareCharacterInstance;
		//charCode = characterInstance.charCode;
		//}
		//}
		//
		//result.boundingBox.right = x;
		//
		//return result;
		//}
		//
		//private function applyTableData(characterInstances:LinkedList, hmtxData:HorizontalMetricsData, gposData:GlyphPositioningTableData, gposLookupTables:Vector.<LookupTable>, kernData:KerningTableData):void
		//{
		//apply tables			
		//if (gposLookupTables)
		//{
		//const l:uint = gposLookupTables.length;
		//for (var i:uint = 0; i < l; i++)
		//{
		//var lookupTable:LookupTable = gposLookupTables[i];
		//lookupTable.performLookup(characterInstances, gposData);
		//}
		//}
		//else if (kernData)
		//{
		//TODO: apply kerning
		//}
		//}
		//
		//private function collectGlyphs(characterInstances:LinkedList, hardwareText:HardwareText, standardTextFormat:HardwareTextFormat, subdivisons:uint, cache:HardwareCharacterCache):void
		//{
		//var font:HardwareFont = standardTextFormat.font;
		//
		//var formatStack:LinkedList = new LinkedList();
		//formatStack.addElement(new HardwareTextFormatListElement(standardTextFormat));
		//
		//characterInstances.gotoFirstElement();
		//
		//while (characterInstances.currentElement)
		//{
		//var currentTextFormat:HardwareTextFormat = (formatStack.lastElement as HardwareTextFormatListElement).hardwareTextFormat;
		//
		//var characterInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
		//
		// check if there is a font switch
		//if (characterInstance.formatID && characterInstance.formatID != "")
		//{
		//if (!cache.textFormatMap.hasTextFormatId(characterInstance.formatID))
		//{
		//throw new Error("There is no text format with the ID \"" + characterInstance.formatID + "\" registered in the character cache. Please register the respective text format with the character cache.");
		//}
		//
		//var textFormat:HardwareTextFormat = cache.textFormatMap.getTextFormatById(characterInstance.formatID);
		//formatStack.addElement(new HardwareTextFormatListElement(textFormat));
		//
		//characterInstances.gotoNextElement();
		//continue;
		//}
		//
		// check if a font has been switched back
		//if (characterInstance.formatClosed)
		//{
		//formatStack.removeElement(formatStack.lastElement);
		//
		//characterInstances.gotoNextElement();
		//continue;
		//}
		//
		// add character to cache
		//var character:HardwareCharacter = cache.getCachedCharacter(currentTextFormat.font, subdivisons, characterInstance.glyphID);
		//if (character)
		//{
		//characterInstance.hardwareCharacter = character;
		//}
		//
		//characterInstance.registerGlyphInstances(currentTextFormat.font.uniqueIdentifier, subdivisons, currentTextFormat, cache);
		//
		//characterInstances.gotoNextElement();
		//}
		//}
		//
		//private function initializeCharacterInstances(text:String, font:HardwareFont):LinkedList
		//{
		//var characterInstances:LinkedList = new LinkedList();
		//
		//const l:uint = text.length;
		//for (var i:uint = 0; i < l; i++)
		//{
		//var charCode:Number = text.charCodeAt(i);
		//var hardwareCharacterInstance:HardwareCharacterInstance;
		//
		// check if this is the start of a tag
		//if (charCode == CHAR_CODE_OPEN_ANGLE_BRACKET)
		//{
		// check which tag this is.
		//var closingIndex:uint = text.indexOf(">", i);
		//if (closingIndex != -1)
		//{
		//var tagContent:String = text.substring(i + 1, closingIndex);
		//hardwareCharacterInstance = parseTagContent(tagContent);
		//
		//if (hardwareCharacterInstance)
		//{
		//characterInstances.addElement(new HardwareCharacterInstanceListElement(hardwareCharacterInstance));
		//i = closingIndex;
		//continue;
		//}
		//}
		//}
		//
		//var glyphID:uint = font.getGlyphIndex(charCode);
		//
		//hardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
		//hardwareCharacterInstance.glyphID = glyphID;
		//hardwareCharacterInstance.charCode = charCode;
		//
		//var listElement:HardwareCharacterInstanceListElement = new HardwareCharacterInstanceListElement(hardwareCharacterInstance);
		//characterInstances.addElement(listElement);
		//}
		//
		//return characterInstances;
		//}
		//
		//private function parseTagContent(tagContent:String):HardwareCharacterInstance
		//{
		//var tagElements:Array = tagContent.split(/ +/);
		//const l:uint = tagElements.length;
		//if (l < 1)
		//{
		//return null;
		//}
		//
		//var tagName:String = tagElements[0].toLowerCase();
		//switch (tagName)
		//{
		// Parse the format tag.
		//case TAG_FORMAT: 
		//if (l < 2)
		//{
		//return null;
		//}
		//
		//var parameter:String = tagElements[1];
		//var parameterElements:Array = parameter.split("=");
		//
		//if (parameterElements.length < 2)
		//{
		//return null;
		//}
		//
		//if (parameterElements[0] != "id")
		//{
		//return null;
		//}
		//
		//var id:String = (parameterElements[1] as String);
		//id = id.replace(/[(\\")']/g, "");
		//
		//var instance:HardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
		//instance.formatID = id;
		//
		//return instance;
		//
		//case TAG_FORMAT_CLOSE: 
		//instance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
		//instance.formatClosed = true;
		//;
		//return instance;
		//}
		//
		//return null;
		//}
	
	}

}