package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface IFontParser 
	{
		function parseFont(data:ByteArray):HardwareFont;
	}
	
}