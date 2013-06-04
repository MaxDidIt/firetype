package de.maxdidit.list 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.VertexListElement;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.list.elements.UnsignedIntegerListElement;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CircularLinkedList extends LinkedList
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CircularLinkedList() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function addElement(element:ILinkedListElement):void 
		{
			super.addElement(element);
			
			// close the circle
			_lastElement.next = _firstElement;
			_firstElement.previous = _lastElement;
		}
		
	}

}