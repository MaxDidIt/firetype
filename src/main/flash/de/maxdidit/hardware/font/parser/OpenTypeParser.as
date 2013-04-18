package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.SFNTWrapper;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class OpenTypeParser implements IFontParser
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function OpenTypeParser() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.IFontParser */
		
		public function parseFontData(data:ByteArray):HardwareFontData 
		{
			data.position = 0;
			
			var hardwareFontData:HardwareFontData = new HardwareFontData();
			
			hardwareFontData.sfntWrapper = parseSFNTWrapper(data);
			hardwareFontData.tables = parseTableRecords(data, hardwareFontData.sfntWrapper.numTables);
			
			return hardwareFontData;
		}
		
		private function parseTableRecords(data:ByteArray, numRecords:uint):Vector.<Table> 
		{
			var tables:Vector.<Table> = new Vector.<Table>();
			
			for (var i:uint = 0; i < numRecords; i++)
			{
				var table:Table = new Table();
				table.record = parseTableRecord(data);
				tables.push(table);
			}
			
			return tables;
		}
		
		private function parseTableRecord(data:ByteArray):TableRecord 
		{
			var tableRecord:TableRecord = new TableRecord();
			
			tableRecord.tag = parseUnsignedLongAsString(data);
			tableRecord.checkSum = parseUnsignedLong(data);
			tableRecord.offset = parseUnsignedLong(data);
			tableRecord.length = parseUnsignedLong(data);
			
			return tableRecord;
		}
		
		private function parseSFNTWrapper(data:ByteArray):SFNTWrapper 
		{
			var sfntWrapper:SFNTWrapper = new SFNTWrapper();
			
			sfntWrapper.version = parseSFNTVersionNumber(data);
			sfntWrapper.numTables = parseUnsignedShort(data);
			sfntWrapper.searchRange = parseUnsignedShort(data);
			sfntWrapper.entrySelector = parseUnsignedShort(data);
			sfntWrapper.rangeShift = parseUnsignedShort(data);
			
			return sfntWrapper;
		}
		
		// parsing data types
		
		private function parseSFNTVersionNumber(data:ByteArray):String
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
		
		private function parseFixed(data:ByteArray):Number 
		{
			var integerValue:int = data.readInt();
			var floatValue:Number = Number(integerValue) / Number(0x10000);
			return floatValue;
		}
		
		private function parseUnsignedShort(data:ByteArray):uint
		{
			var value:uint = ((data.readByte() & 0xFF) << 8);
			value += (data.readByte() & 0xFF);
			return value;
		}
		
		private function parseUnsignedLong(data:ByteArray):uint
		{
			var value:uint = ((data.readByte() & 0xFF) << 24);
			value += ((data.readByte() & 0xFF) << 16);
			value += ((data.readByte() & 0xFF) << 8);
			value += (data.readByte() & 0xFF);
			return value;
		}
		
		private function parseUnsignedLongAsString(data:ByteArray):String 
		{
			var string:String = data.readUTFBytes(4);
			return string;
		}
		
	}

}