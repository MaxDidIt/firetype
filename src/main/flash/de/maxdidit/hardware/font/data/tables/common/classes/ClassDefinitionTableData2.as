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
 
package de.maxdidit.hardware.font.data.tables.common.classes 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ClassDefinitionTableData2 implements IClassDefinitionTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _classFormat:uint;
		private var _classRangeCount:uint;
		
		private var _classRangeRecords:Vector.<ClassRangeRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ClassDefinitionTableData2() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// classFormat
		
		public function get classFormat():uint 
		{
			return _classFormat;
		}
		
		public function set classFormat(value:uint):void 
		{
			// TODO: If this is set to anything else than 2, something's wrong
			_classFormat = value;
		}
		
		// classRangeCount
		
		public function get classRangeCount():uint 
		{
			return _classRangeCount;
		}
		
		public function set classRangeCount(value:uint):void 
		{
			_classRangeCount = value;
		}
		
		// classRangeRecords
		
		public function get classRangeRecords():Vector.<ClassRangeRecord> 
		{
			return _classRangeRecords;
		}
		
		public function set classRangeRecords(value:Vector.<ClassRangeRecord>):void 
		{
			_classRangeRecords = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.classes.IClassDefinitionTable */
		
		public function getGlyphClassByID(glyphIndex:uint):uint 
		{			
			var min:int = 0;
			var max:int = _classRangeCount - 1;
			
			while (max >= min)
			{
				var mid:int = (min + max) >> 1;
				
				var record:ClassRangeRecord = _classRangeRecords[mid];
				
				if (glyphIndex < record.start)
				{
					max = mid - 1;
				}
				else if (glyphIndex > record.end)
				{
					min = mid + 1;
				}
				else
				{
					return record.classValue;
				}
			}
			
			return 0;
		}
	}

}