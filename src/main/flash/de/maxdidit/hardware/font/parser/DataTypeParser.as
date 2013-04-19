package de.maxdidit.hardware.font.parser 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class DataTypeParser 
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function DataTypeParser() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		// parsing data types
		
		public function parseSFNTVersionNumber(data:ByteArray):String
		{
			var value:uint = data.readUnsignedInt();
			
			if (value == 0x00010000)
			{
				return "1.0"; // Font contains TrueType outlines
			}
			
			if (value == 0x4F54544F)
			{
				return "OTTO"; // Font contains CFF data
			}
			
			return "unknown";
		}
		
		public function parseFixed(data:ByteArray):Number 
		{
			var integerValue:int = data.readInt();
			var floatValue:Number = Number(integerValue) / Number(0x10000);
			return floatValue;
		}
		
		public function parseUnsignedShort(data:ByteArray):uint
		{
			var value:uint = data.readUnsignedShort();
			return value;
		}
		
		public function parseUnsignedLong(data:ByteArray):uint
		{
			var value:uint = data.readUnsignedInt()
			return value;
		}
		
		public function parseUnsignedLongAsString(data:ByteArray):String 
		{
			var string:String = data.readUTFBytes(4);
			return string;
		}
		
		public function parseShort(data:ByteArray):int 
		{
			var value:int = data.readShort();
			return value;
		}
		
		public function parseLong64(data:ByteArray):Number 
		{
			var value:Number = data.readUnsignedInt() << 32;
			value += data.readUnsignedInt();
			return value;
		}
		
	}

}