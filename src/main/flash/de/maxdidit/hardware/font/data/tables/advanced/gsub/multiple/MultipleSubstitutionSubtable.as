package de.maxdidit.hardware.font.data.tables.advanced.gsub.multiple 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MultipleSubstitutionSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _sequenceCount:uint;
		private var _sequenceOffsets:Vector.<uint>;
		private var _sequences:Vector.<SequenceTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MultipleSubstitutionSubtable() 
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
		
		public function get sequenceCount():uint 
		{
			return _sequenceCount;
		}
		
		public function set sequenceCount(value:uint):void 
		{
			_sequenceCount = value;
		}
		
		public function get sequenceOffsets():Vector.<uint> 
		{
			return _sequenceOffsets;
		}
		
		public function set sequenceOffsets(value:Vector.<uint>):void 
		{
			_sequenceOffsets = value;
		}
		
		public function get sequences():Vector.<SequenceTable> 
		{
			return _sequences;
		}
		
		public function set sequences(value:Vector.<SequenceTable>):void 
		{
			_sequences = value;
		}
		
	}

}