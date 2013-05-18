package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktomark 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Mark2Record 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _mark2AnchorOffsets:Vector.<uint>;
		private var _mark2Anchors:Vector.<AnchorTable>;

		///////////////////////
		// Constructor
		///////////////////////
		
		public function Mark2Record() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get mark2AnchorOffsets():Vector.<uint> 
		{
			return _mark2AnchorOffsets;
		}
		
		public function set mark2AnchorOffsets(value:Vector.<uint>):void 
		{
			_mark2AnchorOffsets = value;
		}
		
		public function get mark2Anchors():Vector.<AnchorTable> 
		{
			return _mark2Anchors;
		}
		
		public function set mark2Anchors(value:Vector.<AnchorTable>):void 
		{
			_mark2Anchors = value;
		}
		
	}

}