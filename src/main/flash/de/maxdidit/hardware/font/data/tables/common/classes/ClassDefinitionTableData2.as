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