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