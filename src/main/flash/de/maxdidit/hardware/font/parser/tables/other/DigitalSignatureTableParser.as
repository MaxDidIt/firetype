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
 
package de.maxdidit.hardware.font.parser.tables.other  
{ 
	import de.maxdidit.hardware.font.data.ITableMap; 
	import de.maxdidit.hardware.font.data.tables.other.dsig.DigitalSignature; 
	import de.maxdidit.hardware.font.data.tables.other.dsig.DigitalSignatureTableData; 
	import de.maxdidit.hardware.font.data.tables.TableRecord; 
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class DigitalSignatureTableParser implements ITableParser  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function DigitalSignatureTableParser(dataTypeParser:DataTypeParser)  
		{ 
			_dataTypeParser = dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.ITableParser */ 
		 
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap, font:HardwareFont = null):*  
		{ 
			data.position = record.offset; 
			 
			var result:DigitalSignatureTableData = new DigitalSignatureTableData(); 
			 
			result.version = _dataTypeParser.parseUnsignedLong(data); 
			result.numSignatures = _dataTypeParser.parseUnsignedShort(data); 
			result.flags = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.signatures = parseSignatureEntries(data, result.numSignatures); 
			parseSignatures(data, record.offset, result.signatures); 
			 
			return result; 
		} 
		 
		private function parseSignatures(data:ByteArray, offset:uint, signatures:Vector.<DigitalSignature>):void  
		{ 
			const l:uint = signatures.length; 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				parseSignature(data, offset, signatures[i]); 
			} 
		} 
		 
		private function parseSignature(data:ByteArray, offset:uint, signature:DigitalSignature):void  
		{ 
			data.position = offset + signature.offset; 
			 
			data.position += 2; // reserved unsigned short 
			data.position += 2; // another reserved unsigned short 
			 
			signature.pkcs7Length = _dataTypeParser.parseUnsignedLong(data); 
			 
			var pkcs7Packet:ByteArray = new ByteArray(); 
			data.readBytes(pkcs7Packet, 0, signature.pkcs7Length); 
			 
			signature.pkcs7Packet = pkcs7Packet; 
		} 
		 
		private function parseSignatureEntries(data:ByteArray, numSignatures:uint):Vector.<DigitalSignature>  
		{ 
			var signatures:Vector.<DigitalSignature> = new Vector.<DigitalSignature>(); 
			 
			for (var i:uint = 0; i < numSignatures; i++) 
			{ 
				var signature:DigitalSignature = new DigitalSignature(); 
				parseSignatureEntry(data, signature); 
				signatures.push(signature); 
			} 
			 
			return signatures; 
		} 
		 
		private function parseSignatureEntry(data:ByteArray, signature:DigitalSignature):void  
		{ 
			signature.format = _dataTypeParser.parseUnsignedLong(data); 
			signature.length = _dataTypeParser.parseUnsignedLong(data); 
			signature.offset = _dataTypeParser.parseUnsignedLong(data); 
		} 
	} 
} 
