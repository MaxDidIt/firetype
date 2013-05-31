package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.HardwareCharacter;
	import de.maxdidit.math.AxisAlignedBoundingBox;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareWord extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _boundingBox:AxisAlignedBoundingBox;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareWord()
		{
			_boundingBox = new AxisAlignedBoundingBox();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get boundingBox():AxisAlignedBoundingBox
		{
			return _boundingBox;
		}
		
		public function set boundingBox(value:AxisAlignedBoundingBox):void
		{
			_boundingBox = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function initialize(string:String, fontFormat:HardwareTextFormat, cache:HardwareCharacterCache, firstWord:Boolean):void
		{
			const l:uint = string.length;
			
			var x:Number = 0;
			
			loseAllChildren();
			_boundingBox.setValues(0, 0, 0, 0);
			
			// don't render whitespace at the start of a line
			if (/\s/.test(string) && firstWord)
			{
				return;
			}
			
			// don't render new line characters
			if (/\n/.test(string))
			{
				return;
			}
			
			for (var i:uint = 0; i < l; i++)
			{
				var charCode:uint = string.charCodeAt(i);
				var index:uint = fontFormat.font.getGlyphIndex(charCode);
				var leftBearing:int = fontFormat.font.getGlyphLeftSideBearing(index);
				
				var character:HardwareCharacter = cache.getCachedCharacter(fontFormat.font, fontFormat.subdivisions, charCode);
				
				if (character)
				{
					var characterInstance:HardwareCharacterInstance = new HardwareCharacterInstance(character);
					characterInstance.registerGlyphInstances(fontFormat.font.uniqueIdentifier, fontFormat.subdivisions, fontFormat.color, cache);
				
					characterInstance.x = x
					if (!firstWord)
					{
						characterInstance.x += leftBearing;
					}
					_boundingBox.expandTopBottom(character.boundingBox);
					
					addChild(characterInstance);
				}
				
				x += fontFormat.font.getGlyphAdvanceWidth(index);
				if (firstWord)
				{
					x -= leftBearing;
				}
			}
			
			_boundingBox.right = x;
		}
		
		public function loseCharacters():void 
		{
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				var instance:HardwareCharacterInstance = _children[i] as HardwareCharacterInstance;
				HardwareCharacterInstance.returnHardwareCharacterInstance(instance);
			}
		}
	
	}

}