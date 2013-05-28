package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.MarkArray;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkToLigatureAttachmentPositioningSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _markCoverageOffset:uint;
		private var _markCoverage:ICoverageTable;
		
		private var _ligatureCoverageOffset:uint;
		private var _ligatureCoverage:ICoverageTable;
		
		private var _classCount:uint;
		
		private var _markArrayOffset:uint;
		private var _markArray:MarkArray;
		
		private var _ligatureArrayOffset:uint;
		private var _ligatureArray:LigatureArray;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkToLigatureAttachmentPositioningSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get markCoverageOffset():uint 
		{
			return _markCoverageOffset;
		}
		
		public function set markCoverageOffset(value:uint):void 
		{
			_markCoverageOffset = value;
		}
		
		public function get markCoverage():ICoverageTable 
		{
			return _markCoverage;
		}
		
		public function set markCoverage(value:ICoverageTable):void 
		{
			_markCoverage = value;
		}
		
		public function get ligatureCoverageOffset():uint 
		{
			return _ligatureCoverageOffset;
		}
		
		public function set ligatureCoverageOffset(value:uint):void 
		{
			_ligatureCoverageOffset = value;
		}
		
		public function get ligatureCoverage():ICoverageTable 
		{
			return _ligatureCoverage;
		}
		
		public function set ligatureCoverage(value:ICoverageTable):void 
		{
			_ligatureCoverage = value;
		}
		
		public function get classCount():uint 
		{
			return _classCount;
		}
		
		public function set classCount(value:uint):void 
		{
			_classCount = value;
		}
		
		public function get markArrayOffset():uint 
		{
			return _markArrayOffset;
		}
		
		public function set markArrayOffset(value:uint):void 
		{
			_markArrayOffset = value;
		}
		
		public function get markArray():MarkArray 
		{
			return _markArray;
		}
		
		public function set markArray(value:MarkArray):void 
		{
			_markArray = value;
		}
		
		public function get ligatureArrayOffset():uint 
		{
			return _ligatureArrayOffset;
		}
		
		public function set ligatureArrayOffset(value:uint):void 
		{
			_ligatureArrayOffset = value;
		}
		
		public function get ligatureArray():LigatureArray 
		{
			return _ligatureArray;
		}
		
		public function set ligatureArray(value:LigatureArray):void 
		{
			_ligatureArray = value;
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