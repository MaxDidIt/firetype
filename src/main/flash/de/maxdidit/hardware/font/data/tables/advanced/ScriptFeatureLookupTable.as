package de.maxdidit.hardware.font.data.tables.advanced 
{
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
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
		
		public function applyTable(characterInstances:LinkedList, scriptTag:String, languageTag:String):void
		{
			var scriptTable:ScriptTable = scriptListTable.retrieveScriptTable(scriptTag);
			if (!scriptTable)
			{
				return;
			}
			
			var languageSystemTable:LanguageSystemTable = scriptTable.retrieveLanguageSystemTable(languageTag)
			
			var features:Vector.<FeatureRecord> = featureListTable.retrieveFeatures(languageSystemTable);
			
			applyFeatures(characterInstances, features);
		}
		
		public function retrieveFeatures(scriptTag:String, languageTag:String, useAllFeatures:Boolean = false):Vector.<FeatureRecord>
		{
			var scriptTable:ScriptTable = scriptListTable.retrieveScriptTable(scriptTag);
			if (!scriptTable)
			{
				return null;
			}
			
			var languageSystemTable:LanguageSystemTable = scriptTable.retrieveLanguageSystemTable(languageTag)
			
			var features:Vector.<FeatureRecord> = featureListTable.retrieveFeatures(languageSystemTable, useAllFeatures);
			
			return features;
		}
		
		public function retrieveFeatureLookupTables(scriptTag:String, languageTag:String, useAllFeatures:Boolean = false):Vector.<LookupTable>
		{
			var features:Vector.<FeatureRecord> = retrieveFeatures(scriptTag, languageTag, useAllFeatures);
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
		
		private function applyFeatures(characterInstances:LinkedList, features:Vector.<FeatureRecord>):void 
		{
			const l:uint = features.length;
			for (var i:uint = 0; i < l; i++)
			{
				var feature:FeatureRecord = features[i];
				applyFeature(characterInstances, feature);
			}
		}
		
		private function applyFeature(characterInstances:LinkedList, feature:FeatureRecord):void 
		{
			var lookupTables:Vector.<LookupTable> = lookupListTable.retrieveLookupTables(feature.featureTable.lookupListIndices);
			
			characterInstances.gotoFirstElement();
			
			while (characterInstances.currentElement)
			{
				performLookups(characterInstances, lookupTables);
				characterInstances.gotoNextElement();
			}
		}
		
		private function performLookups(characterInstances:LinkedList, lookupTables:Vector.<LookupTable>):void 
		{
			const l:uint = lookupTables.length;
			for (var i:uint = 0; i < l; i++)
			{
				var lookupTable:LookupTable = lookupTables[i];
				lookupTable.performLookup(characterInstances, this);
			}
		}
	}

}