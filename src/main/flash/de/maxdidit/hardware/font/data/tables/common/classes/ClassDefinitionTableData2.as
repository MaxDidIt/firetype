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
		
		public function getGlyphClassByID(glyphID:uint):uint 
		{
			for (var i:uint = 0; i < _classRangeCount; i++)
			{
				var record:ClassRangeRecord = _classRangeRecords[i];
				if (record.start >= glyphID && record.end <= glyphID)
				{
					return record.classValue;
				}
			}
			
			return 0;
		}
	}

}