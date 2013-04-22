package de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AttachmentListTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCoverageOffset:uint;
		private var _glyphCount:uint;
		
		private var _coverage:ICoverageTable;
		
		private var _attachmentPointOffsets:Vector.<uint>;
		private var _attachmentPointTables:Vector.<AttachmentPointTableData>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AttachmentListTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// glyphCoverageOffset
		
		public function get glyphCoverageOffset():uint 
		{
			return _glyphCoverageOffset;
		}
		
		public function set glyphCoverageOffset(value:uint):void 
		{
			_glyphCoverageOffset = value;
		}
		
		// glyphCount
		
		public function get glyphCount():uint 
		{
			return _glyphCount;
		}
		
		public function set glyphCount(value:uint):void 
		{
			_glyphCount = value;
		}
		
		// attachmentPointOffsets
		
		public function get attachmentPointOffsets():Vector.<uint> 
		{
			return _attachmentPointOffsets;
		}
		
		public function set attachmentPointOffsets(value:Vector.<uint>):void 
		{
			_attachmentPointOffsets = value;
		}
		
		// attachmentPointTables
		
		public function get attachmentPointTables():Vector.<AttachmentPointTableData> 
		{
			return _attachmentPointTables;
		}
		
		public function set attachmentPointTables(value:Vector.<AttachmentPointTableData>):void 
		{
			_attachmentPointTables = value;
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