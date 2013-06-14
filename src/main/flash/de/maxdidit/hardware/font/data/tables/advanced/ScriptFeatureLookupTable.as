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
 
package de.maxdidit.hardware.font.data.tables.advanced  
{ 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData; 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord; 
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData; 
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable; 
	import de.maxdidit.hardware.text.format.HardwareFontFeatures; 
	import de.maxdidit.list.LinkedList; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ScriptFeatureLookupTable  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _version:Number; 
		 
		private var _scriptListOffset:uint; 
		private var _featuresListOffset:uint; 
		private var _lookupListOffset:uint; 
		 
		private var _scriptListTable:ScriptListTableData; 
		private var _featureListTable:FeatureListTableData; 
		private var _lookupListTable:LookupListTable; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ScriptFeatureLookupTable()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get version():Number  
		{ 
			return _version; 
		} 
		 
		public function set version(value:Number):void  
		{ 
			_version = value; 
		} 
		 
		public function get scriptListOffset():uint  
		{ 
			return _scriptListOffset; 
		} 
		 
		public function set scriptListOffset(value:uint):void  
		{ 
			_scriptListOffset = value; 
		} 
		 
		public function get featuresListOffset():uint  
		{ 
			return _featuresListOffset; 
		} 
		 
		public function set featuresListOffset(value:uint):void  
		{ 
			_featuresListOffset = value; 
		} 
		 
		public function get lookupListOffset():uint  
		{ 
			return _lookupListOffset; 
		} 
		 
		public function set lookupListOffset(value:uint):void  
		{ 
			_lookupListOffset = value; 
		} 
		 
		public function get scriptListTable():ScriptListTableData  
		{ 
			return _scriptListTable; 
		} 
		 
		public function set scriptListTable(value:ScriptListTableData):void  
		{ 
			_scriptListTable = value; 
		} 
		 
		public function get featureListTable():FeatureListTableData  
		{ 
			return _featureListTable; 
		} 
		 
		public function set featureListTable(value:FeatureListTableData):void  
		{ 
			_featureListTable = value; 
		} 
		 
		public function get lookupListTable():LookupListTable  
		{ 
			return _lookupListTable; 
		} 
		 
		public function set lookupListTable(value:LookupListTable):void  
		{ 
			_lookupListTable = value; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		//public function applyTable(characterInstances:LinkedList, scriptTag:String, languageTag:String, activatedFeatures:HardwareFontFeatures):void 
		//{ 
			//var scriptTable:ScriptTable = scriptListTable.retrieveScriptTable(scriptTag); 
			//if (!scriptTable) 
			//{ 
				//return; 
			//} 
			// 
			//var languageSystemTable:LanguageSystemTable = scriptTable.retrieveLanguageSystemTable(languageTag) 
			// 
			//var features:Vector.<FeatureRecord> = featureListTable.retrieveFeatures(languageSystemTable, activatedFeatures); 
			// 
			//applyFeatures(characterInstances, features); 
		//} 
		 
		public function retrieveFeatures(scriptTag:String, languageTag:String, activatedFeatures:HardwareFontFeatures = null):Vector.<FeatureRecord> 
		{ 
			var scriptTable:ScriptTable = scriptListTable.retrieveScriptTable(scriptTag); 
			if (!scriptTable) 
			{ 
				return null; 
			} 
			 
			var languageSystemTable:LanguageSystemTable = scriptTable.retrieveLanguageSystemTable(languageTag) 
			 
			var features:Vector.<FeatureRecord> = featureListTable.retrieveFeatures(languageSystemTable, activatedFeatures); 
			 
			return features; 
		} 
		 
		public function retrieveFeatureLookupTables(scriptTag:String, languageTag:String, activatedFeatures:HardwareFontFeatures):Vector.<LookupTable> 
		{ 
			var features:Vector.<FeatureRecord> = retrieveFeatures(scriptTag, languageTag, activatedFeatures); 
			if (!features) 
			{ 
				return null; 
			} 
			 
			var lookupTables:Vector.<LookupTable> = new Vector.<LookupTable>(); 
			 
			const l:uint = features.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				lookupTables = lookupTables.concat(_lookupListTable.retrieveLookupTables(features[i].featureTable.lookupListIndices)); 
			} 
			 
			return lookupTables; 
		} 
		 
		//private function applyFeatures(characterInstances:LinkedList, features:Vector.<FeatureRecord>):void  
		//{ 
			//const l:uint = features.length; 
			//for (var i:uint = 0; i < l; i++) 
			//{ 
				//var feature:FeatureRecord = features[i]; 
				//applyFeature(characterInstances, feature); 
			//} 
		//} 
		 
		//private function applyFeature(characterInstances:LinkedList, feature:FeatureRecord):void  
		//{ 
			//var lookupTables:Vector.<LookupTable> = lookupListTable.retrieveLookupTables(feature.featureTable.lookupListIndices); 
			// 
			//characterInstances.gotoFirstElement(); 
			// 
			//while (characterInstances.currentElement) 
			//{ 
				//performLookups(characterInstances, lookupTables); 
				//characterInstances.gotoNextElement(); 
			//} 
		//} 
		 
		//private function performLookups(characterInstances:LinkedList, lookupTables:Vector.<LookupTable>):void  
		//{ 
			//const l:uint = lookupTables.length; 
			//for (var i:uint = 0; i < l; i++) 
			//{ 
				//var lookupTable:LookupTable = lookupTables[i]; 
				//lookupTable.performLookup(characterInstances, this); 
			//} 
		//} 
	} 
} 
