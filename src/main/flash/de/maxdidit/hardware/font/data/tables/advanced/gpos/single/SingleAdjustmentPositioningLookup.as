package de.maxdidit.hardware.font.data.tables.advanced.gpos.single 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueRecord;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.text.components.HardwareCharacterInstance;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleAdjustmentPositioningLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _value:ValueRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SingleAdjustmentPositioningLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get value():ValueRecord 
		{
			return _value;
		}
		
		public function set value(value:ValueRecord):void 
		{
			_value = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void 
		{
			(characterInstances.currentElement as HardwareCharacterInstance).applyAdjustmentValue(_value);
		}
	}

}