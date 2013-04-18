package de.maxdidit.hardware.font.data.tables.classes 
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
		
	}

}