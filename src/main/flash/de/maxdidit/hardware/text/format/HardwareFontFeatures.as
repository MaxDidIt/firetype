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
		private var _parent:HardwareFontFeatures;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontFeatures(parent:HardwareFontFeatures = null) 
		{
			_featureMap = new Object();
			_parent = parent;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get parent():HardwareFontFeatures 
		{
			return _parent;
		}
		
		public function set parent(value:HardwareFontFeatures):void 
		{
			_parent = value;
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
			if (_featureMap.hasOwnProperty(tag))
			{
				return true;
			}
			
			if (!_parent)
			{
				return false;
			}
			
			return _parent.hasFeatureTag(tag);
		}
		
		public function copyFrom(features:HardwareFontFeatures):void 
		{
			for (var tag:String in features._featureMap)
			{
				_featureMap[tag] = features._featureMap[tag];
			}
		}
	}

}