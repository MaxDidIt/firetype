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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphPositioningLookupType 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const SINGLE_ADJUSTMENT:uint				= 1;
		public static const PAIR_ADJUSTMENT:uint				= 2;
		public static const CURSIVE_ATTACHMENT:uint				= 3;
		public static const MARK_TO_BASE_ATTACHMENT:uint		= 4;
		public static const MARK_TO_LIGATURE_ATTACHMENT:uint	= 5;
		public static const MARK_TO_MARK_ATTACHMENT:uint		= 6;
		public static const CONTEXT_POSITIONING:uint			= 7;
		public static const CHAINED_CONTEXT_POSITIONING:uint	= 8;
		public static const EXTENSION_POSITIONING:uint			= 9;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphPositioningLookupType() 
		{
			throw new Error("This class is not supposed to be instantiated.");
		}
		
	}

}