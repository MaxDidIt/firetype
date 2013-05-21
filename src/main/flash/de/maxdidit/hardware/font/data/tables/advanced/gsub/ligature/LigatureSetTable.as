package de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureSetTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ligatureCount:uint;
		private var _ligatureOffsets:Vector.<uint>;
		private var _ligatures:Vector.<LigatureTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureSetTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ligatureCount():uint 
		{
			return _ligatureCount;
		}
		
		public function set ligatureCount(value:uint):void 
		{
			_ligatureCount = value;
		}
		
		public function get ligatureOffsets():Vector.<uint> 
		{
			return _ligatureOffsets;
		}
		
		public function set ligatureOffsets(value:Vector.<uint>):void 
		{
			_ligatureOffsets = value;
		}
		
		public function get ligatures():Vector.<LigatureTable> 
		{
			return _ligatures;
		}
		
		public function set ligatures(value:Vector.<LigatureTable>):void 
		{
			_ligatures = value;
		}
		
	}

}