package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate 
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
	public class AlternateSubstitutionSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _alternateSetCount:uint;
		private var _alternateSetOffsets:Vector.<uint>;
		private var _alternateSets:Vector.<AlternateSetTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AlternateSubstitutionSubtable() 
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
		
		public function get alternateSetCount():uint 
		{
			return _alternateSetCount;
		}
		
		public function set alternateSetCount(value:uint):void 
		{
			_alternateSetCount = value;
		}
		
		public function get alternateSetOffsets():Vector.<uint> 
		{
			return _alternateSetOffsets;
		}
		
		public function set alternateSetOffsets(value:Vector.<uint>):void 
		{
			_alternateSetOffsets = value;
		}
		
		public function get alternateSets():Vector.<AlternateSetTable> 
		{
			return _alternateSets;
		}
		
		public function set alternateSets(value:Vector.<AlternateSetTable>):void 
		{
			_alternateSets = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void
		{
			//throw new Error("Function not yet implemented");
		}
		
	}

}