package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.other.kern.KerningTableData;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.HorizontalMetricsData;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.format.HardwareTextFormatListElement;
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
		
		public function assemble(text:String, hardwareText:HardwareText, standardTextFormat:HardwareTextFormat, cache:HardwareCharacterCache):void
		{
			var font:HardwareFont = standardTextFormat.font;
			var subdivision:uint = standardTextFormat.subdivisions;
			var scriptTag:String = standardTextFormat.scriptTag;
			var languageTag:String = standardTextFormat.languageTag;
			
			var startTime:uint = getTimer();
			
			var characterInstances:LinkedList = initializeCharacterInstances(text, font);
			
			font.performCharacterSubstitutions(characterInstances, scriptTag, languageTag, standardTextFormat.features);
			collectGlyphs(characterInstances, hardwareText, standardTextFormat, subdivision, cache);
			
			// layouting
			layout(hardwareText, characterInstances, standardTextFormat, scriptTag, languageTag);
			
			trace("assembling time: " + (getTimer() - startTime));
		}
		
		private function triggersNewWord(charCode:uint):Boolean
		{
			if (charCode == CHAR_CODE_SPACE)
			{
				return true;
			}
			
			if (charCode == CHAR_CODE_NEWLINE)
			{
				return true;
			}
			
			return false;
		}
		
		private function layout(hardwareText:HardwareText, characterInstances:LinkedList, textFormat:HardwareTextFormat, scriptTag:String, languageTag:String):void
		{
			// positioning tables
			var font:HardwareFont = textFormat.font;
			var fontAscender:int = font.ascender;
			var fontDescender:int = font.descender;
			var hmtxData:HorizontalMetricsData = font.data.retrieveTable(TableNames.HORIZONTAL_METRICS).data as HorizontalMetricsData;
			
			var gpos:Table = font.data.retrieveTable(TableNames.GLYPH_POSITIONING_DATA);
			var gposData:GlyphPositioningTableData;
			var gposLookupTables:Vector.<LookupTable>;
			if (gpos)
			{
				gposData = gpos.data as GlyphPositioningTableData;
				gposLookupTables = gposData.retrieveFeatureLookupTables(scriptTag, languageTag, textFormat.features)
			}
			
			var kern:Table = font.data.retrieveTable(TableNames.KERNING);
			var kernData:KerningTableData;
			if (kern)
			{
				kernData = kern.data as KerningTableData;
			}
			
			// layouting
			var x:int = 0;
			var y:int = -fontAscender;
			
			var currentWord:HardwareWord;
			
			characterInstances.gotoFirstElement()
			while (characterInstances.currentElement)
			{
				var xAdvance:int = applyWhitespace(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
				if (xAdvance >= 0)
				{
					x += xAdvance;
				}
				else
				{
					// goto next line
					y -= fontAscender - fontDescender;
					x = 0;
				}
				
				currentWord = getNextWord(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
				
				if (currentWord)
				{
					if (x + currentWord.boundingBox.right > hardwareText.width)
					{
						// goto next line
						y -= fontAscender - fontDescender;
						x = 0;
					}
					
					currentWord.x = x;
					currentWord.y = y;
					
					x += currentWord.boundingBox.right;
					
					hardwareText.addChild(currentWord);
				}
			}
		}
		
		private function applyWhitespace(characterInstances:LinkedList, hmtxData:HorizontalMetricsData, gposData:GlyphPositioningTableData, gposLookupTables:Vector.<LookupTable>, kernData:KerningTableData):int
		{
			// setup
			var characterElement:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			if (!characterElement)
			{
				return 0;
			}
			var characterInstance:HardwareCharacterInstance = characterElement.hardwareCharacterInstance;
			
			var charCode:uint = characterInstance.charCode;
			
			var x:uint = 0;
			
			while (characterElement && triggersNewWord(charCode))
			{
				if (charCode == CHAR_CODE_NEWLINE)
				{
					characterInstances.gotoNextElement();
					return -1;
				}
				
				if (charCode == CHAR_CODE_SPACE)
				{
					applyTableData(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
				}
				
				// TODO: This if should not be necessary in the future; even whitespace should have a hardwareCharacter, just without geometry.
				if (characterInstance.hardwareCharacter)
				{
					x += characterInstance.hardwareCharacter.glyph.advanceWidth;
				}
				else
				{
					// WORKAROUND, remove ASAP.
					x += 550;
				}
				x += characterInstance.advanceWidthAdjustment;
				
				// iterate to next character
				characterInstances.gotoNextElement();
				characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
				if (characterElement)
				{
					characterInstance = characterElement.hardwareCharacterInstance;
					charCode = characterInstance.charCode;
				}
			}
			
			return x;
		}
		
		private function getNextWord(characterInstances:LinkedList, hmtxData:HorizontalMetricsData, gposData:GlyphPositioningTableData, gposLookupTables:Vector.<LookupTable>, kernData:KerningTableData):HardwareWord
		{
			// setup
			var characterElement:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			if (!characterElement)
			{
				return null;
			}
			var characterInstance:HardwareCharacterInstance = characterElement.hardwareCharacterInstance;
			
			var charCode:uint = characterInstance.charCode;
			var result:HardwareWord = new HardwareWord();
			
			var x:uint = 0;
			
			while (characterElement && !triggersNewWord(charCode))
			{
				if (characterInstance.formatID && characterInstance.formatID != "")
				{
					characterInstances.gotoNextElement();
					characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
					if (characterElement)
					{
						characterInstance = characterElement.hardwareCharacterInstance;
						charCode = characterInstance.charCode;
					}
					continue;
				}
				
				if (characterInstance.formatClosed)
				{
					characterInstances.gotoNextElement();
					characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
					if (characterElement)
					{
						characterInstance = characterElement.hardwareCharacterInstance;
						charCode = characterInstance.charCode;
					}
					continue;
				}
				
				// apply table data
				applyTableData(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
				
				// This is confusing: the spacing between letters seems correct if I ignore the left side bearing.
				characterInstance.x += x; //- characterInstance.leftSideBearing;
				x += characterInstance.hardwareCharacter.glyph.advanceWidth + characterInstance.advanceWidthAdjustment;
				
				result.addChild(characterInstance);
				
				// iterate to next character
				characterInstances.gotoNextElement();
				characterElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
				if (characterElement)
				{
					characterInstance = characterElement.hardwareCharacterInstance;
					charCode = characterInstance.charCode;
				}
			}
			
			result.boundingBox.right = x;
			
			return result;
		}
		
		private function applyTableData(characterInstances:LinkedList, hmtxData:HorizontalMetricsData, gposData:GlyphPositioningTableData, gposLookupTables:Vector.<LookupTable>, kernData:KerningTableData):void
		{
			//apply tables			
			if (gposLookupTables)
			{
				const l:uint = gposLookupTables.length;
				for (var i:uint = 0; i < l; i++)
				{
					var lookupTable:LookupTable = gposLookupTables[i];
					lookupTable.performLookup(characterInstances, gposData);
				}
			}
			else if (kernData)
			{
				//TODO: apply kerning
			}
		}
		
		private function collectGlyphs(characterInstances:LinkedList, hardwareText:HardwareText, standardTextFormat:HardwareTextFormat, subdivisons:uint, cache:HardwareCharacterCache):void
		{
			//var font:HardwareFont = standardTextFormat.font;
			
			var formatStack:LinkedList = new LinkedList();
			formatStack.addElement(new HardwareTextFormatListElement(standardTextFormat));
			
			characterInstances.gotoFirstElement();
			
			while (characterInstances.currentElement)
			{
				var currentTextFormat:HardwareTextFormat = (formatStack.lastElement as HardwareTextFormatListElement).hardwareTextFormat;
				
				var characterInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
				
				// check if there is a font switch
				if (characterInstance.formatID && characterInstance.formatID != "")
				{
					if (!cache.textFormatMap.hasTextFormatId(characterInstance.formatID))
					{
						throw new Error("There is no text format with the ID \"" + characterInstance.formatID + "\" registered in the character cache. Please register the respective text format with the character cache.");
					}
					
					var textFormat:HardwareTextFormat = cache.textFormatMap.getTextFormatById(characterInstance.formatID);
					formatStack.addElement(new HardwareTextFormatListElement(textFormat));
					
					characterInstances.gotoNextElement();
					continue;
				}
				
				// check if a font has been switched back
				if (characterInstance.formatClosed)
				{
					formatStack.removeElement(formatStack.lastElement);
					
					characterInstances.gotoNextElement();
					continue;
				}
				
				// add character to cache
				var character:HardwareCharacter = cache.getCachedCharacter(currentTextFormat.font, subdivisons, characterInstance.glyphID);
				if (character)
				{
					characterInstance.hardwareCharacter = character;
				}
				
				characterInstance.registerGlyphInstances(currentTextFormat.font.uniqueIdentifier, subdivisons, currentTextFormat, cache);
				
				characterInstances.gotoNextElement();
			}
		}
		
		private function initializeCharacterInstances(text:String, font:HardwareFont):LinkedList
		{
			var characterInstances:LinkedList = new LinkedList();
			
			const l:uint = text.length;
			for (var i:uint = 0; i < l; i++)
			{
				var charCode:Number = text.charCodeAt(i);
				var hardwareCharacterInstance:HardwareCharacterInstance;
				
				// check if this is the start of a tag
				if (charCode == CHAR_CODE_OPEN_ANGLE_BRACKET)
				{
					// check which tag this is.
					var closingIndex:uint = text.indexOf(">", i);
					if (closingIndex != -1)
					{
						var tagContent:String = text.substring(i + 1, closingIndex);
						hardwareCharacterInstance = parseTagContent(tagContent);
						
						if (hardwareCharacterInstance)
						{
							characterInstances.addElement(new HardwareCharacterInstanceListElement(hardwareCharacterInstance));
							i = closingIndex;
							continue;
						}
					}
				}
				
				var glyphID:uint = font.getGlyphIndex(charCode);
				
				hardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
				hardwareCharacterInstance.glyphID = glyphID;
				hardwareCharacterInstance.charCode = charCode;
				
				var listElement:HardwareCharacterInstanceListElement = new HardwareCharacterInstanceListElement(hardwareCharacterInstance);
				characterInstances.addElement(listElement);
			}
			
			return characterInstances;
		}
		
		private function parseTagContent(tagContent:String):HardwareCharacterInstance
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
					
					var instance:HardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
					instance.formatID = id;
					
					return instance;
				
				case TAG_FORMAT_CLOSE: 
					instance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
					instance.formatClosed = true;
					;
					return instance;
			}
			
			return null;
		}
	
	}

}