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
 
package de.maxdidit.hardware.font.data.tables.common.features
{
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.text.format.HardwareFontFeatures;
	
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
		
		public function retrieveFeatures(languageSystemTable:LanguageSystemTable, activatedFeatures:HardwareFontFeatures = null):Vector.<FeatureRecord>
		{
			var result:Vector.<FeatureRecord> = new Vector.<FeatureRecord>();
			
			var requiredFeature:Boolean = languageSystemTable.requiredFeatureIndex != 0xFFFF;
			var requiredFeatureNeedsToBeAdded:Boolean = !requiredFeature;
			
			// add activated features
			const l:uint = languageSystemTable.featureIndices.length;
			for (var i:uint = 0; i < l; i++)
			{
				var index:uint = languageSystemTable.featureIndices[i];
				var feature:FeatureRecord = _featureRecords[index];
				
				if (requiredFeature && index == languageSystemTable.requiredFeatureIndex)
				{
					requiredFeatureNeedsToBeAdded = false;
					result.push(feature);
				}
				else if (!activatedFeatures || activatedFeatures.hasFeature(feature.featureTag))
				{
					result.push(feature);
				}
			}
			
			if (requiredFeature && requiredFeatureNeedsToBeAdded)
			{
				result.push(_featureRecords[languageSystemTable.requiredFeatureIndex]);
			}
			
			// TODO: Bring features into correct order.
			
			return result;
		}	
	}

}