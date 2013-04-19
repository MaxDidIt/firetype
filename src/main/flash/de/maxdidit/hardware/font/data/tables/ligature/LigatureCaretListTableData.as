package de.maxdidit.hardware.font.data.tables.ligature 
{
	import de.maxdidit.hardware.font.data.tables.coverage.ICoverageTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureCaretListTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _ligatureGlyphCount:uint;
		private var _ligatureGlyphTableOffsets:Vector.<uint>
		
		private var _ligatureGlyphTables:Vector.<LigatureGlyphTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureCaretListTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// coverageOffset
		
		public function get coverageOffset():uint 
		{
			return _coverageOffset;
		}
		
		public function set coverageOffset(value:uint):void 
		{
			_coverageOffset = value;
		}
		
		// ligatureGlyphCount
		
		public function get ligatureGlyphCount():uint 
		{
			return _ligatureGlyphCount;
		}
		
		public function set ligatureGlyphCount(value:uint):void 
		{
			_ligatureGlyphCount = value;
		}
		
		// ligatureGlyphTableOffsets
		
		public function get ligatureGlyphTableOffsets():Vector.<uint> 
		{
			return _ligatureGlyphTableOffsets;
		}
		
		public function set ligatureGlyphTableOffsets(value:Vector.<uint>):void 
		{
			_ligatureGlyphTableOffsets = value;
		}
		
		// ligatureGlyphTables
		
		public function get ligatureGlyphTables():Vector.<LigatureGlyphTable> 
		{
			return _ligatureGlyphTables;
		}
		
		public function set ligatureGlyphTables(value:Vector.<LigatureGlyphTable>):void 
		{
			_ligatureGlyphTables = value;
		}
		
		// coverage
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
	}

}