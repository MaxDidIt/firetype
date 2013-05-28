package de.maxdidit.hardware.font.data.tables.advanced.gpos.pair 
{
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class PairAdjustmentPositioningSubtable2 implements ILookupSubtable
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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function PairAdjustmentPositioningSubtable2() 
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
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(currentElement:HardwareCharacterInstanceListElement, characterInstances:LinkedList):void 
		{
			throw new Error("Function not yet implemented");
		}
		
	}

}