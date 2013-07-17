package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.text.starling.FiretypeStarlingTextField;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeStarlingGame extends Sprite
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeStarlingGame()
		{
			var circle1:Image = createCircle(0xFFEE66);
			addChild(circle1);
			
			var text:FiretypeStarlingTextField = new FiretypeStarlingTextField();
			text.text = "This text has been rendered in <format color='0xFFFF0000'>Starling</format> via <format color='0xFFFF6611'>firetype</format>.";
			text.x = 100;
			text.y = 100;
			text.width = 300;
			text.color = 0xFF666666;
			addChild(text);
			
			var circle2:Image = createCircle(0xEEFF66);
			circle2.x = 250;
			circle2.y = 280;
			addChild(circle2);
			
			var circle3:Image = createCircle(0x99EEFF);
			circle3.x = 300;
			circle3.y = 340;
			addChild(circle3);
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function createCircle(color:uint):Image
		{
			// source: http://wiki.starling-framework.org/manual/dynamic_textures
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(100, 100, 60);
			shape.graphics.endFill();
			shape.filters = [new DropShadowFilter()];
			
			var bmpData:BitmapData = new BitmapData(200, 200, true, 0x0);
			bmpData.draw(shape);
			
			var texture:Texture = Texture.fromBitmapData(bmpData);
			var image:Image = new Image(texture);
			return image;
		}
	
	}

}