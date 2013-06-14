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
 
package de.maxdidit.hardware.font.events 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FontEvent extends Event 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const FONT_PARSED:String = "fontParsed";
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _font:HardwareFont;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontEvent(type:String, font:HardwareFont, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable)
			this.font = font;
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// font
		
		public function get font():HardwareFont 
		{
			return _font;
		}
		
		public function set font(value:HardwareFont):void 
		{
			_font = value;
		}
		
	}

}