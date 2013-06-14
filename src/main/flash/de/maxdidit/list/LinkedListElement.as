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
 
package de.maxdidit.list  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LinkedListElement implements ILinkedListElement 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _next:ILinkedListElement; 
		private var _previous:ILinkedListElement; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LinkedListElement()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// next 
		 
		public function get next():ILinkedListElement  
		{ 
			return _next; 
		} 
		 
		public function set next(value:ILinkedListElement):void  
		{ 
			_next = value; 
		} 
		 
		// previous 
		 
		public function get previous():ILinkedListElement  
		{ 
			return _previous; 
		} 
		 
		public function set previous(value:ILinkedListElement):void  
		{ 
			_previous = value; 
		} 
		 
	} 
} 
