package de.maxdidit.hardware.text.components 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.TransformedInstance;
	import de.maxdidit.list.ILinkedListElement;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.list.LinkedListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareCharacterInstance extends TransformedInstance implements ILinkedListElement 
	{
		///////////////////////
		// Static Variables
		///////////////////////
		
		private static var _pool:LinkedList = new LinkedList();
		
		///////////////////////
		// Static Functions
		///////////////////////
		
		public static function getHardwareCharacterInstance():HardwareCharacterInstance
		{
			var instance:HardwareCharacterInstance;
			
			if (_pool.firstElement)
			{
				instance = _pool.firstElement as HardwareCharacterInstance;
				_pool.removeElement(instance);
				
				instance.advanceWidthAdjustment = //
				instance.charCode = 0;
				
				instance.glyph = null;
				instance.next = null;
				instance.previous = null;
			}
			else
			{
				instance = new HardwareCharacterInstance();
			}
			
			return instance;
		}
		
		public static function returnHardwareCharacterInstance(instance:HardwareCharacterInstance):void
		{
			_pool.addElement(instance);
		}
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _next:ILinkedListElement;
		private var _previous:ILinkedListElement;
		
		private var _glyph:Glyph;
		
		private var _charCode:uint;
		
		private var _textFormat:HardwareTextFormat;
		
		private var _advanceWidthAdjustment:int;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacterInstance() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.list.ILinkedListElement */
		
		public function get next():ILinkedListElement 
		{
			return _next;
		}
		
		public function set next(value:ILinkedListElement):void 
		{
			_next = value;
		}
		
		public function get previous():ILinkedListElement 
		{
			return _previous;
		}
		
		public function set previous(value:ILinkedListElement):void 
		{
			_previous = value;
		}
		
		public function get glyph():Glyph 
		{
			return _glyph;
		}
		
		public function set glyph(value:Glyph):void 
		{
			_glyph = value;
		}
		
		public function get charCode():uint 
		{
			return _charCode;
		}
		
		public function set charCode(value:uint):void 
		{
			_charCode = value;
		}
		
		private function get textFormat():HardwareTextFormat 
		{
			return _textFormat;
		}
		
		private function set textFormat(value:HardwareTextFormat):void 
		{
			_textFormat = value;
		}
		
		public function get advanceWidthAdjustment():int 
		{
			return _advanceWidthAdjustment;
		}
		
		public function set advanceWidthAdjustment(value:int):void 
		{
			_advanceWidthAdjustment = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function applyAdjustmentValue(value:ValueRecord):void 
		{
			this.x += value.xPlacement;
			this._advanceWidthAdjustment = value.xAdvance;
		}
		
		override public function loseAllChildren():void 
		{
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				var glyphInstance:HardwareGlyphInstance = _children.shift() as HardwareGlyphInstance;
				glyphInstance.loseAllChildren();
				HardwareGlyphInstance.returnHardwareGlyphInstance(glyphInstance);
			}
		}
		
	}

}