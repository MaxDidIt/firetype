package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToMarkAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _mark1CoverageOffset:uint;
		private var _mark1Coverage:ICoverageTable;
		
		private var _mark2CoverageOffset:uint;
		private var _mark2Coverage:ICoverageTable;
		
		private var _classCount:uint;
		
		private var _mark1ArrayOffset:uint;
		private var _mark1Array:MarkArray;
		
		private var _mark2ArrayOffset:uint;
		private var _mark2Array:Mark2Array;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToMarkAttachmentPositioningSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get mark1CoverageOffset():uint 
		{
			return _mark1CoverageOffset;
		}
		
		public function set mark1CoverageOffset(value:uint):void 
		{
			_mark1CoverageOffset = value;
		}
		
		public function get mark1Coverage():ICoverageTable 
		{
			return _mark1Coverage;
		}
		
		public function set mark1Coverage(value:ICoverageTable):void 
		{
			_mark1Coverage = value;
		}
		
		public function get mark2CoverageOffset():uint 
		{
			return _mark2CoverageOffset;
		}
		
		public function set mark2CoverageOffset(value:uint):void 
		{
			_mark2CoverageOffset = value;
		}
		
		public function get mark2Coverage():ICoverageTable 
		{
			return _mark2Coverage;
		}
		
		public function set mark2Coverage(value:ICoverageTable):void 
		{
			_mark2Coverage = value;
		}
		
		public function get classCount():uint 
		{
			return _classCount;
		}
		
		public function set classCount(value:uint):void 
		{
			_classCount = value;
		}
		
		public function get mark1ArrayOffset():uint 
		{
			return _mark1ArrayOffset;
		}
		
		public function set mark1ArrayOffset(value:uint):void 
		{
			_mark1ArrayOffset = value;
		}
		
		public function get mark1Array():MarkArray 
		{
			return _mark1Array;
		}
		
		public function set mark1Array(value:MarkArray):void 
		{
			_mark1Array = value;
		}
		
		public function get mark2ArrayOffset():uint 
		{
			return _mark2ArrayOffset;
		}
		
		public function set mark2ArrayOffset(value:uint):void 
		{
			_mark2ArrayOffset = value;
		}
		
		public function get mark2Array():Mark2Array 
		{
			return _mark2Array;
		}
		
		public function set mark2Array(value:Mark2Array):void 
		{
			_mark2Array = value;
		}
		
	}

}