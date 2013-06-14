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
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphSubstitutionLookupType 
	{
		///////////////////////
		// Constants
		///////////////////////
	
		public static const SINGLE_SUBSTITUTION:uint						= 1;
		public static const MULTIPLE_SUBSTITUTION:uint						= 2;
		public static const ALTERNATE_SUBSTITUTION:uint						= 3;
		public static const LIGATURE_SUBSTITUTION:uint						= 4;
		public static const CONTEXTUAL_SUBSTITUTION:uint					= 5;
		public static const CHAINING_CONTEXTUAL_SUBSTITUTION:uint			= 6;
		public static const EXTENSION_SUBSTITUTION:uint						= 7;
		public static const REVERSE_CHAINING_CONTEXTUAL_SUBSTITUTION:uint	= 8;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphSubstitutionLookupType() 
		{
			throw new Error("This class is not supposed to be instantiated.");
		}
		
	}

}