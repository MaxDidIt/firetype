package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktobase 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class BaseRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////

		private var _baseAnchorOffsets:Vector.<uint>;
		private var _baseAnchors:Vector.<AnchorTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function BaseRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get baseAnchorOffsets():Vector.<uint> 
		{
			return _baseAnchorOffsets;
		}
		
		public function set baseAnchorOffsets(value:Vector.<uint>):void 
		{
			_baseAnchorOffsets = value;
		}
		
		public function get baseAnchors():Vector.<AnchorTable> 
		{
			return _baseAnchors;
		}
		
		public function set baseAnchors(value:Vector.<AnchorTable>):void 
		{
			_baseAnchors = value;
		}
		
	}

}