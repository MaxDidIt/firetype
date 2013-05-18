package de.maxdidit.hardware.font.data.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairAdjustmentPositioningSubtable1 implements ILookupSubtable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _valueFormatData1:uint;
		private var _valueFormat1:ValueFormat;
		
		private var _valueFormatData2:uint;
		private var _valueFormat2:ValueFormat;
		
		private var _pairSetCount:uint;
		private var _pairSetOffset:Vector.<uint>;
		private var _pairSets:Vector.<PairSet>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairAdjustmentPositioningSubtable1() 
		{
			
		}
		
		///////////////////////
		// Member Propoerties
		///////////////////////
		
		public function get coverageOffset():uint 
		{
			return _coverageOffset;
		}
		
		public function set coverageOffset(value:uint):void 
		{
			_coverageOffset = value;
		}
		
		public function get valueFormatData1():uint 
		{
			return _valueFormatData1;
		}
		
		public function set valueFormatData1(value:uint):void 
		{
			_valueFormatData1 = value;
		}
		
		public function get valueFormatData2():uint 
		{
			return _valueFormatData2;
		}
		
		public function set valueFormatData2(value:uint):void 
		{
			_valueFormatData2 = value;
		}
		
		public function get pairSetCount():uint 
		{
			return _pairSetCount;
		}
		
		public function set pairSetCount(value:uint):void 
		{
			_pairSetCount = value;
		}
		
		public function get valueFormat1():ValueFormat 
		{
			return _valueFormat1;
		}
		
		public function set valueFormat1(value:ValueFormat):void 
		{
			_valueFormat1 = value;
		}
		
		public function get valueFormat2():ValueFormat 
		{
			return _valueFormat2;
		}
		
		public function set valueFormat2(value:ValueFormat):void 
		{
			_valueFormat2 = value;
		}
		
		public function get pairSets():Vector.<PairSet> 
		{
			return _pairSets;
		}
		
		public function set pairSets(value:Vector.<PairSet>):void 
		{
			_pairSets = value;
		}
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
		public function get pairSetOffset():Vector.<uint> 
		{
			return _pairSetOffset;
		}
		
		public function set pairSetOffset(value:Vector.<uint>):void 
		{
			_pairSetOffset = value;
		}
		
	}

}