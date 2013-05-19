package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AnchorTableParser implements ISubTableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AnchorTableParser($dataTypeParser:DataTypeParser) 
		{
			this._dataTypeParser = $dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ISubTableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:AnchorTable = new AnchorTable();
			
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			
			var xCoordinate:int = _dataTypeParser.parseShort(data);
			result.xCoordinate = xCoordinate;
			
			var yCoordinate:int = _dataTypeParser.parseShort(data);
			result.yCoordinate = yCoordinate;
			
			var anchorPointIndex:int = -1;
			if (format == 2)
			{
				anchorPointIndex = int(_dataTypeParser.parseUnsignedShort(data));
			}
			result.anchorPointIndex = anchorPointIndex;
			
			if (format == 3)
			{
				var xDeviceTableOffset:uint = _dataTypeParser.parseUnsignedShort(data);
				result.xDeviceTableOffset = xDeviceTableOffset;
				
				var yDeviceTableOffset:uint = _dataTypeParser.parseUnsignedShort(data);
				result.yDeviceTableOffset = yDeviceTableOffset;
				
				// TODO: parse device tables pointed to by offsets
			}
			
			return result;
		}
		
	}

}