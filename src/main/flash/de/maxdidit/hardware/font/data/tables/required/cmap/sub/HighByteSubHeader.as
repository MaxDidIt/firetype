package de.maxdidit.hardware.font.data.tables.required.cmap.sub 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HighByteSubHeader 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _firstCode:uint;
		private var _entryCount:uint;
		private var _idDelta:int;
		private var _idRangeOffset:uint;
		
		private var _glyphIndexArray:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HighByteSubHeader() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// firstCode
		
		public function get firstCode():uint 
		{
			return _firstCode;
		}
		
		public function set firstCode(value:uint):void 
		{
			_firstCode = value;
		}
		
		// entryCount
		
		public function get entryCount():uint 
		{
			return _entryCount;
		}
		
		public function set entryCount(value:uint):void 
		{
			_entryCount = value;
		}
		
		// idDelta
		
		public function get idDelta():int 
		{
			return _idDelta;
		}
		
		public function set idDelta(value:int):void 
		{
			_idDelta = value;
		}
		
		// idRangeOffset
		
		public function get idRangeOffset():uint 
		{
			return _idRangeOffset;
		}
		
		public function set idRangeOffset(value:uint):void 
		{
			_idRangeOffset = value;
		}
		
		// glyphIndexArray
		
		public function get glyphIndexArray():Vector.<uint> 
		{
			return _glyphIndexArray;
		}
		
		public function set glyphIndexArray(value:Vector.<uint>):void 
		{
			_glyphIndexArray = value;
		}
		
	}

}