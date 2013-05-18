package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ComponentRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ligatureAnchorOffsets:Vector.<uint> ;
		private var _ligatureAnchors:Vector.<AnchorTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ComponentRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ligatureAnchorOffsets():Vector.<uint> 
		{
			return _ligatureAnchorOffsets;
		}
		
		public function set ligatureAnchorOffsets(value:Vector.<uint>):void 
		{
			_ligatureAnchorOffsets = value;
		}
		
		public function get ligatureAnchors():Vector.<AnchorTable>
		{
			return _ligatureAnchors;
		}
		
		public function set ligatureAnchors(value:Vector.<AnchorTable>):void 
		{
			_ligatureAnchors = value;
		}
		
	}

}