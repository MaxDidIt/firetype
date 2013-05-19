package de.maxdidit.hardware.font.parser.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.shared.ValueFormat;
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ValueFormatParser
	{
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ValueFormatParser() 
		{
			
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function parseValueFormat(valueFormatData:uint):ValueFormat
		{
			var valueFormat:ValueFormat = new ValueFormat();
			
			valueFormat.xPlacement = (valueFormatData & 0x1) == 1;
			valueFormat.yPlacement = ((valueFormatData >> 1) & 0x1) == 1;
			
			valueFormat.xAdvance = ((valueFormatData >> 2) & 0x1) == 1;
			valueFormat.yAdvance = ((valueFormatData >> 3) & 0x1) == 1;
			
			valueFormat.xPlacementDevice = ((valueFormatData >> 4) & 0x1) == 1;
			valueFormat.yPlacementDevice = ((valueFormatData >> 5) & 0x1) == 1;
			
			valueFormat.xAdvanceDevice = ((valueFormatData >> 6) & 0x1) == 1;
			valueFormat.yAdvanceDevice = ((valueFormatData >> 7) & 0x1) == 1;
			
			return valueFormat;
		}
		
	}

}