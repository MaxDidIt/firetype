package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark 
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
	public class MarkToMarkAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _mark1CoverageOffset:uint;
		private var _mark1Coverage:ICoverageTable;
		
		private var _mark2CoverageOffset:uint;
		private var _mark2Coverage:ICoverageTable;
		
		private var _classCount:uint;
		
		private var _mark1ArrayOffset:uint;
		private var _mark1Array:MarkArray;
		
		private var _mark2ArrayOffset:uint;
		private var _mark2Array:Mark2Array;
		
		private var _parent:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToMarkAttachmentPositioningSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get mark1CoverageOffset():uint 
		{
			return _mark1CoverageOffset;
		}
		
		public function set mark1CoverageOffset(value:uint):void 
		{
			_mark1CoverageOffset = value;
		}
		
		public function get mark1Coverage():ICoverageTable 
		{
			return _mark1Coverage;
		}
		
		public function set mark1Coverage(value:ICoverageTable):void 
		{
			_mark1Coverage = value;
		}
		
		public function get mark2CoverageOffset():uint 
		{
			return _mark2CoverageOffset;
		}
		
		public function set mark2CoverageOffset(value:uint):void 
		{
			_mark2CoverageOffset = value;
		}
		
		public function get mark2Coverage():ICoverageTable 
		{
			return _mark2Coverage;
		}
		
		public function set mark2Coverage(value:ICoverageTable):void 
		{
			_mark2Coverage = value;
		}
		
		public function get classCount():uint 
		{
			return _classCount;
		}
		
		public function set classCount(value:uint):void 
		{
			_classCount = value;
		}
		
		public function get mark1ArrayOffset():uint 
		{
			return _mark1ArrayOffset;
		}
		
		public function set mark1ArrayOffset(value:uint):void 
		{
			_mark1ArrayOffset = value;
		}
		
		public function get mark1Array():MarkArray 
		{
			return _mark1Array;
		}
		
		public function set mark1Array(value:MarkArray):void 
		{
			_mark1Array = value;
		}
		
		public function get mark2ArrayOffset():uint 
		{
			return _mark2ArrayOffset;
		}
		
		public function set mark2ArrayOffset(value:uint):void 
		{
			_mark2ArrayOffset = value;
		}
		
		public function get mark2Array():Mark2Array 
		{
			return _mark2Array;
		}
		
		public function set mark2Array(value:Mark2Array):void 
		{
			_mark2Array = value;
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
			//var previousCharacter:HardwareCharacterInstanceListElement = characterInstances.currentElement.previous as HardwareCharacterInstanceListElement;
			//if (!previousCharacter)
			//{
				//return;
			//}
			//
			//var currentCharacter:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			//var markCoverageIndex:int = _mark1Coverage.getCoverageIndex(currentCharacter.hardwareCharacterInstance.glyphID);
			//if (markCoverageIndex == -1)
			//{
				//return;
			//}
			//
			//var baseMarkCoverageIndex:int = _mark2Coverage.getCoverageIndex(previousCharacter.hardwareCharacterInstance.glyphID);
			//if (baseMarkCoverageIndex == -1)
			//{
				//return;
			//}
			//
			//var markRecord:MarkRecord = _mark1Array.markRecords[markCoverageIndex];
			//var markAnchor:AnchorTable = markRecord.markAnchor;
			//
			//var baseMarkRecord:Mark2Record = _mark2Array.mark2Records[baseMarkCoverageIndex];
			//var baseMarkAnchor:AnchorTable = baseMarkRecord.mark2Anchors[markRecord.markClass];
			//
			//var xOffset:int = markAnchor.xCoordinate - baseMarkAnchor.xCoordinate;
			//var yOffset:int = markAnchor.yCoordinate - baseMarkAnchor.yCoordinate;
			//
			//currentCharacter.hardwareCharacterInstance.x = previousCharacter.hardwareCharacterInstance.x + xOffset;
			//currentCharacter.hardwareCharacterInstance.y = previousCharacter.hardwareCharacterInstance.y + yOffset;
		//}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):IGlyphLookup 
		{
			var markRecord:MarkRecord = _mark1Array.markRecords[coverageIndex];
			
			var result:MarkToMarkAttachmentPositioningLookup = new MarkToMarkAttachmentPositioningLookup();
			result.mark2Coverage = _mark2Coverage;
			result.mark2Array = _mark2Array;
			result.markRecord = markRecord;
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			_mark1Coverage.iterateOverCoveredIndices(assignGlyphLookup, font);
		}
		
		private function assignGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):void 
		{
			var targetGlyph:Glyph = font.retrieveGlyph(glyphIndex);
			targetGlyph.addGlyphLookup(TableNames.GLYPH_POSITIONING_DATA, _parent.lookupIndex, retrieveGlyphLookup(glyphIndex, coverageIndex, font));
		}
	}

}