package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ChainingContextSubstitutionTableFormat3 implements IChainingContextualSubstitutionTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _backtrackGlyphCount:uint;
		private var _backtrackCoverageOffsets:Vector.<uint>;
		private var _backtrackCoverages:Vector.<ICoverageTable>;
		
		private var _inputGlyphCount:uint;
		private var _inputCoverageOffsets:Vector.<uint>;
		private var _inputCoverages:Vector.<ICoverageTable>;
		
		private var _lookaheadGlyphCount:uint;
		private var _lookaheadCoverageOffsets:Vector.<uint>;
		private var _lookaheadCoverages:Vector.<ICoverageTable>;
		
		private var _substitutionCount:uint;
		private var _substitutionLookupRecords:Vector.<SubstitutionLookupRecord>;
		
		private var _lookup:ChainingContextSubstitutionLookupFormat3;
		
		private var _parent:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ChainingContextSubstitutionTableFormat3() 
		{
			_lookup = new ChainingContextSubstitutionLookupFormat3();
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
		
		public function get backtrackCoverageOffsets():Vector.<uint> 
		{
			return _backtrackCoverageOffsets;
		}
		
		public function set backtrackCoverageOffsets(value:Vector.<uint>):void 
		{
			_backtrackCoverageOffsets = value;
		}
		
		public function get backtrackCoverages():Vector.<ICoverageTable> 
		{
			return _backtrackCoverages;
		}
		
		public function set backtrackCoverages(value:Vector.<ICoverageTable>):void 
		{
			_backtrackCoverages = value;
			_lookup.backtackCoverages = _backtrackCoverages;
		}
		
		public function get inputGlyphCount():uint 
		{
			return _inputGlyphCount;
		}
		
		public function set inputGlyphCount(value:uint):void 
		{
			_inputGlyphCount = value;
		}
		
		public function get inputCoverageOffsets():Vector.<uint> 
		{
			return _inputCoverageOffsets;
		}
		
		public function set inputCoverageOffsets(value:Vector.<uint>):void 
		{
			_inputCoverageOffsets = value;
		}
		
		public function get inputCoverages():Vector.<ICoverageTable> 
		{
			return _inputCoverages;
		}
		
		public function set inputCoverages(value:Vector.<ICoverageTable>):void 
		{
			_inputCoverages = value;
			_lookup.inputCoverages = _inputCoverages;
		}
		
		public function get lookaheadGlyphCount():uint 
		{
			return _lookaheadGlyphCount;
		}
		
		public function set lookaheadGlyphCount(value:uint):void 
		{
			_lookaheadGlyphCount = value;
		}
		
		public function get lookaheadCoverageOffsets():Vector.<uint> 
		{
			return _lookaheadCoverageOffsets;
		}
		
		public function set lookaheadCoverageOffsets(value:Vector.<uint>):void 
		{
			_lookaheadCoverageOffsets = value;
		}
		
		public function get lookaheadCoverages():Vector.<ICoverageTable> 
		{
			return _lookaheadCoverages;
		}
		
		public function set lookaheadCoverages(value:Vector.<ICoverageTable>):void 
		{
			_lookaheadCoverages = value;
			_lookup.lookaheadCoverages = _lookaheadCoverages;
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
			_lookup.substitutionLookupRecords = _substitutionLookupRecords;
		}
		
		public function get parent():LookupTable 
		{
			return _parent;
		}
		
		public function set parent(value:LookupTable):void 
		{
			_parent = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		//public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		//{
			//if (!matchBackTrackGlyphs(characterInstances))
			//{
				//return;
			//}
			//
			//if (!matchLookAheadGlyphs(characterInstances))
			//{
				//return;
			//}
			//
			//if (!matchInputGlyphs(characterInstances))
			//{
				//return;
			//}
			//
			// perform lookups for input glyphs
			//for (var i:uint = 0; i < _substitutionCount; i++)
			//{
				//var record:SubstitutionLookupRecord = _substitutionLookupRecords[i];
				//var index:uint = record.lookupListIndex;
				//
				//var lookupTable:LookupTable = parent.lookupListTable.lookupTables[index];
				//lookupTable.performLookup(characterInstances, parent);
				//
				// goto next element, unless this is the last substitution
				//if (i < _substitutionCount - 1)
				//{
					//characterInstances.gotoNextElement();
				//}
			//}
		//}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup 
		{
			var actualCoverageIndex:int = coverageIndex;
			if (coverageIndex == -1)
			{
				actualCoverageIndex = _inputCoverages[0].getCoverageIndex(glyphIndex);
			}
			
			var substitutionLookups:Vector.<IGlyphLookup> = new Vector.<IGlyphLookup>();
			
			const l:uint = _lookup.substitutionLookupRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var record:SubstitutionLookupRecord = _lookup.substitutionLookupRecords[i];
				record.lookupTable.addGlyphLookups(glyphIndex, -1, substitutionLookups, font);
			}
			
			var result:ChainingContextSubstitutionLookupFormat3 = new ChainingContextSubstitutionLookupFormat3()
			result.backtackCoverages = _backtrackCoverages;
			result.lookaheadCoverages = _lookaheadCoverages;
			result.inputCoverages = _inputCoverages;
			result.substitutionLookupRecords = _substitutionLookupRecords;
			
			result.substitutionLookups = substitutionLookups;
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			const l:uint = _substitutionCount;
			for (var i:uint = 0; i < l; i++)
			{
				var record:SubstitutionLookupRecord = _substitutionLookupRecords[i];
				
				record.lookupTable = parent.lookupListTable.lookupTables[record.lookupListIndex];
			}
			
			_inputCoverages[0].iterateOverCoveredIndices(assignGlyphLookup, font);
		}
		
		//private function matchInputGlyphs(characterInstances:LinkedList):Boolean 
		//{
			//var inputGlyph:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			//for (var i:uint = 0; i < _inputGlyphCount; i++)
			//{
				//if (!inputGlyph)
				//{
					//return false;
				//}
				//
				//var coverage:ICoverageTable = _inputCoverages[i];
				//var coverageIndex:int = coverage.getCoverageIndex(inputGlyph.hardwareCharacterInstance.glyphID);
				//
				//if (coverageIndex == -1)
				//{
					//return false;
				//}
				//
				//inputGlyph = inputGlyph.next as HardwareCharacterInstanceListElement;
			//}
			//
			//return true;
		//}
		//
		//private function matchLookAheadGlyphs(characterInstances:LinkedList):Boolean 
		//{
			// skip ahead to last glyph in input sequence
			//var lastInputGlyph:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			//for (var i:uint = 1; i < _inputGlyphCount; i++)
			//{
				//lastInputGlyph = lastInputGlyph.next as HardwareCharacterInstanceListElement;
				//if (!lastInputGlyph)
				//{
					//return false;
				//}
			//}
			//
			//var lookaheadGlyph:HardwareCharacterInstanceListElement = lastInputGlyph; 
			//
			//for (i = 0; i < _lookaheadGlyphCount; i++)
			//{
				//lookaheadGlyph = lookaheadGlyph.next as HardwareCharacterInstanceListElement;
				//if (!lookaheadGlyph)
				//{
					//return false;
				//}
				//
				//var coverage:ICoverageTable = _lookaheadCoverages[i];
				//var coverageIndex:int = coverage.getCoverageIndex(lookaheadGlyph.hardwareCharacterInstance.glyphID);
				//
				//if (coverageIndex == -1)
				//{
					//return false;
				//}
			//}
			//
			//return true;
		//}
		//
		//private function matchBackTrackGlyphs(characterInstances:LinkedList):Boolean
		//{
			//var firstInputGlyph:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			//var backtrackGlyph:HardwareCharacterInstanceListElement = firstInputGlyph;
			//
			//const l:uint = _backtrackGlyphCount;
			//for (var i:uint = 0; i < l; i++)
			//{
				//backtrackGlyph = backtrackGlyph.previous as HardwareCharacterInstanceListElement;
				//if (!backtrackGlyph)
				//{
					//return false;
				//}
				//
				//var coverage:ICoverageTable = _backtrackCoverages[i];
				//var coverageIndex:int = coverage.getCoverageIndex(backtrackGlyph.hardwareCharacterInstance.glyphID);
				//
				//if (coverageIndex == -1)
				//{
					//return false;
				//}
			//}
			//
			//return true;
		//}
		
		private function assignGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):void 
		{
			var targetGlyph:Glyph = font.retrieveGlyph(glyphIndex);
			targetGlyph.addGlyphLookup(TableNames.GLYPH_SUBSTITUTION_DATA, _parent.lookupIndex, retrieveGlyphLookup(glyphIndex, coverageIndex, font));
		}
	}

}