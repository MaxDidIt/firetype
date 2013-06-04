package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToLigatureAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _markCoverageOffset:uint;
		private var _markCoverage:ICoverageTable;
		
		private var _ligatureCoverageOffset:uint;
		private var _ligatureCoverage:ICoverageTable;
		
		private var _classCount:uint;
		
		private var _markArrayOffset:uint;
		private var _markArray:MarkArray;
		
		private var _ligatureArrayOffset:uint;
		private var _ligatureArray:LigatureArray;
		
		private var _parent:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToLigatureAttachmentPositioningSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get markCoverageOffset():uint 
		{
			return _markCoverageOffset;
		}
		
		public function set markCoverageOffset(value:uint):void 
		{
			_markCoverageOffset = value;
		}
		
		public function get markCoverage():ICoverageTable 
		{
			return _markCoverage;
		}
		
		public function set markCoverage(value:ICoverageTable):void 
		{
			_markCoverage = value;
		}
		
		public function get ligatureCoverageOffset():uint 
		{
			return _ligatureCoverageOffset;
		}
		
		public function set ligatureCoverageOffset(value:uint):void 
		{
			_ligatureCoverageOffset = value;
		}
		
		public function get ligatureCoverage():ICoverageTable 
		{
			return _ligatureCoverage;
		}
		
		public function set ligatureCoverage(value:ICoverageTable):void 
		{
			_ligatureCoverage = value;
		}
		
		public function get classCount():uint 
		{
			return _classCount;
		}
		
		public function set classCount(value:uint):void 
		{
			_classCount = value;
		}
		
		public function get markArrayOffset():uint 
		{
			return _markArrayOffset;
		}
		
		public function set markArrayOffset(value:uint):void 
		{
			_markArrayOffset = value;
		}
		
		public function get markArray():MarkArray 
		{
			return _markArray;
		}
		
		public function set markArray(value:MarkArray):void 
		{
			_markArray = value;
		}
		
		public function get ligatureArrayOffset():uint 
		{
			return _ligatureArrayOffset;
		}
		
		public function set ligatureArrayOffset(value:uint):void 
		{
			_ligatureArrayOffset = value;
		}
		
		public function get ligatureArray():LigatureArray 
		{
			return _ligatureArray;
		}
		
		public function set ligatureArray(value:LigatureArray):void 
		{
			_ligatureArray = value;
		}
		
		public function get parent():LookupTable 
		{
			return _parent;
		}
		
		public function set parent(value:LookupTable):void 
		{
			_parent = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		//public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void
		//{
			//var markInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
			//
			//var ligatureElement:HardwareCharacterInstanceListElement = characterInstances.currentElement.previous as HardwareCharacterInstanceListElement;
			//if (!ligatureElement)
			//{
				//return;
			//}
			//var ligatureInstance:HardwareCharacterInstance = ligatureElement.hardwareCharacterInstance;
			//
			//var markCoverageIndex:int = _markCoverage.getCoverageIndex(markInstance.glyphID);
			//if (markCoverageIndex == -1)
			//{
				//return;
			//}
			//
			//var ligatureCoverageIndex:int = _ligatureCoverage.getCoverageIndex(ligatureInstance.glyphID);
			//if (ligatureCoverageIndex == -1)
			//{
				//return;
			//}
			//
			//throw new Error("The performLookup function of MarkToLigatureAttachmentPositioningSubtable has not been fully implemented yet.");
			//
			//var markRecord:MarkRecord = _markArray.markRecords[markCoverageIndex];
			//var ligatureAttachment:LigatureAttachment = _ligatureArray.ligatureAttachments[ligatureCoverageIndex];
			//
			// TODO: I'm not fully clear on how to handle the multiple components of the ligature.
			// I'm also not sure what exactly the documentation means by "Aligning the attachment points combines the mark and ligature.".
			// Are the mark and the ligature only visually combined or is the mark a component of the ligature after this?.
			//var componentRecord:ComponentRecord = ligatureAttachment.componentRecords[0];
			//
			//var markAnchor:AnchorTable = markRecord.markAnchor;
			//var ligatureAnchor:AnchorTable = componentRecord.ligatureAnchors[markRecord.markClass];
			//
			//var xOffset:int = markAnchor.xCoordinate - baseMarkAnchor.xCoordinate;
			//var yOffset:int = markAnchor.yCoordinate - baseMarkAnchor.yCoordinate;
			//
			//currentCharacter.hardwareCharacterInstance.x = previousCharacter.hardwareCharacterInstance.x + xOffset;
			//currentCharacter.hardwareCharacterInstance.y = previousCharacter.hardwareCharacterInstance.y + yOffset;
		//}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):IGlyphLookup 
		{
			var markRecord:MarkRecord = _markArray.markRecords[coverageIndex];
			
			var result:MarkToLigatureAttachmentPositioningLookup = new MarkToLigatureAttachmentPositioningLookup();
			result.ligatureCoverage = _ligatureCoverage;
			result.ligatureArray = _ligatureArray;
			result.markRecord = markRecord;
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			_markCoverage.iterateOverCoveredIndices(assignGlyphLookup, font);
		}
		
		private function assignGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):void 
		{
			var targetGlyph:Glyph = font.retrieveGlyph(glyphIndex);
			targetGlyph.addGlyphLookup(TableNames.GLYPH_POSITIONING_DATA, _parent.lookupIndex, retrieveGlyphLookup(glyphIndex, coverageIndex, font));
		}
	}

}