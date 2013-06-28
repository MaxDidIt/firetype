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
 
package de.maxdidit.hardware.text.renderer 
{ 
	import de.maxdidit.hardware.text.cache.HardwareTextFormatMap; 
	import de.maxdidit.hardware.text.cache.TextColorMap; 
	import de.maxdidit.hardware.text.format.HardwareTextFormat; 
	import de.maxdidit.hardware.text.format.TextColor; 
	import de.maxdidit.hardware.text.renderer.AGALMiniAssembler; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	import de.maxdidit.hardware.font.HardwareGlyph; 
	import de.maxdidit.hardware.font.triangulation.ITriangulator; 
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance; 
	import flash.display3D.Context3D; 
	import flash.display3D.Context3DProgramType; 
	import flash.display3D.Context3DVertexBufferFormat; 
	import flash.display3D.IndexBuffer3D; 
	import flash.display3D.Program3D; 
	import flash.display3D.VertexBuffer3D; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class SingleGlyphRenderer extends HardwareTextRenderer implements IHardwareTextRenderer 
	{ 
		/////////////////////// 
		// Constants 
		/////////////////////// 
		 
		/////////////////////// 
		// Member Fields 
		///////////////////////
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function SingleGlyphRenderer($context3d:Context3D, $triangulator:ITriangulator) 
		{
			super($context3d, $triangulator)
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		
		override protected function get fieldsPerVertex():uint 
		{
			return 3;
		}
		
		override protected function get vertexShaderCode():String 
		{
			return "m44 op, va0, vc0";
		}
		
		override protected function get fragmentShaderCode():String 
		{
			return "mov oc, fc0";
		}
		 
		/////////////////////// 
		// Member Functions 
		///////////////////////
		
		protected override function fitsIntoIndexBuffer(numberOfNewIndices:uint):Boolean 
		{ 
			var indexBufferSizeInBytes:uint = (_indexData.length + numberOfNewIndices) * 4; 
			return indexBufferSizeInBytes <= HardwareTextRenderer.MAX_INDEXBUFFER_BYTES; 
		}
		 
		protected override  function fitsIntoVertexBuffer(paths:Vector.<Vector.<Vertex>>):Boolean 
		{ 
			var numberOfVertices:uint = 0; 
			const l:uint = paths.length; 
			for (var i:uint = 0; i < l; i++) 
			{ 
				numberOfVertices += paths[i].length; 
			} 
			 
			var vertexBufferSizeInBytes:uint = (_vertexData.length + numberOfVertices) * fieldsPerVertex * 8; 
			return vertexBufferSizeInBytes <= HardwareTextRenderer.MAX_VERTEXBUFFER_BYTES; 
		}
		 
		protected override function addToIndexData(indices:Vector.<uint>, numVertices:uint):void 
		{ 
			const l:uint = indices.length; 
			 
			var index:uint = _indexData.length; 
			const newLength:uint = index + l; 
			 
			for (var j:uint = 0; j < l; j++) 
			{ 
				_indexData[index++] = indices[j]; 
			} 
		} 
		 
		protected override function addToVertexData(paths:Vector.<Vector.<Vertex>>, numVertices:uint):void 
		{ 
			const l:uint = paths.length; 
			 
			var index:uint = _vertexData.length; 
			const newLength:uint = index + l * fieldsPerVertex; 
			 
			_vertexData.length = newLength; 
			 
			for (var p:uint = 0; p < l; p++) 
			{ 
				var path:Vector.<Vertex> = paths[p]; 
				var pl:uint = path.length; 
				 
				for (var i:uint = 0; i < pl; i++) 
				{ 
					var vertex:Vertex = path[i]; 
					 
					_vertexData[index++] = vertex.x; 
					_vertexData[index++] = vertex.y; 
					_vertexData[index++] = 0; 
				} 
			} 
		} 
		 
		public override function render(instanceMap:Object, textColorMap:TextColorMap):void 
		{ 
			if (_buffersDirty) 
			{ 
				_vertexBuffer = _context3d.createVertexBuffer(_vertexData.length / fieldsPerVertex, fieldsPerVertex); 
				_vertexBuffer.uploadFromVector(_vertexData, 0, _vertexData.length / fieldsPerVertex); 
				 
				_indexBuffer = _context3d.createIndexBuffer(_indexData.length); 
				_indexBuffer.uploadFromVector(_indexData, 0, _indexData.length); 
				 
				_buffersDirty = false; 
			} 
			 
			var fallbackTextColor:TextColor = new TextColor(); 
			var textColor:TextColor = textColor; 
			_context3d.setProgram(programPair); 
			 
			_context3d.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3); 
			 
			for each (var font:Object in instanceMap) 
			{ 
				for each (var vertexDistance:Object in font) 
				{ 
					for (var colorId:String in vertexDistance) 
					{ 
						var color:Object = vertexDistance[colorId]; 
						 
						if (textColorMap.hasTextColorId(colorId)) 
						{ 
							textColor = textColorMap.getTextColorById(colorId); 
						} 
						else 
						{ 
							textColor = fallbackTextColor; 
						} 
						 
						_context3d.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, textColor.colorVector, 1); 
						 
						for each (var instances:Vector.<HardwareGlyphInstance>in color) 
						{ 
							var l:uint = instances.length; 
							for (var i:uint = 0; i < l; i++) 
							{ 
								var currentInstance:HardwareGlyphInstance = instances[i]; 
								 
								_context3d.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, currentInstance.globalTransformation, true); 
								_context3d.drawTriangles(_indexBuffer, currentInstance.hardwareGlyph.indexOffset, currentInstance.hardwareGlyph.numTriangles); 
							} 
						} 
					} 
				} 
			} 
		} 
		 
		public override function clear():void  
		{ 
			_vertexData.length = 0; 
			_indexData.length = 0; 
			 
			_vertexBuffer.dispose(); 
			_indexBuffer.dispose(); 
		} 
	} 
} 
