package de.maxdidit.list 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CircularLinkedList 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _firstElement:LinkedListElement;
		private var _lastElement:LinkedListElement;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CircularLinkedList() 
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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addElement(element:LinkedListElement):void
		{
			if (!_firstElement)
			{
				_firstElement = element;
			}
			
			if (!_lastElement)
			{
				_lastElement = element;
			}
			
			_lastElement.next = element;
			element.previous = _lastElement;
			element.next = _firstElement;
			
			_lastElement = element;
		}
		
	}

}