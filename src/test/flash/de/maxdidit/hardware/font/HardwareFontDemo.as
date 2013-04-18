package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import flash.display.Sprite;
	
	/**
	 * This is a runnable demo class to test the HardwareFont class.
	 * 
	 * @author Max Knoblich
	 */
	public class HardwareFontDemo extends Sprite 
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontDemo() 
		{
			var hardwareFont:HardwareFont = new HardwareFont(new OpenTypeParser());
			hardwareFont.loadFont("newscycle-bold.ttf");
		}
		
	}

}