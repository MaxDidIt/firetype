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