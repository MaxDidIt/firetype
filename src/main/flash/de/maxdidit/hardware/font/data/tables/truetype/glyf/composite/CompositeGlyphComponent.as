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
 
package de.maxdidit.hardware.font.data.tables.truetype.glyf.composite 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CompositeGlyphComponent 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _flagData:uint;
		private var _flags:CompositeGlyphFlags;
		
		private var _glyphIndex:uint;
		
		private var _argument1:int;
		private var _argument2:int;
		
		// matrix:
		//
		// A B
		// C D
		//
		private var _mtxA:Number = 1;
		private var _mtxB:Number = 0;
		private var _mtxC:Number = 0;
		private var _mtxD:Number = 1;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CompositeGlyphComponent() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// flagData
		
		public function get flagData():uint 
		{
			return _flagData;
		}
		
		public function set flagData(value:uint):void 
		{
			_flagData = value;
		}
		
		// flags
		
		public function get flags():CompositeGlyphFlags
		{
			return _flags;
		}
		
		public function set flags(value:CompositeGlyphFlags):void 
		{
			_flags = value;
		}
		
		// glyphIndex
		
		public function get glyphIndex():uint 
		{
			return _glyphIndex;
		}
		
		public function set glyphIndex(value:uint):void 
		{
			_glyphIndex = value;
		}
		
		// argument1
		
		public function get argument1():int
		{
			return _argument1;
		}
		
		public function set argument1(value:int):void 
		{
			_argument1 = value;
		}
		
		// argument2
		
		public function get argument2():int
		{
			return _argument2;
		}
		
		public function set argument2(value:int):void 
		{
			_argument2 = value;
		}
		
		// matrix
		
		public function get mtxA():Number 
		{
			return _mtxA;
		}
		
		public function set mtxA(value:Number):void 
		{
			_mtxA = value;
		}
		
		public function get mtxB():Number 
		{
			return _mtxB;
		}
		
		public function set mtxB(value:Number):void 
		{
			_mtxB = value;
		}
		
		public function get mtxC():Number 
		{
			return _mtxC;
		}
		
		public function set mtxC(value:Number):void 
		{
			_mtxC = value;
		}
		
		public function get mtxD():Number 
		{
			return _mtxD;
		}
		
		public function set mtxD(value:Number):void 
		{
			_mtxD = value;
		}
		
	}

}