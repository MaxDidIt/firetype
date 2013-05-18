package de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class EntryExitRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _entryAnchorOffset:uint;
		private var _entryAnchor:AnchorTable;
		
		private var _exitAnchorOffset:uint;
		private var _exitAnchor:AnchorTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function EntryExitRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get entryAnchorOffset():uint 
		{
			return _entryAnchorOffset;
		}
		
		public function set entryAnchorOffset(value:uint):void 
		{
			_entryAnchorOffset = value;
		}
		
		public function get entryAnchor():AnchorTable 
		{
			return _entryAnchor;
		}
		
		public function set entryAnchor(value:AnchorTable):void 
		{
			_entryAnchor = value;
		}
		
		public function get exitAnchorOffset():uint 
		{
			return _exitAnchorOffset;
		}
		
		public function set exitAnchorOffset(value:uint):void 
		{
			_exitAnchorOffset = value;
		}
		
		public function get exitAnchor():AnchorTable 
		{
			return _exitAnchor;
		}
		
		public function set exitAnchor(value:AnchorTable):void 
		{
			_exitAnchor = value;
		}
		
	}

}