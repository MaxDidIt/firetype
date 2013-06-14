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
 
package de.maxdidit.hardware.font.data.tables.common.coverage 
{
	import de.maxdidit.hardware.font.HardwareFont;
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
		
		///////////////////////
		// Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable */
		
		public function getCoverageIndex(glyphIndex:uint):int 
		{
			var min:int = 0;
			var max:int = _glyphCount - 1;
			
			while (max >= min)
			{
				var mid:int = (min + max) >> 1;
				
				var textIndex:uint = _glyphIDs[mid];
				
				if (glyphIndex < textIndex)
				{
					max = mid - 1;
				}
				else if (glyphIndex > textIndex)
				{
					min = mid + 1;
				}
				else
				{
					return mid;
				}
			}
			
			return -1;
		}
		
		public function iterateOverCoveredIndices(callback:Function, font:HardwareFont):void 
		{
			const l:uint = _glyphCount;
			for (var coverageIndex:uint = 0; coverageIndex < l; coverageIndex++)
			{
				if (_glyphIDs[coverageIndex] != 0xFFFF)
				{
					callback.call(null, _glyphIDs[coverageIndex], coverageIndex, font);
				}
			}
		}
	}

}