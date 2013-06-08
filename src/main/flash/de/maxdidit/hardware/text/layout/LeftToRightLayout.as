package de.maxdidit.hardware.text.layout 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.components.HardwareLine;
	import de.maxdidit.hardware.text.components.HardwareWord;
	import de.maxdidit.hardware.text.components.TextSpan;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.text.layout.Printhead;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LeftToRightLayout implements ILayout 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const CHAR_CODE_SPACE:uint = Keyboard.SPACE;
		public static const CHAR_CODE_NEWLINE:uint = "\n".charCodeAt(0);
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var printhead:Printhead;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LeftToRightLayout() 
		{
			printhead = new Printhead();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.text.layout.ILayout */
		
		public function layout(hardwareText:HardwareText, textSpans:Vector.<TextSpan>, cache:HardwareCharacterCache):void 
		{
			printhead.lineX = 0;
			printhead.y = 0;
			
			printhead.currentLine = new HardwareLine();
			
			printhead.lookupIndices = new Vector.<int>();
			printhead.glyphInstances = new Vector.<HardwareGlyphInstance>();
			
			const l:uint = textSpans.length;
			for (var i:uint = 0; i < l; i++)
			{
				// set up
				printhead.textSpan = textSpans[i];
				
				if (printhead.currentWord)
				{
					printhead.currentWord.ascender = printhead.currentWord.ascender < printhead.font.ascender * printhead.textFormat.scale ? printhead.font.ascender * printhead.textFormat.scale : printhead.currentWord.ascender;
					printhead.currentWord.descender = printhead.currentWord.descender > printhead.font.descender * printhead.textFormat.scale ? printhead.font.descender * printhead.textFormat.scale : printhead.currentWord.descender;
				}
				
				var gposData:GlyphPositioningTableData = printhead.font.data.retrieveTableData(TableNames.GLYPH_POSITIONING_DATA) as GlyphPositioningTableData;
				retrieveLookupIndices(gposData, printhead.lookupIndices, printhead.textFormat);
				
				printhead.characterInstances.gotoFirstElement();
				
				while (printhead.characterInstances.currentElement)
				{
					printCharacter(hardwareText, printhead, cache);
					printhead.characterInstances.gotoNextElement();
					continue;
				}
			}
			
			endWord(hardwareText, printhead);
			startNewLine(hardwareText, printhead);
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
		
		private function printCharacter(hardwareText:HardwareText, printhead:Printhead, cache:HardwareCharacterCache):void
		{
			var currentCharacter:HardwareCharacterInstance = printhead.characterInstances.currentElement as HardwareCharacterInstance;
			if (currentCharacter.charCode == CHAR_CODE_NEWLINE)
			{
				endWord(hardwareText, printhead);
				
				printhead.currentLine.ascender = printhead.currentLine.ascender < printhead.font.ascender * printhead.textFormat.scale ? printhead.font.ascender * printhead.textFormat.scale : printhead.currentLine.ascender;
				printhead.currentLine.descender = printhead.currentLine.descender > printhead.font.descender * printhead.textFormat.scale ? printhead.font.descender * printhead.textFormat.scale : printhead.currentLine.descender;
				
				startNewLine(hardwareText, printhead)
				return;
			}
			
			var ll:uint = printhead.lookupIndices.length;
			for (var i:uint = 0; i < ll; i++)
			{
				currentCharacter.glyph.applyGlyphLookup(TableNames.GLYPH_POSITIONING_DATA, printhead.characterInstances, printhead.lookupIndices[i]);
			}
			
			// move print head
			currentCharacter.x = printhead.wordX;
			printhead.wordX += (currentCharacter.advanceWidthAdjustment + currentCharacter.glyph.advanceWidth) * printhead.textFormat.scale;
			
			if (currentCharacter.charCode == CHAR_CODE_SPACE)
			{
				endWord(hardwareText, printhead);
				return;
			}
			
			if (!printhead.currentWord)
			{
				startWord(printhead);
			}
			
			printhead.glyphInstances.length = 0;
			currentCharacter.glyph.retrieveGlyphInstances(printhead.glyphInstances);
			
			var il:uint = printhead.glyphInstances.length;
			for (i = 0; i < il; i++)
			{
				var glyphInstance:HardwareGlyphInstance = printhead.glyphInstances[i];
				var hardwareGlyph:HardwareGlyph = cache.getCachedHardwareGlyph(printhead.font.uniqueIdentifier, printhead.textFormat.vertexDensity, glyphInstance.glyph.header.index);
				if (!hardwareGlyph)
				{
					var paths:Vector.<Vector.<Vertex>> = glyphInstance.glyph.retrievePaths(printhead.textFormat.vertexDensity);
					hardwareGlyph = cache.addPathsAsHardwareGlyph(paths, printhead.font, printhead.textFormat.vertexDensity, glyphInstance.glyph.header.index);
				}
				glyphInstance.hardwareGlyph = hardwareGlyph;
				
				cache.registerGlyphInstance(glyphInstance, printhead.textFormat);
				currentCharacter.addChild(glyphInstance);
			}
			
			currentCharacter.scaleX = currentCharacter.scaleY = printhead.textFormat.scale;
			
			printhead.currentWord.addChild(currentCharacter);
		}
		
		private function startWord(printhead:Printhead):void
		{
			printhead.currentWord = new HardwareWord();
			
			printhead.currentWord.ascender = printhead.font.ascender * printhead.textFormat.scale;
			printhead.currentWord.descender = printhead.font.descender * printhead.textFormat.scale;
		}
		
		private function endWord(hardwareText:HardwareText, printhead:Printhead):void
		{
			if (printhead.currentWord)
			{
				if (printhead.lineX + printhead.wordX > hardwareText.width)
				{
					startNewLine(hardwareText, printhead);
				}
				
				printhead.currentLine.ascender = printhead.currentLine.ascender < printhead.currentWord.ascender ? printhead.currentWord.ascender : printhead.currentLine.ascender;
				printhead.currentLine.descender = printhead.currentLine.descender > printhead.currentWord.descender ? printhead.currentWord.descender : printhead.currentLine.descender;
				
				printhead.currentWord.x = printhead.lineX;
				printhead.currentLine.addChild(printhead.currentWord);
				printhead.currentWord = null;
				
				printhead.lineX += printhead.wordX;
				printhead.wordX = 0;
			}
		}
		
		private function startNewLine(hardwareText:HardwareText, printhead:Printhead):void
		{
			printhead.y -= printhead.currentLine.ascender - printhead.currentLine.descender;
			printhead.currentLine.y = printhead.y;
			hardwareText.addChild(printhead.currentLine);
			
			printhead.lineX = 0;
			
			printhead.currentLine = new HardwareLine();
		}
	}

}