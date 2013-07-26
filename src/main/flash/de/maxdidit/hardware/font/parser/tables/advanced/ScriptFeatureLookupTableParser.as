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
 
package de.maxdidit.hardware.font.parser.tables.advanced 
{ 
	import de.maxdidit.hardware.font.data.ITableMap; 
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureListTableData; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupListTable; 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.common.CoverageTableParser; 
	import de.maxdidit.hardware.font.parser.tables.common.FeatureListTableParser; 
	import de.maxdidit.hardware.font.parser.tables.common.LookupListTableDataParser; 
	import de.maxdidit.hardware.font.parser.tables.common.ScriptListTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import de.maxdidit.hardware.font.parser.tables.NotYetImplementedSubtableParser; 
	import flash.utils.ByteArray; 
	 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ScriptFeatureLookupTableParser implements ITableParser 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		protected var _dataTypeParser:DataTypeParser; 
		 
		protected var _scriptListTableParser:ScriptListTableParser; 
		protected var _featureListTableParser:FeatureListTableParser; 
		protected var _lookupTableParser:LookupListTableDataParser; 
		 
		protected var _coverageTableParser:CoverageTableParser; 
		 
		protected var _subtableParserMap:Object; 
			 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ScriptFeatureLookupTableParser($dataTypeParser:DataTypeParser) 
		{ 
			this._dataTypeParser = $dataTypeParser; 
			 
			_scriptListTableParser = new ScriptListTableParser(_dataTypeParser); 
			_featureListTableParser = new FeatureListTableParser(_dataTypeParser); 
			_lookupTableParser = new LookupListTableDataParser(_dataTypeParser); 
			 
			_coverageTableParser = new CoverageTableParser(_dataTypeParser); 
			 
			initSubtableParser(); 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		protected function initSubtableParser():void  
		{ 
			throw new Error("Extend this class and implement this function."); 
		} 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */ 
		 
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap, font:HardwareFont = null):* 
		{ 
			data.position = record.offset; 
			 
			var result:ScriptFeatureLookupTable = instantiateResult(); 
			 
			var version:Number = _dataTypeParser.parseFixed(data); 
			result.version = version; 
			 
			var scriptListOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.scriptListOffset = scriptListOffset; 
			 
			var featuresListOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.featuresListOffset = featuresListOffset; 
			 
			var lookupListOffset:uint = _dataTypeParser.parseUnsignedShort(data); 
			result.lookupListOffset = lookupListOffset; 
			 
			var scriptListTableData:ScriptListTableData = _scriptListTableParser.parseTable(data, record.offset + scriptListOffset); 
			result.scriptListTable = scriptListTableData; 
			 
			var featureListTableData:FeatureListTableData = _featureListTableParser.parseTable(data, record.offset + featuresListOffset); 
			result.featureListTable = featureListTableData; 
			 
			var lookupTableData:LookupListTable = _lookupTableParser.parseTable(data, record.offset + lookupListOffset); 
			result.lookupListTable = lookupTableData; 
			 
			var subTables:Vector.<LookupTable> = parseSubTables(data, record.offset + lookupListOffset, lookupTableData.lookupOffsets); 
			lookupTableData.lookupTables = subTables; 
			 
			return result; 
		} 
		 
		protected function instantiateResult():ScriptFeatureLookupTable  
		{ 
			throw new Error("Extend this class and implement this function.") 
		} 
		 
		private function parseSubTables(data:ByteArray, lookupListOffset:uint, lookupOffsets:Vector.<uint>):Vector.<LookupTable> 
		{ 
			const l:uint = lookupOffsets.length; 
			var result:Vector.<LookupTable> = new Vector.<LookupTable>(l); 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var offset:uint = lookupOffsets[i]; 
				 
				var lookupTable:LookupTable = parseLookupTable(data, lookupListOffset + offset); 
				lookupTable.lookupIndex = i; 
				 
				result[i] = lookupTable; 
			} 
			 
			return result; 
		} 
		 
		private function parseLookupTable(data:ByteArray, offset:uint):LookupTable 
		{ 
			data.position = offset; 
			 
			var result:LookupTable = _lookupTableParser.parseLookupTable(data); 
			var parser:ISubTableParser = getSubtableParser(String(result.lookupType)); 
			 
			const l:uint = result.subTableOffsets.length; 
			var subTables:Vector.<ILookupSubtable> = new Vector.<ILookupSubtable>(l); 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var subTableOffset:uint = result.subTableOffsets[i]; 
				var subTable:ILookupSubtable = parser.parseTable(data, offset + subTableOffset) as ILookupSubtable; 
				subTable.parent = result; 
				 
				subTables[i] = subTable; 
			} 
			result.subTables = subTables; 
			 
			return result; 
		} 
		 
		public function getSubtableParser(lookupType:String):ISubTableParser 
		{ 
			return _subtableParserMap[lookupType] as ISubTableParser; 
		} 
		 
	} 
} 
