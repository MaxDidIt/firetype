/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
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
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class FeatureRecord  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _featureTag:FeatureTag; 
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
		 
		public function get featureTag():FeatureTag  
		{ 
			return _featureTag; 
		} 
		 
		public function set featureTag(value:FeatureTag):void  
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
