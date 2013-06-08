package de.maxdidit.hardware.text.layout 
{
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.components.TextSpan;
	import de.maxdidit.hardware.text.HardwareText;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ILayout 
	{
		function layout(hardwareText:HardwareText, textSpans:Vector.<TextSpan>, cache:HardwareCharacterCache):void
	}
	
}