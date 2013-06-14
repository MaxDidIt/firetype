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
 
package de.maxdidit.hardware.font.data.tables.required.name 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NamingTableNameID 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const COPYRIGHT:String				= "0";
		public static const FONT_FAMILY:String				= "1";
		public static const FONT_SUBFAMILY:String			= "2";
		public static const UNIQUE_FONT_IDENTIFIER:String	= "3";
		public static const FULL_FONT_NAME:String			= "4";
		public static const VERSION:String					= "5";
		public static const POSTSCRIPT_NAME:String			= "6";
		public static const TRADEMARK:String				= "7";
		public static const MANUFACTURER:String				= "8";
		public static const DESIGNER:String					= "9";
		public static const DESCRIPTION:String				= "10";
		public static const URL_VENDOR:String				= "11";
		public static const URL_DESIGNER:String				= "12";
		public static const LICENSE_DESCRIPTION:String		= "13";
		public static const LICENSE_INFO_URL:String			= "14";
		public static const PREFERRED_FAMILY:String			= "16";
		public static const PREFERRED_SUB_FAMILY:String		= "17";
		public static const COMPATIBLE_FULL:String			= "18";
		public static const SAMPLE_TEXT:String				= "19";
		public static const POSTSCRIPT_CID_FINDFONT:String	= "20";
		public static const WWS_FAMILY_NAME:String			= "21";
		public static const WWS_SUB_FAMILY_NAME:String		= "22";
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NamingTableNameID() 
		{
			throw new Error("Don't instantiate this class");
		}
		
	}

}