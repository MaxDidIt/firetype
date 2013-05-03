package de.maxdidit.hardware.font.parser.tables.truetype.contours
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Contour;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Curve;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.IPathSegment;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Line;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.VertexListElement;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.SimpleGlyphFlags;
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
				
				for (i; i <= endPoint; i++)
				{
					var vertex:Vertex = new Vertex(xCoordinates[i], yCoordinates[i], flags[i].onCurve);
					vertices.addElement(new VertexListElement(vertex));
				}
				
				contour.vertices = vertices;
				contour.segments = parseContourSegments(vertices);
				result[c] = contour;
			}
			
			return result;
		}
		
		private function parseContourSegments(vertices:CircularLinkedList):Vector.<IPathSegment>
		{
			var result:Vector.<IPathSegment> = new Vector.<IPathSegment>();
			
			var startVertex:VertexListElement = getStartVertex(vertices);
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