package de.maxdidit.hardware.text.components
{
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.TransformedInstance;
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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareWord()
		{
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function loseAllChildren():void 
		{
			// clean up instances
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				var character:HardwareCharacterInstance = _children.shift() as HardwareCharacterInstance;
				character.loseAllChildren();
				HardwareCharacterInstance.returnHardwareCharacterInstance(character);
			}
		}
	
	}

}