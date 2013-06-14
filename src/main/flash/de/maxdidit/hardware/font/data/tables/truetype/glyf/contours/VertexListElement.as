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
 
package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	import de.maxdidit.list.LinkedListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class VertexListElement extends LinkedListElement 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _vertex:Vertex;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function VertexListElement($vertex:Vertex) 
		{
			this.vertex = $vertex;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get vertex():Vertex 
		{
			return _vertex;
		}
		
		public function set vertex(value:Vertex):void 
		{
			_vertex = value;
		}
		
	}

}