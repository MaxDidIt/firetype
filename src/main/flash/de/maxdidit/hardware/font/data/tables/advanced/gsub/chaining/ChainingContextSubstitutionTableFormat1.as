package de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining
{
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubRuleTable;
	import de.maxdidit.hardware.font.data.tables.advanced.gsub.context.SubstitutionLookupRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
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
		
		private var _parent:LookupTable;
		
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
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.advanced.gsub.chaining.IChainingContextualSubstitutionTable */
		
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
			
			var chainSubruleSetTable:ChainSubRuleSet = _chainSubRuleSets[actualCoverageIndex];
			
			var tableMap:Object = new Object();
			var tableList:Vector.<LookupTable> = new Vector.<LookupTable>();
			
			var result:ChainingContextSubstitutionLookupFormat1 = new ChainingContextSubstitutionLookupFormat1();
			result.chainSubruleSetTable = chainSubruleSetTable;
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void
		{
			const l:uint = _chainSubRuleSetCount;
			for (var i:uint = 0; i < l; i++)
			{
				var subruleSet:ChainSubRuleSet = _chainSubRuleSets[i];
				var sl:uint = subruleSet.chainSubRuleCount;
				for (var s:uint = 0; s < sl; s++)
				{
					var subrule:ChainSubRule = subruleSet.chainSubRules[s];
					var rl:uint = subrule.substitutionCount;
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