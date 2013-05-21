package de.maxdidit.hardware.font.data.tables.advanced.gsub.ligature 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ligatureGlyphID:uint;
		
		private var _componentCount:uint;
		private var _componentGlyphIDs:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ligatureGlyphID():uint 
		{
			return _ligatureGlyphID;
		}
		
		public function set ligatureGlyphID(value:uint):void 
		{
			_ligatureGlyphID = value;
		}
		
		public function get componentCount():uint 
		{
			return _componentCount;
		}
		
		public function set componentCount(value:uint):void 
		{
			_componentCount = value;
		}
		
		public function get componentGlyphIDs():Vector.<uint> 
		{
			return _componentGlyphIDs;
		}
		
		public function set componentGlyphIDs(value:Vector.<uint>):void 
		{
			_componentGlyphIDs = value;
		}
		
	}

}