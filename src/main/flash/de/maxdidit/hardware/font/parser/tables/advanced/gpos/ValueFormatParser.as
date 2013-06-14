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
 
package de.maxdidit.hardware.font.parser.tables.advanced.gpos  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ValueFormatParser 
	{ 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ValueFormatParser()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		public function parseValueFormat(valueFormatData:uint):ValueFormat 
		{ 
			var valueFormat:ValueFormat = new ValueFormat(); 
			 
			valueFormat.xPlacement = (valueFormatData & 0x1) == 1; 
			valueFormat.yPlacement = ((valueFormatData >> 1) & 0x1) == 1; 
			 
			valueFormat.xAdvance = ((valueFormatData >> 2) & 0x1) == 1; 
			valueFormat.yAdvance = ((valueFormatData >> 3) & 0x1) == 1; 
			 
			valueFormat.xPlacementDevice = ((valueFormatData >> 4) & 0x1) == 1; 
			valueFormat.yPlacementDevice = ((valueFormatData >> 5) & 0x1) == 1; 
			 
			valueFormat.xAdvanceDevice = ((valueFormatData >> 6) & 0x1) == 1; 
			valueFormat.yAdvanceDevice = ((valueFormatData >> 7) & 0x1) == 1; 
			 
			return valueFormat; 
		} 
		 
	} 
} 
