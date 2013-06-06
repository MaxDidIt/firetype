package de.maxdidit.hardware.font.data.tables.advanced.gsub.single 
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
	public class SingleSubstitutionSubtable implements ILookupSubtable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _deltaGlyphID:uint;
		
		private var _substituteGlyphCount:uint;
		private var _substituteGlyphIDs:Vector.<uint>;
		private var _substituteGlyphs:Vector.<Glyph>;
		
		private var _parent:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
	
		public function SingleSubstitutionSubtable() 
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
		
		public function get deltaGlyphID():uint 
		{
			return _deltaGlyphID;
		}
		
		public function set deltaGlyphID(value:uint):void 
		{
			_deltaGlyphID = value;
		}
		
		public function get substituteGlyphCount():uint 
		{
			return _substituteGlyphCount;
		}
		
		public function set substituteGlyphCount(value:uint):void 
		{
			_substituteGlyphCount = value;
		}
		
		public function get substituteGlyphIDs():Vector.<uint>
		{
			return _substituteGlyphIDs;
		}
		
		public function set substituteGlyphIDs(value:Vector.<uint>):void 
		{
			_substituteGlyphIDs = value;
		}
		
		public function get substituteGlyphs():Vector.<Glyph> 
		{
			return _substituteGlyphs;
		}
		
		public function set substituteGlyphs(value:Vector.<Glyph>):void 
		{
			_substituteGlyphs = value;
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
			//var currentElement:HardwareCharacterInstanceListElement = characterInstances.currentElement as HardwareCharacterInstanceListElement;
			//
			//var glyphIndex:uint = currentElement.hardwareCharacterInstance.glyphID;
			//var coverageIndex:int = _coverage.getCoverageIndex(glyphIndex);
			//if (coverageIndex == -1)
			//{
				// no substitution performed
				//return;
			//}
			//
			//var newGlyphIndex:uint;
			//if (substituteGlyphIDs)
			//{
				//newGlyphIndex = substituteGlyphIDs[coverageIndex];
			//}
			//else
			//{
				//newGlyphIndex = glyphIndex;
			//}
			//
			//newGlyphIndex += _deltaGlyphID;
			//currentElement.hardwareCharacterInstance.glyphID = newGlyphIndex;
		//}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:int, font:HardwareFont):IGlyphLookup
		{
			var actualCoverageIndex:int = coverageIndex;
			if (coverageIndex == -1)
			{
				actualCoverageIndex = _coverage.getCoverageIndex(glyphIndex);
			}
			
			var newGlyphIndex:uint;
			if (substituteGlyphIDs)
			{
				newGlyphIndex = substituteGlyphIDs[actualCoverageIndex];
			}
			else
			{
				newGlyphIndex = glyphIndex;
			}
			
			newGlyphIndex += _deltaGlyphID;
			
			var substitutionGlyph:Glyph = font.retrieveGlyph(newGlyphIndex);
			
			var result:SingleSubstitutionLookup = new SingleSubstitutionLookup();
			result.substitutionGlyph = substitutionGlyph;
			
			return result;
		}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			const l:uint = _substituteGlyphCount;
			var substitutionGlyphs:Vector.<Glyph> = new Vector.<Glyph>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var glyph:Glyph = font.retrieveGlyph(_substituteGlyphIDs[i]);
				substitutionGlyphs[i] = glyph;
			}
			
			_substituteGlyphs = substitutionGlyphs;
			
			_coverage.iterateOverCoveredIndices(assignGlyphLookup, font);
		}
		
		private function assignGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):void 
		{
			var targetGlyph:Glyph = font.retrieveGlyph(glyphIndex);
			targetGlyph.addGlyphLookup(TableNames.GLYPH_SUBSTITUTION_DATA, _parent.lookupIndex, retrieveGlyphLookup(glyphIndex, coverageIndex, font));
		}
	}

}