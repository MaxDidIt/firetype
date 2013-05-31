package de.maxdidit.hardware.text.format 
{
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontFeatures 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _featureMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontFeatures() 
		{
			_featureMap = new Object();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addFeature(feature:FeatureTag):void
		{
			_featureMap[feature.tag] = feature;
		}
		
		public function removeFeatureByReference(feature:FeatureTag):void
		{
			removeFeatureByTag(feature.tag);
		}
		
		public function removeFeatureByTag(tag:String):void
		{
			if (_featureMap.hasOwnProperty(tag))
			{
				delete _featureMap[tag];
			}
		}
		
		public function hasFeature(feature:FeatureTag):Boolean
		{
			return hasFeatureTag(feature.tag);
		}
		
		public function hasFeatureTag(tag:String):Boolean
		{
			return _featureMap.hasOwnProperty(tag);
		}
	}

}