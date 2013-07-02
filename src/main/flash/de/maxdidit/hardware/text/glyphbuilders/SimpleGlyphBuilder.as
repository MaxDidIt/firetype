package de.maxdidit.hardware.text.glyphbuilders 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SimpleGlyphBuilder implements IGlyphBuilder
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _triangulator:ITriangulator;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SimpleGlyphBuilder(triangulator:ITriangulator) 
		{
			this.triangulator = triangulator;
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get triangulator():ITriangulator 
		{
			return _triangulator;
		}
		
		public function set triangulator(value:ITriangulator):void 
		{
			_triangulator = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.text.glyphbuilders.IGlyphBuilders */
		
		public function buildGlyph(paths:Vector.<Vector.<Vertex>>, originalPaths:Vector.<Vector.<Vertex>>):HardwareGlyph 
		{
			// 
			var result:HardwareGlyph = new HardwareGlyph();
			
			// indices
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();
			var indices:Vector.<uint> = new Vector.<uint>();
			
			// triangulate paths 
			var numVertices:uint = 0;
			var numTriangles:uint = 0;
			
			var vertexIndex:uint = 0;
			
			const l:uint = paths.length;
			for (var i:uint = 0; i < l; i++)
			{
				var path:Vector.<Vertex> = paths[i];
				
				numTriangles += _triangulator.triangulatePath(path, indices, numVertices);
				numVertices += path.length;
				
				var vl:uint = path.length;
				vertices.length += vl;
				for (var j:uint = 0; j < vl; j++)
				{
					vertices[vertexIndex++] = path[j];
				}
			}
			
			result.vertices = vertices;
			result.indices = indices;
			
			return result;
		}
	}

}