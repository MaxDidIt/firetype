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
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.AnchorTable; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class EntryExitRecord  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _entryAnchorOffset:uint; 
		private var _entryAnchor:AnchorTable; 
		 
		private var _exitAnchorOffset:uint; 
		private var _exitAnchor:AnchorTable; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function EntryExitRecord()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get entryAnchorOffset():uint  
		{ 
			return _entryAnchorOffset; 
		} 
		 
		public function set entryAnchorOffset(value:uint):void  
		{ 
			_entryAnchorOffset = value; 
		} 
		 
		public function get entryAnchor():AnchorTable  
		{ 
			return _entryAnchor; 
		} 
		 
		public function set entryAnchor(value:AnchorTable):void  
		{ 
			_entryAnchor = value; 
		} 
		 
		public function get exitAnchorOffset():uint  
		{ 
			return _exitAnchorOffset; 
		} 
		 
		public function set exitAnchorOffset(value:uint):void  
		{ 
			_exitAnchorOffset = value; 
		} 
		 
		public function get exitAnchor():AnchorTable  
		{ 
			return _exitAnchor; 
		} 
		 
		public function set exitAnchor(value:AnchorTable):void  
		{ 
			_exitAnchor = value; 
		} 
		 
	} 
} 
