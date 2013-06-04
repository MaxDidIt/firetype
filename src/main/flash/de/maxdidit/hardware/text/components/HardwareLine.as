package de.maxdidit.hardware.text.components
{
	import de.maxdidit.hardware.text.TransformedInstance;
	import de.maxdidit.math.AxisAlignedBoundingBox;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareLine extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ascender:int;
		private var _descender:int;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareLine()
		{
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ascender():int
		{
			return _ascender;
		}
		
		public function set ascender(value:int):void
		{
			_ascender = value;
		}
		
		public function get descender():int
		{
			return _descender;
		}
		
		public function set descender(value:int):void
		{
			_descender = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function loseAllChildren():void
		{
			// clean up instances
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				var word:HardwareWord = _children.shift() as HardwareWord;
				word.loseAllChildren();
			}
		}
	}

}