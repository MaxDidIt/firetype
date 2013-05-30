package de.maxdidit.hardware.font.data.tables.common.features 
{
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function retrieveFeatures(languageSystemTable:LanguageSystemTable, useAllFeatures:Boolean = false):Vector.<FeatureRecord>
		{
			var result:Vector.<FeatureRecord> = new Vector.<FeatureRecord>();
			
			if (!useAllFeatures)
			{
				if (languageSystemTable.requiredFeatureIndex != 0xFFFF)
				{
					result.push(_featureRecords[languageSystemTable.requiredFeatureIndex]);
				}
				
				return result;
			}
			
			const l:uint = languageSystemTable.featureIndices.length;
			result.length = l;
			
			for (var i:uint = 0; i < l; i++)
			{
				var index:uint = languageSystemTable.featureIndices[i];
				result[i] = _featureRecords[index];
			}
			
			return result;
		}
		
	}

}