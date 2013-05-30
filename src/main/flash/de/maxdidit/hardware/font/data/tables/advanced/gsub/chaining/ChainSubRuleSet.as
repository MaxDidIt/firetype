package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainSubRuleSet 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _chainSubRuleCount:uint;
		private var _chainSubRuleOffsets:Vector.<uint>;
		private var _chainSubRules:Vector.<ChainSubRule>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainSubRuleSet() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get chainSubRuleCount():uint 
		{
			return _chainSubRuleCount;
		}
		
		public function set chainSubRuleCount(value:uint):void 
		{
			_chainSubRuleCount = value;
		}
		
		public function get chainSubRuleOffsets():Vector.<uint> 
		{
			return _chainSubRuleOffsets;
		}
		
		public function set chainSubRuleOffsets(value:Vector.<uint>):void 
		{
			_chainSubRuleOffsets = value;
		}
		
		public function get chainSubRules():Vector.<ChainSubRule> 
		{
			return _chainSubRules;
		}
		
		public function set chainSubRules(value:Vector.<ChainSubRule>):void 
		{
			_chainSubRules = value;
		}
		
	}

}