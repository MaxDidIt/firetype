package de.maxdidit.hardware.font.data.tables.advanced.gsub.alternate 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AlternateSetTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCount:uint;
		private var _alternateGlyphIDs:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AlternateSetTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get glyphCount():uint 
		{
			return _glyphCount;
		}
		
		public function set glyphCount(value:uint):void 
		{
			_glyphCount = value;
		}
		
		public function get alternateGlyphIDs():Vector.<uint> 
		{
			return _alternateGlyphIDs;
		}
		
		public function set alternateGlyphIDs(value:Vector.<uint>):void 
		{
			_alternateGlyphIDs = value;
		}
		
	}

}