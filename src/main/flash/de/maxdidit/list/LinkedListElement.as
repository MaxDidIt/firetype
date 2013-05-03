package de.maxdidit.list 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LinkedListElement 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _next:LinkedListElement;
		private var _previous:LinkedListElement;
		
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
		
		public function get next():LinkedListElement 
		{
			return _next;
		}
		
		public function set next(value:LinkedListElement):void 
		{
			_next = value;
		}
		
		// previous
		
		public function get previous():LinkedListElement 
		{
			return _previous;
		}
		
		public function set previous(value:LinkedListElement):void 
		{
			_previous = value;
		}
		
	}

}