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
			
			font.retrieveCharacterDefinitions(characterInstances);
			font.performCharacterSubstitutions(characterInstances, scriptTag, languageTag);
			collectGlyphs(characterInstances, hardwareText, font, subdivision, cache);
			
			// layouting
			layout(hardwareText, characterInstances, font, scriptTag, languageTag);
			
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
		
		private function layout(hardwareText:HardwareText, characterInstances:LinkedList, font:HardwareFont, scriptTag:String, languageTag:String):void
		{
			// TODO: Clean up this mess, while keeping the code fast. Somehow. Avoid duplicate code.
			
			// positioning tables
			var fontAscender:int = font.ascender;
			var fontDescender:int = font.descender;
			var hmtxData:HorizontalMetricsData = font.data.retrieveTable(TableNames.HORIZONTAL_METRICS).data as HorizontalMetricsData;
			
			var gpos:Table = font.data.retrieveTable(TableNames.GLYPH_POSITIONING_DATA);
			var gposData:GlyphPositioningTableData;
			var gposLookupTables:Vector.<LookupTable>;
			if (gpos)
			{
				gposData = gpos.data as GlyphPositioningTableData;
				gposLookupTables = gposData.retrieveFeatureLookupTables(scriptTag, languageTag)
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
				
				x += characterInstance.rightBearing;
				
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
				// apply table data
				applyTableData(characterInstances, hmtxData, gposData, gposLookupTables, kernData);
				
				characterInstance.x += x + characterInstance.leftBearing;
				x += characterInstance.rightBearing;
				
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
			hmtxData.applyTable(characterInstances);
			
			if (gposLookupTables)
			{
				const l:uint = gposLookupTables.length;
				for (var i:uint = 0; i < l; i++)
				{
					var lookupTable:LookupTable = gposLookupTables[i];
					lookupTable.performLookup(characterInstances, gposData);
				}
			}
			
			if (kernData)
			{
				//TODO: apply kerning
			}
		}
		
		private function collectGlyphs(characterInstances:LinkedList, hardwareText:HardwareText, font:HardwareFont, subdivisons:uint, cache:HardwareCharacterCache):void
		{
			characterInstances.gotoFirstElement();
			
			while (characterInstances.currentElement)
			{
				var characterInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
				var character:HardwareCharacter = cache.getCachedCharacter(font, subdivisons, characterInstance.glyphID);
				if (character)
				{
					characterInstance.hardwareCharacter = character;
				}
				
				characterInstance.registerGlyphInstances(font.uniqueIdentifier, subdivisons, 0x0, cache);
				
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
				var glyphID:uint = font.getGlyphIndex(charCode);
				
				var hardwareCharacterInstance:HardwareCharacterInstance = HardwareCharacterInstance.getHardwareCharacterInstance(null);
				hardwareCharacterInstance.glyphID = glyphID;
				hardwareCharacterInstance.charCode = charCode;
				
				var listElement:HardwareCharacterInstanceListElement = new HardwareCharacterInstanceListElement(hardwareCharacterInstance);
				characterInstances.addElement(listElement);
			}
			
			return characterInstances;
		}
	
	}

}