package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SubRuleSetTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _subRuleCount:uint;
		private var _subRuleOffsets:Vector.<uint>;
		private var _subRules:Vector.<SubRuleTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SubRuleSetTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get subRuleCount():uint 
		{
			return _subRuleCount;
		}
		
		public function set subRuleCount(value:uint):void 
		{
			_subRuleCount = value;
		}
		
		public function get subRuleOffsets():Vector.<uint> 
		{
			return _subRuleOffsets;
		}
		
		public function set subRuleOffsets(value:Vector.<uint>):void 
		{
			_subRuleOffsets = value;
		}
		
		public function get subRules():Vector.<SubRuleTable> 
		{
			return _subRules;
		}
		
		public function set subRules(value:Vector.<SubRuleTable>):void 
		{
			_subRules = value;
		}
		
	}

}