package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.text.format.TextAlign;
	import de.maxdidit.hardware.text.HardwareText;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeTutorial2 extends Sprite 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _context3d:Context3D;
		private var _hardwareText:HardwareText;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeTutorial2() 
		{
			// stage properties
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.frameRate = 60;
			
			// init stage3d
			var stage3d:Stage3D = this.stage.stage3Ds[0];
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
			stage3d.addEventListener(ErrorEvent.ERROR, handleContextCreationError);
			stage3d.requestContext3D(Context3DRenderMode.AUTO);
		}
		
		private function initializeView():void 
		{
			_context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, false);
			
			// Create very basic, orthogonal projection matrix.
			var viewProjectionRawData:Vector.<Number> = new Vector.<Number>();
			viewProjectionRawData.push(	2 / stage.stageWidth, 0, 0, 0, //
										0, 2 / stage.stageHeight, 0, 0, //
										0, 0, -2, -1, //
										0, 0, 0, 1);
			
			var viewProjection:Matrix3D = new Matrix3D(viewProjectionRawData);
			
			_hardwareText.calculateTransformations(viewProjection, true);
		}
		
		private function initializeText():void 
		{
			_hardwareText = new HardwareText(_context3d);
			
			_hardwareText.scaleX = _hardwareText.scaleY = 0.013;
			_hardwareText.x = -320;
			_hardwareText.y = 325;
			_hardwareText.width = 640;
			
			_hardwareText.text = "You can <format scale='0.66'>scale sections of a text</format> with the <format color='0xFF0000'>scale</format> attribute.\n\n";
			_hardwareText.text += "You can <format color='0xFF6611'>change the text color</format> with the <format color='0xFF0000'>color</format> attribute.\n\n";
			_hardwareText.text += "You can <format shearX='0.3'>slant a portion of a text</format> with the <format color='0xFF0000'>shearX</format> attribute.\n\n";
			_hardwareText.text += "You can make characters appear\n<format scale='1.5' vertexDistance='3000'>edged</format> (vertexDistance='3000') or\n<format scale='1.5' vertexDistance='50'>smooth</format> (vertexDistance='50') with the <format color='0xFF0000'>vertexDistance</format> attribute. Lower vertexDistance values will have an impact on performance.\n\n";
			_hardwareText.text += "<format textAlign='" + TextAlign.RIGHT + "'>You can set the text alignment with the <format color='0xFF0000'>textAlign</format> attribute. You should use the constants of the TextAlign class as values for the attribute.\n</format>\n";
		}
		
		///////////////////////
		// Event Handler
		///////////////////////
		
		private function handleContextCreationError(e:ErrorEvent):void 
		{
			// Something went wrong.
		}
		
		private function handleContextCreated(e:Event):void 
		{
			_context3d = (e.target as Stage3D).context3D;
			
			initializeText();
			initializeView();
			
			// react to resizing the stage
			this.stage.addEventListener(Event.RESIZE, handleResize);
			
			// Set up the update loop.
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function handleResize(e:Event):void 
		{
			// The view has been scaled, re-initialize the backbuffer and the projection matrix.
			initializeView();
		}
		
		private function update(e:Event):void 
		{
			// Clear the backbuffer, render the text and then display it.
			_context3d.clear(1, 1, 1);
			
			_hardwareText.cache.render();
			
			_context3d.present();
		}
	}

}