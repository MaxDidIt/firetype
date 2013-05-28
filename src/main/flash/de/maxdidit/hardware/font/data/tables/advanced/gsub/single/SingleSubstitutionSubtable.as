package de.maxdidit.hardware.font.data.tables.advanced.gsub.single 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleSubstitutionSubtable implements ILookupSubtable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _deltaGlyphID:uint;
		
		private var _substituteGlyphCount:uint;
		private var _substituteGlyphIDs:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
	
		public function SingleSubstitutionSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get coverageOffset():uint 
		{
			return _coverageOffset;
		}
		
		public function set coverageOffset(value:uint):void 
		{
			_coverageOffset = value;
		}
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
		public function get deltaGlyphID():uint 
		{
			return _deltaGlyphID;
		}
		
		public function set deltaGlyphID(value:uint):void 
		{
			_deltaGlyphID = value;
		}
		
		public function get substituteGlyphCount():uint 
		{
			return _substituteGlyphCount;
		}
		
		public function set substituteGlyphCount(value:uint):void 
		{
			_substituteGlyphCount = value;
		}
		
		public function get substituteGlyphIDs():Vector.<uint>
		{
			return _substituteGlyphIDs;
		}
		
		public function set substituteGlyphIDs(value:Vector.<uint>):void 
		{
			_substituteGlyphIDs = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		{
			var currentElement:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			
			var glyphIndex:uint = currentElement.hardwareCharacterInstance.glyphID;
			var coverageIndex:int = _coverage.getCoverageIndex(glyphIndex);
			if (coverageIndex == -1)
			{
				// no substitution performed
				return;
			}
			
			var newGlyphIndex:uint;
			if (substituteGlyphIDs)
			{
				newGlyphIndex = substituteGlyphIDs[coverageIndex];
			}
			else
			{
				newGlyphIndex = glyphIndex;
			}
			
			newGlyphIndex += _deltaGlyphID;
			currentElement.hardwareCharacterInstance.glyphID = newGlyphIndex;
		}
		
	}

}