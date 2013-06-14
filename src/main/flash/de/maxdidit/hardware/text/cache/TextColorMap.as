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
	import de.maxdidit.hardware.text.format.TextColor; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class TextColorMap  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _textColorMap:Object; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function TextColorMap()  
		{ 
			_textColorMap = new Object(); 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		public function addTextColor(textColor:TextColor):void 
		{ 
			_textColorMap[textColor.id] = textColor; 
		} 
		 
		public function getTextColorById(id:String):TextColor 
		{ 
			return _textColorMap[id]; 
		} 
		 
		public function removeTextColorByReference(textFormat:TextColor):void 
		{ 
			removeTextColorByTag(textFormat.id); 
		} 
		 
		public function removeTextColorByTag(id:String):void 
		{ 
			if (_textColorMap.hasOwnProperty(id)) 
			{ 
				delete _textColorMap[id]; 
			} 
		} 
		 
		public function hasTextColor(textColor:TextColor):Boolean 
		{ 
			return hasTextColorId(textColor.id); 
		} 
		 
		public function hasTextColorId(id:String):Boolean 
		{ 
			return _textColorMap.hasOwnProperty(id); 
		} 
	} 
} 
