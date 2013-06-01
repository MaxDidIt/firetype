package de.maxdidit.hardware.font.data.tables.truetype.glyf.composite 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.HardwareGlyphInstance;
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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CompositeGlyph() 
		{
			
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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function retrievePaths(subdivisions:uint):Vector.<Vector.<Vertex>> 
		{
			return null;
		}
		
		override public function retrieveHardwareCharacter(font:HardwareFont, subdivisions:uint, cache:HardwareCharacterCache):HardwareCharacter
		{
			var character:HardwareCharacter = new HardwareCharacter();
			
			const l:uint = _components.length;
			for (var i:uint = 0; i < l; i++)
			{
				var currentComponent:CompositeGlyphComponent = _components[i];
				
				var glyphIndex:uint = currentComponent.glyphIndex;
				var glyph:HardwareGlyph = cache.getCachedGlyph(font, subdivisions, glyphIndex);
				var glyphInstance:HardwareGlyphInstance = new HardwareGlyphInstance(glyph);
				
				if (currentComponent.flags.argumentsAreXYValues)
				{
					glyphInstance.x += currentComponent.argument1;
					glyphInstance.y += currentComponent.argument2;
				}
				else
				{
					throw new Error("Matching of points in composite glyphs not yet implemented.");
				}
				
				if (currentComponent.flags.useMyMetrics)
				{
					character.useMetricsOfIndex = i;
				}
				
				glyphInstance.scaleX = currentComponent.mtxA;
				glyphInstance.shearX = currentComponent.mtxB;
				
				glyphInstance.shearY = currentComponent.mtxC;
				glyphInstance.scaleY = currentComponent.mtxD;
				
				character.addGlyphInstance(glyphInstance);
			}
			
			return character;
		}
		
	}

}