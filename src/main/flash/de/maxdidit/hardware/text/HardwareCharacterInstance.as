package de.maxdidit.hardware.text 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareCharacterInstance extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _hardwareCharacter:HardwareCharacter;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterInstance($hardwareCharacter:HardwareCharacter) 
		{
			this._hardwareCharacter = $hardwareCharacter;
			copyCharacterGlyphInstances();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// hardwareCharacter
		
		public function get hardwareCharacter():HardwareCharacter 
		{
			return _hardwareCharacter;
		}
		
		public function set hardwareCharacter(value:HardwareCharacter):void 
		{
			_hardwareCharacter = value;
			copyCharacterGlyphInstances();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function registerGlyphInstances(uniqueIdentifier:String, subdivisions:uint, color:uint, cache:HardwareCharacterCache):void 
		{
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				cache.registerGlyphInstance(_children[i] as HardwareGlyphInstance, uniqueIdentifier, subdivisions, color);
			}
		}
		
		private function copyCharacterGlyphInstances():void 
		{
			loseAllChildren();
			
			var _instances:Vector.<HardwareGlyphInstance> = _hardwareCharacter.instances;
			
			const l:uint = _instances.length;
			for (var i:uint = 0; i < l; i++)
			{
				addChild(_instances[i].clone());
			}
		}
		
	}

}