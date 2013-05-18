package de.maxdidit.hardware.font.data.tables.advanced.gpos.shared 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MarkRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _markClass:uint;
		
		private var _markAnchorOffset:uint;
		private var _markAnchor:AnchorTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MarkRecord() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get markClass():uint 
		{
			return _markClass;
		}
		
		public function set markClass(value:uint):void 
		{
			_markClass = value;
		}
		
		public function get markAnchorOffset():uint 
		{
			return _markAnchorOffset;
		}
		
		public function set markAnchorOffset(value:uint):void 
		{
			_markAnchorOffset = value;
		}
		
		public function get markAnchor():AnchorTable 
		{
			return _markAnchor;
		}
		
		public function set markAnchor(value:AnchorTable):void 
		{
			_markAnchor = value;
		}
		
	}

}