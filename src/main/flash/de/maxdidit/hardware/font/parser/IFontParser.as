package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface IFontParser 
	{
		function parseFontData(data:ByteArray):HardwareFontData;
	}
	
}