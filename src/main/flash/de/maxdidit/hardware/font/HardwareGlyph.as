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
 
package de.maxdidit.hardware.font 
{ 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	import de.maxdidit.hardware.font.triangulation.ITriangulator; 
	import de.maxdidit.list.CircularLinkedList; 
	import de.maxdidit.list.elements.UnsignedIntegerListElement; 
	import de.maxdidit.math.AxisAlignedBoundingBox; 
	import flash.display3D.Context3D; 
	import flash.display3D.Context3DProgramType; 
	import flash.display3D.Context3DVertexBufferFormat; 
	import flash.display3D.IndexBuffer3D; 
	import flash.display3D.VertexBuffer3D; 
	import flash.geom.Matrix3D; 
	import flash.geom.Vector3D; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class HardwareGlyph 
	{
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _vertexOffset:uint; 
		private var _indexOffset:uint; 
		 
		private var _numTriangles:uint; 
		 
		private var _glyphIndex:uint; 
		private var _glyph:Glyph; 
		 
		private var _cacheSectionIndex:uint; 
		 
		// bounding box
		private var _boundingBox:AxisAlignedBoundingBox; 
		
		private var _vertices:Vector.<Vertex>;
		private var _indices:Vector.<uint>;
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function HardwareGlyph() 
		{ 
			_boundingBox = new AxisAlignedBoundingBox(); 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// vertexOffset 
		 
		public function get vertexOffset():uint 
		{ 
			return _vertexOffset; 
		} 
		 
		public function set vertexOffset(value:uint):void 
		{ 
			_vertexOffset = value; 
		} 
		 
		// indexOffset 
		 
		public function get indexOffset():uint 
		{ 
			return _indexOffset; 
		} 
		 
		public function set indexOffset(value:uint):void 
		{ 
			_indexOffset = value; 
		} 
		 
		// numTriangles 
		 
		public function get numTriangles():uint 
		{ 
			return _numTriangles; 
		} 
		 
		public function set numTriangles(value:uint):void 
		{ 
			_numTriangles = value; 
		} 
		 
		// bounding box 
		 
		public function get boundingBox():AxisAlignedBoundingBox 
		{ 
			return _boundingBox; 
		} 
		 
		public function set boundingBox(value:AxisAlignedBoundingBox):void 
		{ 
			_boundingBox = value; 
		} 
		 
		// index 
		 
		public function get glyphIndex():uint  
		{ 
			return _glyphIndex; 
		} 
		 
		public function set glyphIndex(value:uint):void  
		{ 
			_glyphIndex = value; 
		} 
		 
		public function get cacheSectionIndex():uint  
		{ 
			return _cacheSectionIndex; 
		} 
		 
		public function set cacheSectionIndex(value:uint):void  
		{ 
			_cacheSectionIndex = value; 
		} 
		 
		// glyph 
		 
		public function get glyph():Glyph  
		{ 
			return _glyph; 
		} 
		 
		public function set glyph(value:Glyph):void  
		{ 
			_glyph = value; 
		} 
		
		public function get indices():Vector.<uint>
		{
			return _indices;
		}
		
		public function set indices(value:Vector.<uint>):void 
		{
			_indices = value;
		}
		
		public function get vertices():Vector.<Vertex> 
		{
			return _vertices;
		}
		
		public function set vertices(value:Vector.<Vertex>):void 
		{
			_vertices = value;
		}
	 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
	 
	} 
} 
