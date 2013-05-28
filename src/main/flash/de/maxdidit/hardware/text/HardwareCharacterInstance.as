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
		
		private var _charCode:uint;
		
		private var _glyphID:uint;
		private var _glyphClass:uint;
		
		private var _leftBearing:int = 0;
		private var _rightBearing:int = 0;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterInstance($hardwareCharacter:HardwareCharacter) 
		{
			this._hardwareCharacter = $hardwareCharacter;
			if ($hardwareCharacter)
			{
				copyCharacterGlyphInstances();
			}
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
		
		public function get glyphID():uint
		{
			return _glyphID;
		}
		
		public function set glyphID(value:uint):void 
		{
			_glyphID = value;
		}
		
		public function get glyphClass():uint 
		{
			return _glyphClass;
		}
		
		public function set glyphClass(value:uint):void 
		{
			_glyphClass = value;
		}
		
		public function get charCode():uint 
		{
			return _charCode;
		}
		
		public function set charCode(value:uint):void 
		{
			_charCode = value;
		}
		
		public function get leftBearing():int 
		{
			return _leftBearing;
		}
		
		public function set leftBearing(value:int):void 
		{
			_leftBearing = value;
		}
		
		public function get rightBearing():int 
		{
			return _rightBearing;
		}
		
		public function set rightBearing(value:int):void 
		{
			_rightBearing = value;
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