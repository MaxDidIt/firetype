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
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class DigitalSignatureTableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		// header 
		 
		private var _version:uint; 
		private var _numSignatures:uint; 
		private var _flags:uint; 
		 
		// signatures 
		private var _signatures:Vector.<DigitalSignature>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function DigitalSignatureTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// version 
		 
		public function get version():uint  
		{ 
			return _version; 
		} 
		 
		public function set version(value:uint):void  
		{ 
			_version = value; 
		} 
		 
		// numSignatures 
		 
		public function get numSignatures():uint  
		{ 
			return _numSignatures; 
		} 
		 
		public function set numSignatures(value:uint):void  
		{ 
			_numSignatures = value; 
		} 
		 
		// flags 
		 
		public function get flags():uint  
		{ 
			return _flags; 
		} 
		 
		public function set flags(value:uint):void  
		{ 
			_flags = value; 
		} 
		 
		// signatures 
		 
		public function get signatures():Vector.<DigitalSignature>  
		{ 
			return _signatures; 
		} 
		 
		public function set signatures(value:Vector.<DigitalSignature>):void  
		{ 
			_signatures = value; 
		} 
		 
	} 
} 
