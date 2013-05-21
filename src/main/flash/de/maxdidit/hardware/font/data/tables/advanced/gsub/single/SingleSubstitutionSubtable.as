package de.maxdidit.hardware.font.data.tables.advanced.gsub.single 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
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
		
	}

}