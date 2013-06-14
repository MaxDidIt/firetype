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
		 
		public function parseF2Dot14(data:ByteArray):Number 
		{ 
			var integerValue:int = data.readShort(); 
			var floatValue:Number = Number(integerValue) / Number(0x20000); 
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
		 
		public function parseUnsignedByte(data:ByteArray):uint  
		{ 
			var value:uint = data.readUnsignedByte(); 
			return value; 
		} 
		 
		public function parseByte(data:ByteArray):int  
		{ 
			var value:uint = data.readByte(); 
			return value; 
		} 
		 
		public function parseTag(data:ByteArray):String 
		{ 
			var result:String = data.readUTFBytes(4); 
			return result; 
		} 
		 
	} 
} 
