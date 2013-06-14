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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class AttachmentPointTableData  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _pointCount:uint; 
		private var _pointIndices:Vector.<uint>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function AttachmentPointTableData()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		// pointCount 
		 
		public function get pointCount():uint  
		{ 
			return _pointCount; 
		} 
		 
		public function set pointCount(value:uint):void  
		{ 
			_pointCount = value; 
		} 
		 
		// pointIndices 
		 
		public function get pointIndices():Vector.<uint>  
		{ 
			return _pointIndices; 
		} 
		 
		public function set pointIndices(value:Vector.<uint>):void  
		{ 
			_pointIndices = value; 
		} 
		 
	} 
} 
