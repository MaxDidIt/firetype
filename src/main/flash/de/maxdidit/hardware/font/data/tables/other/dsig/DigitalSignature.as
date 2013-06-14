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
 
package de.maxdidit.hardware.font.data.tables.other.dsig  
{ 
	import flash.utils.ByteArray; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class DigitalSignature  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		// header 
		 
		private var _format:uint; 
		private var _length:uint; 
		private var _offset:uint; 
		 
		// signature 
		private var _pkcs7Length:uint; 
		private var _pkcs7Packet:ByteArray; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function DigitalSignature()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// format 
		 
		public function get format():uint  
		{ 
			return _format; 
		} 
		 
		public function set format(value:uint):void  
		{ 
			_format = value; 
		} 
		 
		// length 
		 
		public function get length():uint  
		{ 
			return _length; 
		} 
		 
		public function set length(value:uint):void  
		{ 
			_length = value; 
		} 
		 
		// offset 
		 
		public function get offset():uint  
		{ 
			return _offset; 
		} 
		 
		public function set offset(value:uint):void  
		{ 
			_offset = value; 
		} 
		 
		// pkcs7length 
		 
		public function get pkcs7Length():uint  
		{ 
			return _pkcs7Length; 
		} 
		 
		public function set pkcs7Length(value:uint):void  
		{ 
			_pkcs7Length = value; 
		} 
		 
		// pkcs data 
		 
		public function get pkcs7Packet():ByteArray  
		{ 
			return _pkcs7Packet; 
		} 
		 
		public function set pkcs7Packet(value:ByteArray):void  
		{ 
			_pkcs7Packet = value; 
		} 
		 
		 
		 
	} 
} 
