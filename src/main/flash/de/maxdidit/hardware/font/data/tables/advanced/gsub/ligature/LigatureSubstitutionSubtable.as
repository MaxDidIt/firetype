package de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureSubstitutionSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _ligatureSetCount:uint;
		private var _ligatureSetOffsets:Vector.<uint>;
		private var _ligatureSets:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureSubstitutionSubtable() 
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
		
		public function get ligatureSetCount():uint 
		{
			return _ligatureSetCount;
		}
		
		public function set ligatureSetCount(value:uint):void 
		{
			_ligatureSetCount = value;
		}
		
		public function get ligatureSetOffsets():Vector.<uint> 
		{
			return _ligatureSetOffsets;
		}
		
		public function set ligatureSetOffsets(value:Vector.<uint>):void 
		{
			_ligatureSetOffsets = value;
		}
		
		public function get ligatureSets():Vector.<uint> 
		{
			return _ligatureSets;
		}
		
		public function set ligatureSets(value:Vector.<uint>):void 
		{
			_ligatureSets = value;
		}
		
	}

}