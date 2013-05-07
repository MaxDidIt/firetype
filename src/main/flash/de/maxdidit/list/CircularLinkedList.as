package de.maxdidit.list 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.VertexListElement;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.list.elements.UnsignedIntegerListElement;
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
		
		private var _numElements:uint = 0;
		
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
		
		// numElements
		
		public function get numElements():uint
		{
			return _numElements;
		}
		
		public function set numElements(value:uint):void 
		{
			_numElements = value;
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
			_firstElement.previous = lastElement;
			
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