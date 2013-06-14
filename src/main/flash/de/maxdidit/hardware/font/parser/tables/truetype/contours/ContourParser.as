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
 
package de.maxdidit.hardware.font.parser.tables.truetype.contours 
{ 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Contour; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Curve; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.IPathSegment; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Line; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.VertexListElement; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.simple.SimpleGlyphFlags; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import de.maxdidit.list.CircularLinkedList; 
	import de.maxdidit.list.LinkedListElement; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ContourParser 
	{ 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ContourParser() 
		{ 
		 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		public function parseContours(xCoordinates:Vector.<int>, yCoordinates:Vector.<int>, endPointsOfContours:Vector.<uint>, flags:Vector.<SimpleGlyphFlags>):Vector.<Contour> 
		{ 
			const l:uint = endPointsOfContours.length; 
			var result:Vector.<Contour> = new Vector.<Contour>(l); 
			 
			var i:uint = 0; 
			for (var c:uint = 0; c < l; c++) 
			{ 
				var endPoint:uint = endPointsOfContours[c]; 
				var contour:Contour = new Contour(); 
				var vertices:CircularLinkedList = new CircularLinkedList; 
				 
				// There seems to be only one point in this contour. Skip it. 
				if (i == endPoint) 
				{ 
					result[c] = contour; 
					i++; 
					continue; 
				} 
				 
				// the endpoints suggest more coordinates than are available (WTF?) 
				if (i >= xCoordinates.length) 
				{ 
					result[c] = contour; 
					result.length = c + 1; 
					return result; 
				} 
				 
				if (i >= yCoordinates.length) 
				{ 
					result[c] = contour; 
					result.length = c + 1; 
					return result; 
				} 
				 
				// actually compile vertices 
				for (i; i <= endPoint; i++) 
				{ 
					var vertex:Vertex = new Vertex(xCoordinates[i], yCoordinates[i], flags[i].onCurve); 
					vertices.addElement(new VertexListElement(vertex)); 
				} 
				 
				addImplicitVertices(vertices); 
				contour.vertices = vertices; 
				contour.segments = parseContourSegments(vertices); 
				result[c] = contour; 
			} 
			 
			return result; 
		} 
		 
		private function addImplicitVertices(vertices:CircularLinkedList):void 
		{ 
			var currentVertex:VertexListElement = vertices.firstElement as VertexListElement; 
			 
			do 
			{ 
				var nextVertex:VertexListElement = currentVertex.next as VertexListElement; 
				 
				if (!currentVertex.vertex.onCurve && !nextVertex.vertex.onCurve) 
				{ 
					var newVertex:Vertex = new Vertex((currentVertex.vertex.x + nextVertex.vertex.x) / 2, // 
						(currentVertex.vertex.y + nextVertex.vertex.y) / 2); 
					vertices.addElementAfter(new VertexListElement(newVertex), currentVertex); 
				} 
				 
				currentVertex = nextVertex; 
			} while (currentVertex != vertices.firstElement); 
		} 
		 
		private function parseContourSegments(vertices:CircularLinkedList):Vector.<IPathSegment> 
		{ 
			var result:Vector.<IPathSegment> = new Vector.<IPathSegment>(); 
			 
			var startVertex:VertexListElement = getStartVertex(vertices); 
			if (!startVertex) 
			{ 
				throw new Error("Unable to find start vertex in contour of glyph."); 
			} 
			 
			var thisVertex:VertexListElement = startVertex; 
			var nextVertex:VertexListElement; 
			 
			do 
			{ 
				nextVertex = thisVertex.next as VertexListElement; 
				 
				// parse segment 
				var segment:IPathSegment; 
				 
				if (nextVertex.vertex.onCurve) 
				{ 
					var line:Line = new Line(thisVertex.vertex, nextVertex.vertex); 
					segment = line; 
				} 
				else 
				{ 
					var controlPoints:Vector.<Vertex> = new Vector.<Vertex>(); 
					controlPoints.push(thisVertex.vertex); 
					 
					do 
					{ 
						nextVertex = thisVertex.next as VertexListElement; 
						controlPoints.push(nextVertex.vertex); 
						thisVertex = nextVertex; 
					} while (!nextVertex.vertex.onCurve); 
					 
					var curve:Curve = new Curve(controlPoints); 
					segment = curve; 
				} 
				 
				result.push(segment); 
				 
				// iterate over list 
				thisVertex = nextVertex; 
			} while (thisVertex != startVertex); 
			 
			return result; 
		} 
		 
		private function getStartVertex(vertices:CircularLinkedList):VertexListElement 
		{ 
			var result:VertexListElement = vertices.firstElement as VertexListElement; 
			 
			while (!result.vertex.onCurve) 
			{ 
				if (result == vertices.lastElement) 
				{ 
					// end of list reached, none of the vertices are on the curve, exit. 
					return null; 
				} 
				 
				result = result.next as VertexListElement; 
			} 
			 
			return result; 
		} 
		 
		private function getNextVertex(vertices:Vector.<Vertex>, i:uint):Vertex 
		{ 
			if (i + 1 < vertices.length) 
			{ 
				return vertices[i + 1]; 
			} 
			 
			return vertices[0]; 
		} 
	 
	} 
} 
