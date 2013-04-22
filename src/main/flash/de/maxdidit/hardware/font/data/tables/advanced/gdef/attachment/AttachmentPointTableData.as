package de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AttachmentPointTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _pointCount:uint;
		private var _pointIndices:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AttachmentPointTableData() 
		{
			
		}
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		// pointCount
		
		public function get pointCount():uint 
		{
			return _pointCount;
		}
		
		public function set pointCount(value:uint):void 
		{
			_pointCount = value;
		}
		
		// pointIndices
		
		public function get pointIndices():Vector.<uint> 
		{
			return _pointIndices;
		}
		
		public function set pointIndices(value:Vector.<uint>):void 
		{
			_pointIndices = value;
		}
		
	}

}