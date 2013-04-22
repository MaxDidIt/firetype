package de.maxdidit.hardware.font.data.tables.common.coverage 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CoverageTableData1 implements ICoverageTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _format:uint;
		private var _glyphCount:uint;
		private var _glyphIDs:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CoverageTableData1() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// format
		
		public function get format():uint 
		{
			return _format;
		}
		
		public function set format(value:uint):void 
		{
			// TODO: If this is set to anything else than 1, something's wrong
			_format = value;
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
		
		// glyphIDs
		
		public function get glyphIDs():Vector.<uint> 
		{
			return _glyphIDs;
		}
		
		public function set glyphIDs(value:Vector.<uint>):void 
		{
			_glyphIDs = value;
		}
	}

}