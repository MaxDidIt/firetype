package de.maxdidit.hardware.font.data.tables.common.features 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FeatureListTableData
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _featureCount:uint;
		private var _featureRecords:Vector.<FeatureRecord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FeatureListTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// featureCount
		
		public function get featureCount():uint 
		{
			return _featureCount;
		}
		
		public function set featureCount(value:uint):void 
		{
			_featureCount = value;
		}
		
		// featureRecords
		
		public function get featureRecords():Vector.<FeatureRecord> 
		{
			return _featureRecords;
		}
		
		public function set featureRecords(value:Vector.<FeatureRecord>):void 
		{
			_featureRecords = value;
		}
		
	}

}