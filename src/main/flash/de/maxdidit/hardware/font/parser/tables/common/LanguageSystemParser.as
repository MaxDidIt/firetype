package de.maxdidit.hardware.font.parser.tables.common 
{
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemRecord;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LanguageSystemParser implements ISubTableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LanguageSystemParser($dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = $dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function parseLanguageSystemRecord(data:ByteArray):LanguageSystemRecord
		{
			var result:LanguageSystemRecord = new LanguageSystemRecord();
			
			result.languageSystemTag = _dataTypeParser.parseTag(data);
			result.languageSystemOffset = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			var result:LanguageSystemTable = new LanguageSystemTable();
			
			// skip reserved offset field
			data.position += 2;
			
			var requiredFeatureIndex:uint = _dataTypeParser.parseUnsignedShort(data);
			result.requiredFeatureIndex = requiredFeatureIndex;
			
			var featureCount:uint = _dataTypeParser.parseUnsignedShort(data);
			result.featureCount = featureCount;
			
			var featureIndices:Vector.<uint> = new Vector.<uint>(featureCount);
			for (var i:uint = 0; i < featureCount; i++)
			{
				var featureIndex:uint = _dataTypeParser.parseUnsignedShort(data);
				featureIndices[i] = featureIndex;
			}
			result.featureIndices = featureIndices;
			
			return result;
		}
	}

}