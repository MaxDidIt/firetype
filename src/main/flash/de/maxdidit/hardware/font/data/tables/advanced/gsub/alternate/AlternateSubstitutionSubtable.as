package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
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
		
		private var _parent:LookupTable;
		
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
			
			var alternateSet:AlternateSetTable = _alternateSets[actualCoverageIndex];
			
			var result:AlternateSubstitutionLookup = new AlternateSubstitutionLookup();
			result.alternateSet = alternateSet;
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			const l:uint = _alternateSetCount;
			for (var i:uint = 0; i < l; i++)
			{
				var alternateSet:AlternateSetTable = _alternateSets[i];
				
				var gl:uint = alternateSet.glyphCount;
				var alternateGlyphs:Vector.<Glyph> = new Vector.<Glyph>(gl);
				for (var g:uint = 0; g < gl; g++)
				{
					alternateGlyphs[g] = font.retrieveGlyph(alternateSet.alternateGlyphIDs[g]);
				}
				alternateSet.alternateGlyphs = alternateGlyphs;
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