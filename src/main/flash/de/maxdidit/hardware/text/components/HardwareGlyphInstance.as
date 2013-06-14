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
 
package de.maxdidit.hardware.text.components 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.TransformedInstance;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareGlyphInstance extends TransformedInstance
	{
		///////////////////////
		// Static Variables
		///////////////////////
		
		private static var _pool:LinkedList = new LinkedList();
		
		///////////////////////
		// Static Functions
		///////////////////////
		
		public static function getHardwareGlyphInstance(glyph:HardwareGlyph):HardwareGlyphInstance
		{
			var instance:HardwareGlyphInstance;
			
			if (_pool.firstElement)
			{
				var element:HardwareGlyphInstanceListElement = _pool.firstElement as HardwareGlyphInstanceListElement;
				instance = element.hardwareGlyphInstance;
				instance.hardwareGlyph = glyph;
				instance.glyph = null;
				
				instance.x = 0;
				instance.y = 0;
				
				instance.scaleX = 1;
				instance.scaleY = 1;
				
				instance.shearX = 0;
				instance.shearY = 0;
				
				_pool.removeElement(element);
			}
			else
			{
				instance = new HardwareGlyphInstance(glyph);
			}
			
			return instance;
		}
		
		public static function returnHardwareGlyphInstance(instance:HardwareGlyphInstance):void
		{
			var element:HardwareGlyphInstanceListElement = new HardwareGlyphInstanceListElement(instance);
			_pool.addElement(element);
		}
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _hardwareGlyph:HardwareGlyph;
		private var _glyph:Glyph;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareGlyphInstance($glyph:HardwareGlyph) 
		{
			_hardwareGlyph = $glyph;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// glyph
		
		public function get hardwareGlyph():HardwareGlyph 
		{
			return _hardwareGlyph;
		}
		
		public function set hardwareGlyph(value:HardwareGlyph):void 
		{
			_hardwareGlyph = value;
		}
		
		public function get glyph():Glyph 
		{
			return _glyph;
		}
		
		public function set glyph(value:Glyph):void 
		{
			_glyph = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function clone():TransformedInstance 
		{
			var result:HardwareGlyphInstance = getHardwareGlyphInstance(_hardwareGlyph);
			
			result.x = this.x;
			result.y = this.y;
			
			return result;
		}
		
	}

}
