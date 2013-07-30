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
	import de.maxdidit.hardware.text.format.TextAlign; 
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
		 
		public function layout(hardwareText:HardwareText, textSpans:Vector.<TextSpan>):void 
		{ 
			printhead.lineX = 0; 
			printhead.y = 0; 
			printhead.maxX = 0;
			 
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
					printCharacter(hardwareText, printhead); 
					printhead.characterInstances.gotoNextElement(); 
				} 
			} 
			 
			endWord(hardwareText, printhead); 
			startNewLine(hardwareText, printhead);
			
			//hardwareText.actualHeight = Math.abs(printhead.y);
			//hardwareText.actualWidth = printhead.maxX;
			hardwareText.setMeasuredDimensions(printhead.maxX, printhead.y);
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
		 
		private function printCharacter(hardwareText:HardwareText, printhead:Printhead):void 
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
				
				glyphInstance.vertexDistance = printhead.textFormat.vertexDistance;
				glyphInstance.textColor = printhead.textFormat.textColor;
				
				currentCharacter.addChild(glyphInstance);
			}
			
			currentCharacter.scaleX = currentCharacter.scaleY = printhead.textFormat.scale; 
			currentCharacter.shearX = printhead.textFormat.shearX; 
			currentCharacter.shearY = printhead.textFormat.shearY; 
			 
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
				if (hardwareText.fixedWidth && printhead.lineX + printhead.wordX > hardwareText.untransformedWidth) 
				{ 
					// implicit line break 
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
			if (hardwareText.numChildren > 0) 
			{ 
				printhead.y += printhead.currentLine.descender; 
			} 
			printhead.y += -printhead.currentLine.ascender 
			printhead.currentLine.y = printhead.y;
			
			if (printhead.lineX > printhead.maxX)
			{
				printhead.maxX = printhead.lineX;
			}
			 
			switch (printhead.textFormat.textAlign) 
			{ 
				case TextAlign.LEFT:  
					printhead.currentLine.x = 0; 
					break; 
					 
				case TextAlign.CENTER:  
					printhead.currentLine.x = (hardwareText.textWidth - printhead.lineX) / 2; 
					break; 
					 
				case TextAlign.RIGHT:  
					printhead.currentLine.x = hardwareText.textWidth - printhead.lineX; 
					break; 
			} 
			 
			hardwareText.addChild(printhead.currentLine); 
			 
			printhead.lineX = 0; 
			 
			printhead.currentLine = new HardwareLine(); 
		} 
	} 
} 
