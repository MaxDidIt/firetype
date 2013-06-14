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
 
package de.maxdidit.hardware.text.cache  
{ 
	import de.maxdidit.hardware.text.format.HardwareTextFormat; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class HardwareTextFormatMap  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _textFormatMap:Object; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function HardwareTextFormatMap()  
		{ 
			_textFormatMap = new Object(); 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		public function addTextFormat(textFormat:HardwareTextFormat):void 
		{ 
			_textFormatMap[textFormat.id] = textFormat; 
		} 
		 
		public function getTextFormatById(id:String):HardwareTextFormat 
		{ 
			return _textFormatMap[id]; 
		} 
		 
		public function removeTextFormatByReference(textFormat:HardwareTextFormat):void 
		{ 
			removeTextFormatByTag(textFormat.id); 
		} 
		 
		public function removeTextFormatByTag(id:String):void 
		{ 
			if (_textFormatMap.hasOwnProperty(id)) 
			{ 
				delete _textFormatMap[id]; 
			} 
		} 
		 
		public function hasTextFormat(textFormat:HardwareTextFormat):Boolean 
		{ 
			return hasTextFormatId(textFormat.id); 
		} 
		 
		public function hasTextFormatId(id:String):Boolean 
		{ 
			return _textFormatMap.hasOwnProperty(id); 
		} 
	} 
} 
