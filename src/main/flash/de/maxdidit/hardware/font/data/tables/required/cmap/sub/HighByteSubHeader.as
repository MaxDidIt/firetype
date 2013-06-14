/* 
Copyright ©2013 Max Knoblich 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
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