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
	
		//override public function retrieveHardwareCharacter(font:HardwareFont, subdivisions:uint, cache:HardwareCharacterCache):HardwareCharacter
		//{
		//var character:HardwareCharacter = new HardwareCharacter();
		//
		//const l:uint = _components.length;
		//for (var i:uint = 0; i < l; i++)
		//{
		//var currentComponent:CompositeGlyphComponent = _components[i];
		//
		//var glyphIndex:uint = currentComponent.glyphIndex;
		//var glyph:HardwareGlyph = cache.getCachedGlyph(font, subdivisions, glyphIndex);
		//var glyphInstance:HardwareGlyphInstance = new HardwareGlyphInstance(glyph);
		//
		//if (currentComponent.flags.argumentsAreXYValues)
		//{
		//glyphInstance.x += currentComponent.argument1;
		//glyphInstance.y += currentComponent.argument2;
		//}
		//else
		//{
		//throw new Error("Matching of points in composite glyphs not yet implemented.");
		//}
		//
		//character.glyph = this;
		//
		//glyphInstance.scaleX = currentComponent.mtxA;
		//glyphInstance.shearX = currentComponent.mtxB;
		//
		//glyphInstance.shearY = currentComponent.mtxC;
		//glyphInstance.scaleY = currentComponent.mtxD;
		//
		//character.addGlyphInstance(glyphInstance);
		//}
		//
		//return character;
		//}
	
	}

}