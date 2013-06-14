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
 
package de.maxdidit.list 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LinkedList 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		protected var _firstElement:ILinkedListElement;
		protected var _lastElement:ILinkedListElement;
		
		protected var _currentElement:ILinkedListElement;
		
		protected var _numElements:uint = 0;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LinkedList() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get firstElement():ILinkedListElement 
		{
			return _firstElement;
		}
		
		public function get lastElement():ILinkedListElement 
		{
			return _lastElement;
		}
		
		// numElements
		
		public function get numElements():uint
		{
			return _numElements;
		}
		
		public function set numElements(value:uint):void 
		{
			_numElements = value;
		}
		
		// currentElement
		
		public function get currentElement():ILinkedListElement 
		{
			return _currentElement;
		}
		
		public function set currentElement(value:ILinkedListElement):void 
		{
			_currentElement = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function gotoFirstElement():void
		{
			_currentElement = _firstElement;
		}
		
		public function gotoNextElement():void
		{
			if (_currentElement)
			{
				_currentElement = _currentElement.next;
			}
		}
		
		public function gotoPreviousElement():void
		{
			if (_currentElement)
			{
				_currentElement = _currentElement.previous;
			}
		}
		
		public function addElement(element:ILinkedListElement):void
		{
			if (!_firstElement)
			{
				_firstElement = element;
			}
			
			if (_lastElement)
			{
				_lastElement.next = element;
				element.previous = _lastElement;
			}
			
			_lastElement = element;
			
			_numElements++;
		}
		
		public function removeElement(element:ILinkedListElement):void 
		{
			if (element == _firstElement)
			{
				_firstElement = element.next;
			}
			
			if (element == _lastElement)
			{
				_lastElement = element.previous;
			}
			
			if(element.previous)
			{
				element.previous.next = element.next;
			}
			
			if (element.next)
			{
				element.next.previous = element.previous;
			}
			
			_numElements--;
		}
		
		public function addElementAfter(element:ILinkedListElement, afterElement:ILinkedListElement):void 
		{
			if (afterElement == _lastElement)
			{
				_lastElement = afterElement;
			}
			
			element.previous = afterElement;
			element.next = afterElement.next;
			
			afterElement.next.previous = element;
			afterElement.next = element;
			
			_numElements++;
		}
	}

}