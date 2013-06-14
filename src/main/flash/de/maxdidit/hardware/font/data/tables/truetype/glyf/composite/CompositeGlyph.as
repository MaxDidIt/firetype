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
 
package de.maxdidit.hardware.font.data.tables.truetype.glyf.composite 
{ 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph; 
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.GlyphTableData; 
	import de.maxdidit.hardware.font.HardwareFont; 
	import de.maxdidit.hardware.font.HardwareGlyph; 
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache; 
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class CompositeGlyph extends Glyph 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _components:Vector.<CompositeGlyphComponent>; 
		 
		private var _numInstructions:uint; 
		private var _instructions:ByteArray; 
		 
		private var _indexForMetrics:int; 
		private var _dependencies:Vector.<Glyph>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function CompositeGlyph() 
		{ 
			_dependencies = new Vector.<Glyph>(); 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		// components 
		 
		public function get components():Vector.<CompositeGlyphComponent> 
		{ 
			return _components; 
		} 
		 
		public function set components(value:Vector.<CompositeGlyphComponent>):void 
		{ 
			_components = value; 
		} 
		 
		// numInstructions 
		 
		public function get numInstructions():uint 
		{ 
			return _numInstructions; 
		} 
		 
		public function set numInstructions(value:uint):void 
		{ 
			_numInstructions = value; 
		} 
		 
		// instructions 
		 
		public function get instructions():ByteArray 
		{ 
			return _instructions; 
		} 
		 
		public function set instructions(value:ByteArray):void 
		{ 
			_instructions = value; 
		} 
		 
		override public function get leftSideBearing():int 
		{ 
			if (_indexForMetrics == -1 || _indexForMetrics >= _dependencies.length) 
			{ 
				return super.leftSideBearing; 
			} 
			 
			return _dependencies[_indexForMetrics].leftSideBearing; 
		} 
		 
		override public function get advanceWidth():uint 
		{ 
			if (_indexForMetrics == -1 || _indexForMetrics >= _dependencies.length) 
			{ 
				return super.advanceWidth; 
			} 
			 
			return _dependencies[_indexForMetrics].advanceWidth; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		override public function resolveDependencies(glyphTableData:GlyphTableData):void 
		{ 
			const l:uint = _components.length; 
			 
			_dependencies.length = l; 
			_indexForMetrics = -1; 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var component:CompositeGlyphComponent = _components[i]; 
				_dependencies[i] = glyphTableData.retrieveGlyph(component.glyphIndex); 
				 
				if (component.flags.useMyMetrics) 
				{ 
					_indexForMetrics = i; 
				} 
			} 
		} 
		 
		override public function retrieveGlyphInstances(instances:Vector.<HardwareGlyphInstance>):void 
		{ 
			const l:uint = _components.length; 
			 
			for (var i:uint = 0; i < l; i++) 
			{ 
				var component:CompositeGlyphComponent = _components[i]; 
				var glyph:Glyph = _dependencies[i]; 
				 
				glyph.retrieveGlyphInstances(instances); 
				 
				var instance:HardwareGlyphInstance = instances[instances.length - 1]; 
				 
				if (component.flags.argumentsAreXYValues) 
				{ 
					instance.x += component.argument1; 
					instance.y += component.argument2; 
				} 
				else 
				{ 
					throw new Error("Matching of points in composite glyphs not yet implemented."); 
				} 
				 
				instance.scaleX = component.mtxA; 
				instance.shearX = component.mtxB; 
				 
				instance.shearY = component.mtxC; 
				instance.scaleY = component.mtxD; 
			} 
		} 
	 
	} 
} 
