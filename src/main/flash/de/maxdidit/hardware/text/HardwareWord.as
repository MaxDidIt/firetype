package de.maxdidit.hardware.text 
{
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
		
		public function initialize(string:String, fontFormat:HardwareFontFormat, cache:HardwareCharacterCache):void 
		{
			const l:uint = string.length;
			
			var x:Number = 0;
			
			loseAllChildren();
			_boundingBox.setValues(0, 0, 0, 0);
			
			for (var i:uint = 0; i < l; i++)
			{
				var charCode:uint = string.charCodeAt(i);
				
				var character:HardwareCharacter = cache.getCachedCharacter(fontFormat.font, fontFormat.subdivisions, charCode);
				var characterInstance:HardwareCharacterInstance = new HardwareCharacterInstance(character);
				characterInstance.registerGlyphInstances(fontFormat.font.uniqueIdentifier, fontFormat.subdivisions, fontFormat.color, cache);
				
				characterInstance.x = x;
				x += character.boundingBox.right;
				
				_boundingBox.expandTopBottom(character.boundingBox);
				
				addChild(characterInstance);
			}
			
			_boundingBox.right = x + character.boundingBox.right;
		}
		
	}

}