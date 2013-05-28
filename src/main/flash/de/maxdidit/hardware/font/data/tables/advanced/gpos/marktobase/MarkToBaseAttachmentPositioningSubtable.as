package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.text.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToBaseAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _markCoverageOffset:uint;
		private var _markCoverage:ICoverageTable;
		
		private var _baseCoverageOffset:uint;
		private var _baseCoverage:ICoverageTable;
		
		private var _classCount:uint;
		
		private var _markArrayOffset:uint;
		private var _markArray:MarkArray;
		
		private var _baseArrayOffset:uint;
		private var _baseArray:BaseArray;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToBaseAttachmentPositioningSubtable() 
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
		
		public function get baseCoverageOffset():uint 
		{
			return _baseCoverageOffset;
		}
		
		public function set baseCoverageOffset(value:uint):void 
		{
			_baseCoverageOffset = value;
		}
		
		public function get baseCoverage():ICoverageTable 
		{
			return _baseCoverage;
		}
		
		public function set baseCoverage(value:ICoverageTable):void 
		{
			_baseCoverage = value;
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
		
		public function get baseArrayOffset():uint 
		{
			return _baseArrayOffset;
		}
		
		public function set baseArrayOffset(value:uint):void 
		{
			_baseArrayOffset = value;
		}
		
		public function get baseArray():BaseArray 
		{
			return _baseArray;
		}
		
		public function set baseArray(value:BaseArray):void 
		{
			_baseArray = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void
		{
			var previousCharacter:HardwareCharacterInstanceListElement = characterInstances.currentElement.previous as HardwareCharacterInstanceListElement;
			if (!previousCharacter)
			{
				return;
			}
			
			var currentCharacter:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			var markCoverageIndex:int = _markCoverage.getCoverageIndex(currentCharacter.hardwareCharacterInstance.glyphID);
			if (markCoverageIndex == -1)
			{
				return;
			}
			
			var baseCoverageIndex:uint = _baseCoverage.getCoverageIndex(previousCharacter.hardwareCharacterInstance.glyphID);
			if (baseCoverageIndex == -1)
			{
				return;
			}
			
			var markRecord:MarkRecord = _markArray.markRecords[markCoverageIndex];
			var markAnchor:AnchorTable = markRecord.markAnchor;
			
			var baseRecord:BaseRecord = _baseArray.baseRecords[baseCoverageIndex];
			var baseAnchor:AnchorTable = baseRecord.baseAnchors[markRecord.markClass];
			
			var xOffset:int = markAnchor.xCoordinate - baseAnchor.xCoordinate;
			var yOffset:int = markAnchor.yCoordinate - baseAnchor.yCoordinate;
			
			currentCharacter.hardwareCharacterInstance.x = previousCharacter.hardwareCharacterInstance.x + xOffset;
			currentCharacter.hardwareCharacterInstance.y = previousCharacter.hardwareCharacterInstance.y + yOffset;
		}
		
	}

}