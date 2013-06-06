package de.maxdidit.hardware.font.data.tables.advanced.gsub.context 
{
	import adobe.utils.CustomActions;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ContextualSubstitutionTableFormat1 implements IContextualSubstitutionTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _subruleSetCount:uint;
		private var _subruleSetOffsets:Vector.<uint>;
		private var _subruleSetTables:Vector.<SubRuleSetTable>;
		
		private var _parent:LookupTable;
		
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
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		{
			throw new Error("Function not yet implemented");
		}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup
		{
			var actualCoverageIndex:int = coverageIndex;
			if (coverageIndex == -1)
			{
				actualCoverageIndex = _coverage.getCoverageIndex(glyphIndex);
			}
			
			var subruleSetTable:SubRuleSetTable = _subruleSetTables[actualCoverageIndex];
			
			var result:ContextualSubstitutionLookupFormat1 = new ContextualSubstitutionLookupFormat1();
			result.subruleSetTable = subruleSetTable;
			
			const l:uint = _subruleSetCount;
			var subruleSetsLookups:Vector.<Vector.<Vector.<IGlyphLookup>>> = new Vector.<Vector.<Vector.<IGlyphLookup>>>(l);
			for (var i:uint = 0; i < l; i++)
			{
				var subruleSet:SubRuleSetTable = _subruleSetTables[i];
				var sl:uint = subruleSet.subRuleCount;
				var subruleSetLookups:Vector.<Vector.<IGlyphLookup>> = new Vector.<Vector.<IGlyphLookup>>(sl)
				for (var s:uint = 0; s < sl; s++)
				{
					var subrule:SubRuleTable = subruleSet.subRules[s];
					var rl:uint = subrule.substitutionLookupCount;
					var subruleLookups:Vector.<IGlyphLookup> = new Vector.<IGlyphLookup>();
					for (var r:uint = 0; r < rl; r++)
					{
						subrule.substitutionLookupRecords[r].lookupTable.addGlyphLookups(glyphIndex, -1, subruleLookups, font);
					}
					subruleSetLookups[s] = subruleLookups;
				}
				subruleSetsLookups[i] = subruleSetLookups;
			}
			
			// TODO: assign subruleSetsLookups
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			const l:uint = _subruleSetCount;
			for (var i:uint = 0; i < l; i++)
			{
				var subruleSet:SubRuleSetTable = _subruleSetTables[i];
				var sl:uint = subruleSet.subRuleCount;
				for (var s:uint = 0; s < sl; s++)
				{
					var subrule:SubRuleTable = subruleSet.subRules[s];
					var rl:uint = subrule.substitutionLookupCount;
					for (var r:uint = 0; r < rl; r++)
					{
						var record:SubstitutionLookupRecord = subrule.substitutionLookupRecords[r];
						record.lookupTable = parent.lookupListTable.lookupTables[record.lookupListIndex];
					}
				}
			}
			
			_coverage.iterateOverCoveredIndices(assignGlyphLookup, font);
		}
		
		private function assignGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):void 
		{
			var targetGlyph:Glyph = font.retrieveGlyph(glyphIndex);
			targetGlyph.addGlyphLookup(TableNames.GLYPH_SUBSTITUTION_DATA, _parent.lookupIndex, retrieveGlyphLookup(glyphIndex, coverageIndex, font));
		}
		
	}

}