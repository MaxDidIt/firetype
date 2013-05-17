package de.maxdidit.hardware.font.data.tables.common.features 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FeatureRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _featureTag:String;
		private var _featureOffset:uint;
		private var _featureTable:FeatureTable;
	
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FeatureRecord() 
		{
			
		}
		
		///////////////////////
		// Member Propertes
		///////////////////////
		
		// featureTag
		
		public function get featureTag():String 
		{
			return _featureTag;
		}
		
		public function set featureTag(value:String):void 
		{
			_featureTag = value;
		}
		
		// featureOffset
		
		public function get featureOffset():uint 
		{
			return _featureOffset;
		}
		
		public function set featureOffset(value:uint):void 
		{
			_featureOffset = value;
		}
		
		// feature
		
		public function get featureTable():FeatureTable 
		{
			return _featureTable;
		}
		
		public function set featureTable(value:FeatureTable):void 
		{
			_featureTable = value;
		}
		
	}

}