package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ContextualSubstitutionTableFormat1 implements ILookupSubtable, IContextualSubstitutionTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _subruleSetCount:uint;
		private var _subruleSetOffsets:Vector.<uint>;
		private var _subruleSetTables:Vector.<SubRuleSetTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ContextualSubstitutionTableFormat1() 
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
		
		public function get subruleSetCount():uint 
		{
			return _subruleSetCount;
		}
		
		public function set subruleSetCount(value:uint):void 
		{
			_subruleSetCount = value;
		}
		
		public function get subruleSetOffsets():Vector.<uint> 
		{
			return _subruleSetOffsets;
		}
		
		public function set subruleSetOffsets(value:Vector.<uint>):void 
		{
			_subruleSetOffsets = value;
		}
		
		public function get subruleSetTables():Vector.<SubRuleSetTable> 
		{
			return _subruleSetTables;
		}
		
		public function set subruleSetTables(value:Vector.<SubRuleSetTable>):void 
		{
			_subruleSetTables = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		{
			throw new Error("Function not yet implemented");
		}
		
	}

}