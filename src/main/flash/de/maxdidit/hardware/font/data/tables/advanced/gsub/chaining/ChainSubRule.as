package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainSubRule 
	{
		///////////////////////
		// Member Fields
		///////////////////////
	
		private var _backtrackGlyphCount:uint;
		private var _backtrackGlyphIDs:Vector.<uint>;
		
		private var _inputGlyphCount:uint;
		private var _inputGlyphIDs:Vector.<uint>;
		
		private var _lookaheadGlyphCount:uint;
		private var _lookaheadGlyphIDs:Vector.<uint>;
		
		private var _substitutionCount:uint;
		private var _substitutionLookupRecords:Vector.<SubstitutionLookupRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainSubRule() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get backtrackGlyphCount():uint 
		{
			return _backtrackGlyphCount;
		}
		
		public function set backtrackGlyphCount(value:uint):void 
		{
			_backtrackGlyphCount = value;
		}
		
		public function get backtrackGlyphIDs():Vector.<uint> 
		{
			return _backtrackGlyphIDs;
		}
		
		public function set backtrackGlyphIDs(value:Vector.<uint>):void 
		{
			_backtrackGlyphIDs = value;
		}
		
		public function get inputGlyphCount():uint 
		{
			return _inputGlyphCount;
		}
		
		public function set inputGlyphCount(value:uint):void 
		{
			_inputGlyphCount = value;
		}
		
		public function get inputGlyphIDs():Vector.<uint> 
		{
			return _inputGlyphIDs;
		}
		
		public function set inputGlyphIDs(value:Vector.<uint>):void 
		{
			_inputGlyphIDs = value;
		}
		
		public function get lookaheadGlyphCount():uint 
		{
			return _lookaheadGlyphCount;
		}
		
		public function set lookaheadGlyphCount(value:uint):void 
		{
			_lookaheadGlyphCount = value;
		}
		
		public function get lookaheadGlyphIDs():Vector.<uint> 
		{
			return _lookaheadGlyphIDs;
		}
		
		public function set lookaheadGlyphIDs(value:Vector.<uint>):void 
		{
			_lookaheadGlyphIDs = value;
		}
		
		public function get substitutionCount():uint 
		{
			return _substitutionCount;
		}
		
		public function set substitutionCount(value:uint):void 
		{
			_substitutionCount = value;
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