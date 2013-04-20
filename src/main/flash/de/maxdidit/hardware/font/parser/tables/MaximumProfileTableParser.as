package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.tables.maxp.MaximumProfileTableData;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MaximumProfileTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MaximumProfileTableParser(dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = dataTypeParser;
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:MaximumProfileTableData = new MaximumProfileTableData();
			
			result.version = _dataTypeParser.parseFixed(data);
			result.numGlyphs = _dataTypeParser.parseUnsignedShort(data);
			
			if (result.version == 0.5)
			{
				// in version 0.5, numGlyphs is the only field in the table
				return result;
			}
			
			result.maxPoints = _dataTypeParser.parseUnsignedShort(data);
			result.maxContours = _dataTypeParser.parseUnsignedShort(data);
			result.maxCompositePoints = _dataTypeParser.parseUnsignedShort(data);
			result.maxCompositeContours = _dataTypeParser.parseUnsignedShort(data);
			
			result.maxZones = _dataTypeParser.parseUnsignedShort(data);
			result.maxTwilightPoint = _dataTypeParser.parseUnsignedShort(data);
			
			result.maxStorage = _dataTypeParser.parseUnsignedShort(data);
			
			result.maxFunctionDefs = _dataTypeParser.parseUnsignedShort(data);
			result.maxInstructionDefs = _dataTypeParser.parseUnsignedShort(data);
			
			result.maxStackElements = _dataTypeParser.parseUnsignedShort(data);
			
			result.maxSizeOfInstructions = _dataTypeParser.parseUnsignedShort(data);
			
			result.maxComponentElements = _dataTypeParser.parseUnsignedShort(data);
			result.maxComponentDepth = _dataTypeParser.parseUnsignedShort(data);
			
			return result;
		}
		
	}

}