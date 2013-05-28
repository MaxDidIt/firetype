package de.maxdidit.hardware.font.data.tables.advanced.gpos.single 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleAdjustmentPositioningSubtable implements ILookupSubtable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _coverageOffset:uint;
		private var _coverage:ICoverageTable;
		
		private var _valueFormatData:uint;
		private var _valueFormat:ValueFormat;
		
		private var _valueCount:uint;
		private var _values:Vector.<ValueRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SingleAdjustmentPositioningSubtable() 
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
		
		public function get valueFormatData():uint 
		{
			return _valueFormatData;
		}
		
		public function set valueFormatData(value:uint):void 
		{
			_valueFormatData = value;
		}
		
		public function get valueCount():uint 
		{
			return _valueCount;
		}
		
		public function set valueCount(value:uint):void 
		{
			_valueCount = value;
		}
		
		public function get values():Vector.<ValueRecord> 
		{
			return _values;
		}
		
		public function set values(value:Vector.<ValueRecord>):void 
		{
			_values = value;
		}
		
		public function get valueFormat():ValueFormat 
		{
			return _valueFormat;
		}
		
		public function set valueFormat(value:ValueFormat):void 
		{
			_valueFormat = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void
		{
			throw new Error("Function not yet implemented");
		}
		
	}

}