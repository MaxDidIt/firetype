package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.text.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairAdjustmentPositioningSubtable1 implements ILookupSubtable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _valueFormatData1:uint;
		private var _valueFormat1:ValueFormat;
		
		private var _valueFormatData2:uint;
		private var _valueFormat2:ValueFormat;
		
		private var _pairSetCount:uint;
		private var _pairSetOffset:Vector.<uint>;
		private var _pairSets:Vector.<PairSet>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairAdjustmentPositioningSubtable1() 
		{
			
		}
		
		///////////////////////
		// Member Propoerties
		///////////////////////
		
		public function get coverageOffset():uint 
		{
			return _coverageOffset;
		}
		
		public function set coverageOffset(value:uint):void 
		{
			_coverageOffset = value;
		}
		
		public function get valueFormatData1():uint 
		{
			return _valueFormatData1;
		}
		
		public function set valueFormatData1(value:uint):void 
		{
			_valueFormatData1 = value;
		}
		
		public function get valueFormatData2():uint 
		{
			return _valueFormatData2;
		}
		
		public function set valueFormatData2(value:uint):void 
		{
			_valueFormatData2 = value;
		}
		
		public function get pairSetCount():uint 
		{
			return _pairSetCount;
		}
		
		public function set pairSetCount(value:uint):void 
		{
			_pairSetCount = value;
		}
		
		public function get valueFormat1():ValueFormat
		{
			return _valueFormat1;
		}
		
		public function set valueFormat1(value:ValueFormat):void 
		{
			_valueFormat1 = value;
		}
		
		public function get valueFormat2():ValueFormat 
		{
			return _valueFormat2;
		}
		
		public function set valueFormat2(value:ValueFormat):void 
		{
			_valueFormat2 = value;
		}
		
		public function get pairSets():Vector.<PairSet> 
		{
			return _pairSets;
		}
		
		public function set pairSets(value:Vector.<PairSet>):void 
		{
			_pairSets = value;
		}
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
		public function get pairSetOffset():Vector.<uint> 
		{
			return _pairSetOffset;
		}
		
		public function set pairSetOffset(value:Vector.<uint>):void 
		{
			_pairSetOffset = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void
		{
			var currentCharacter:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
			var coverageIndex:int = coverage.getCoverageIndex(currentCharacter.glyphID);
			
			if (coverageIndex == -1)
			{
				return;
			}
			
			var nextElement:HardwareCharacterInstanceListElement = characterInstances.currentElement.next as HardwareCharacterInstanceListElement;
			if (!nextElement)
			{
				return;
			}
			var nextCharacter:HardwareCharacterInstance = nextElement.hardwareCharacterInstance;
			
			var pairSet:PairSet = _pairSets[coverageIndex];
			var pairValueRecord:PairValueRecord;
			var pairFound:Boolean = false;
			for (var i:uint = 0; i < pairSet.pairValueCount; i++)
			{
				pairValueRecord = pairSet.pairValueRecords[i];
				if (pairValueRecord.secondGlyphID == nextCharacter.glyphID)
				{
					pairFound = true;
					break;
				}
			}
			
			if (!pairFound)
			{
				return;
			}
			
			// apply positioning values
			var value1:ValueRecord = pairValueRecord.value1;
			var value2:ValueRecord = pairValueRecord.value2;
			
			currentCharacter.applyPositionAdjustmentValue(value1);
			nextCharacter.applyPositionAdjustmentValue(value2);
		}
	}

}