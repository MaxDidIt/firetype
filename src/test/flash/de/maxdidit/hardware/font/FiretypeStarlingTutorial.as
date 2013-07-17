package de.maxdidit.hardware.font 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeStarlingTutorial extends Sprite 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _starling:Starling;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeStarlingTutorial() 
		{
			_starling = new Starling(FiretypeStarlingGame, stage);
			_starling.antiAliasing = 8;
			_starling.start();
		}
		
	}

}