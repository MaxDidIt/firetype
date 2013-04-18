package de.maxdidit.hardware.font
{
	import org.flexunit.rules.IMethodRule;
	import org.mockito.integrations.flexunit4.MockitoRule;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	
	public class HardwareFontTest
	{
		///////////////////////
		// Rules
		///////////////////////
		
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _hardwareFont:HardwareFont;
		
		///////////////////////
		// Start Up
		///////////////////////
		
		[Before]
		
		public function startUp():void
		{
			//_hardwareFont = new HardwareFont();
		}
		
		///////////////////////
		// Tear Down
		///////////////////////
		
		[After]
		
		public function tearDown():void
		{
			//_hardwareFont = null;
		}
		
		///////////////////////
		// Unit Tests
		///////////////////////
		
		[Test]
		
		public function testLoadFont():void
		{
			
		}
	
	}

}