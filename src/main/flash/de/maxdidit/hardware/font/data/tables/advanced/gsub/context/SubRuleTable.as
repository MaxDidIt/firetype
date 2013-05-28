package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SubRuleTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCount:uint;
		private var _substitutionLookupCount:uint;
		
		private var _inputGlyphIDs:Vector.<uint>;
		private var _substitutionLookupRecords:Vector.<SubstitutionLookupRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SubRuleTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get glyphCount():uint 
		{
			return _glyphCount;
		}
		
		public function set glyphCount(value:uint):void 
		{
			_glyphCount = value;
		}
		
		public function get substitutionLookupCount():uint 
		{
			return _substitutionLookupCount;
		}
		
		public function set substitutionLookupCount(value:uint):void 
		{
			_substitutionLookupCount = value;
		}
		
		public function get inputGlyphIDs():Vector.<uint> 
		{
			return _inputGlyphIDs;
		}
		
		public function set inputGlyphIDs(value:Vector.<uint>):void 
		{
			_inputGlyphIDs = value;
		}
		
		public function get substitutionLookupRecords():Vector.<SubstitutionLookupRecord> 
		{
			return _substitutionLookupRecords;
		}
		
		public function set substitutionLookupRecords(value:Vector.<SubstitutionLookupRecord>):void 
		{
			_substitutionLookupRecords = value;
		}
		
	}

}