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
		
		protected var _firstElement:LinkedListElement;
		protected var _lastElement:LinkedListElement;
		
		protected var _currentElement:LinkedListElement;
		
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
		
		public function get firstElement():LinkedListElement 
		{
			return _firstElement;
		}
		
		public function get lastElement():LinkedListElement 
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
		
		public function get currentElement():LinkedListElement 
		{
			return _currentElement;
		}
		
		public function set currentElement(value:LinkedListElement):void 
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
		
		public function addElement(element:LinkedListElement):void
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
		
		public function removeElement(element:LinkedListElement):void 
		{
			if (element == _firstElement)
			{
				_firstElement = element.next;
			}
			
			if (element == _lastElement)
			{
				_lastElement = element.previous;
			}
			
			element.previous.next = element.next;
			element.next.previous = element.previous;
			
			_numElements--;
		}
		
		public function addElementAfter(element:LinkedListElement, afterElement:LinkedListElement):void 
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