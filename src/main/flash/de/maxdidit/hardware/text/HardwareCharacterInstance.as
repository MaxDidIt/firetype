package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareCharacterInstance extends TransformedInstance
	{
		///////////////////////
		// Static Variables
		///////////////////////
		
		private static var _pool:LinkedList = new LinkedList();
		
		///////////////////////
		// Static Functions
		///////////////////////
		
		public static function getHardwareCharacterInstance(hardwareCharacter:HardwareCharacter):HardwareCharacterInstance
		{
			var instance:HardwareCharacterInstance;
			
			if (_pool.firstElement)
			{
				var element:HardwareCharacterInstanceListElement = _pool.firstElement as HardwareCharacterInstanceListElement;
				instance = element.hardwareCharacterInstance;
				instance.hardwareCharacter = hardwareCharacter;
				
				instance.advanceWidthAdjustment = 0;
				instance.x = 0;
				instance.y = 0;
				
				_pool.removeElement(element);
			}
			else
			{
				instance = new HardwareCharacterInstance(hardwareCharacter);
			}
			
			return instance;
		}
		
		public static function returnHardwareCharacterInstance(instance:HardwareCharacterInstance):void
		{
			var element:HardwareCharacterInstanceListElement = new HardwareCharacterInstanceListElement(instance);
			_pool.addElement(element);
		}
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _hardwareCharacter:HardwareCharacter;
		
		private var _charCode:uint;
		
		private var _glyphID:uint;
		private var _glyphClass:uint;
		
		private var _advanceWidthAdjustment:int = 0;
		
		private var _formatID:String;
		private var _formatClosed:Boolean = false;
		
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
		
		public function get advanceWidthAdjustment():int
		{
			return _advanceWidthAdjustment;
		}
		
		public function set advanceWidthAdjustment(value:int):void
		{
			_advanceWidthAdjustment = value;
		}
		
		public function get formatID():String 
		{
			return _formatID;
		}
		
		public function set formatID(value:String):void 
		{
			_formatID = value;
		}
		
		public function get formatClosed():Boolean 
		{
			return _formatClosed;
		}
		
		public function set formatClosed(value:Boolean):void 
		{
			_formatClosed = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function registerGlyphInstances(uniqueIdentifier:String, subdivisions:uint, textFormat:HardwareTextFormat, cache:HardwareCharacterCache):void
		{
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				cache.registerGlyphInstance(_children[i] as HardwareGlyphInstance, uniqueIdentifier, subdivisions, textFormat);
			}
		}
		
		public function applyPositionAdjustmentValue(value:ValueRecord):void
		{
			_advanceWidthAdjustment += value.xAdvance;
			x += value.xPlacement;
		}
		
		private function copyCharacterGlyphInstances():void
		{
			loseAllChildren();
			
			if (!_hardwareCharacter)
			{
				return;
			}
			
			var _instances:Vector.<HardwareGlyphInstance> = _hardwareCharacter.instances;
			
			const l:uint = _instances.length;
			for (var i:uint = 0; i < l; i++)
			{
				addChild(_instances[i].clone());
			}
		}
	
	}

}