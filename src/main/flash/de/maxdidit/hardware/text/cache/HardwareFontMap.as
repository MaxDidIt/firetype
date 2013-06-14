/* 
Copyright ©2013 Max Knoblich 
 
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
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.format.TextColor;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareFontMap 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _fontMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontMap() 
		{
			_fontMap = new Object();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addFont(font:HardwareFont):void
		{
			_fontMap[font.uniqueIdentifier] = font;
		}
		
		public function getFontById(uniqueIdentifier:String):HardwareFont
		{
			return _fontMap[uniqueIdentifier];
		}
		
		public function removeFontByReference(font:HardwareFont):void
		{
			removeFontByTag(font.uniqueIdentifier);
		}
		
		public function removeFontByTag(id:String):void
		{
			if (_fontMap.hasOwnProperty(id))
			{
				delete _fontMap[id];
			}
		}
		
		public function hasFont(textColor:HardwareFont):Boolean
		{
			return hasFontId(textColor.uniqueIdentifier);
		}
		
		public function hasFontId(uniqueIdentifier:String):Boolean
		{
			return _fontMap.hasOwnProperty(uniqueIdentifier);
		}
	}

}