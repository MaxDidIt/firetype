package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainingContextSubstitutionTableFormat1 implements IChainingContextualSubstitutionTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
	
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _chainSubRuleSetCount:uint;
		private var _chainSubRuleSetOffsets:Vector.<uint>;
		private var _chainSubRuleSets:Vector.<ChainSubRuleSet>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainingContextSubstitutionTableFormat1() 
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
		
		public function get chainSubRuleSetCount():uint 
		{
			return _chainSubRuleSetCount;
		}
		
		public function set chainSubRuleSetCount(value:uint):void 
		{
			_chainSubRuleSetCount = value;
		}
		
		public function get chainSubRuleSets():Vector.<ChainSubRuleSet> 
		{
			return _chainSubRuleSets;
		}
		
		public function set chainSubRuleSets(value:Vector.<ChainSubRuleSet>):void 
		{
			_chainSubRuleSets = value;
		}
		
		public function get chainSubRuleSetOffsets():Vector.<uint> 
		{
			return _chainSubRuleSetOffsets;
		}
		
		public function set chainSubRuleSetOffsets(value:Vector.<uint>):void 
		{
			_chainSubRuleSetOffsets = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.IChainingContextualSubstitutionTable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		{
			throw new Error("Function not yet implemented");
		}
		
	}

}