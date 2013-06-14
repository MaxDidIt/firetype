/* 
Copyright ©2013 Max Knoblich 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRendererFactory;
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
	public class FiretypeTutorial6 extends Sprite 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _context3d:Context3D;
		private var _hardwareText:HardwareText;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeTutorial6() 
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
			var cache:HardwareCharacterCache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d, new EarClippingTriangulator()));
			_hardwareText = new HardwareText(null, cache);
			
			_hardwareText.scaleX = _hardwareText.scaleY = 0.013;
			_hardwareText.x = -320;
			_hardwareText.y = 300;
			_hardwareText.width = 640;
			
			_hardwareText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris scelerisque turpis non sem placerat vehicula. In at viverra nunc, ac pulvinar enim. Praesent pulvinar ac leo sed aliquet. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis scelerisque tincidunt suscipit. Maecenas ac ipsum cursus, rutrum turpis ac, ultricies magna. Quisque sagittis nunc a sagittis feugiat. Etiam tincidunt sit amet lectus a elementum. Vivamus est nisi, tincidunt eget sem non, mattis convallis lorem. Aliquam eu ultrices felis. Maecenas facilisis magna dui, aliquam ornare nisi feugiat vel.\n\n" + 
								"Pellentesque sed accumsan purus. Mauris at porta nunc. In elementum nisl quis nibh facilisis, et euismod nisl eleifend. Ut ac lorem urna. Vestibulum auctor massa quis mi faucibus ultrices. Donec leo magna, egestas et imperdiet in, blandit in ipsum. Pellentesque tempus massa sit amet nunc blandit laoreet. Curabitur feugiat, enim pulvinar venenatis egestas, urna arcu ornare risus, in interdum velit nunc ut leo. Nullam iaculis luctus orci ac faucibus. Nunc vehicula, magna id consequat placerat, tortor ipsum tincidunt leo, eget ultricies leo lectus rutrum eros. Praesent quis elit tellus. Integer lectus est, convallis in eros ac, elementum tincidunt dolor. Vivamus rutrum ullamcorper odio, sed laoreet neque sollicitudin vel. Nulla sagittis, purus et blandit blandit, quam lectus rhoncus erat, vel gravida diam nisl id dolor. Nullam et pretium nulla, et faucibus nisi. Vivamus volutpat massa consequat, iaculis odio quis, dapibus arcu.\n\n" + 
								"Curabitur mattis dolor tellus, sed congue velit condimentum vehicula. Nam ac mollis metus. Nam tempor hendrerit lorem. Nam elementum nec lacus eget interdum. Vestibulum hendrerit porta faucibus. Maecenas pulvinar augue quis auctor iaculis. Donec a nunc pellentesque, consequat mi at, pulvinar lorem. Morbi vulputate dui at lorem placerat consectetur.\n\n" + 
								"Cras tempus malesuada quam ut scelerisque. Fusce consectetur orci libero. Praesent nec enim sed diam suscipit convallis vel id velit. Suspendisse pretium luctus nisl vitae dapibus. Proin sapien risus, varius et arcu non, ullamcorper rhoncus elit. Nam ac arcu scelerisque, aliquet leo sollicitudin, varius risus. Morbi augue augue, hendrerit aliquam turpis et, posuere semper ligula.\n\n" + 
								"Maecenas mollis fermentum interdum. Morbi magna dolor, feugiat eget porta in, mollis sit amet massa. Pellentesque est purus, fringilla vitae cursus ut, bibendum sed arcu. Vestibulum nec posuere dui, non varius leo. Praesent mattis libero sed turpis dictum, ac faucibus dui commodo. Proin purus nisl, rhoncus sit amet rutrum non, adipiscing non eros. Nulla facilisi. Nam luctus quam vel ligula imperdiet eleifend. Donec ultrices placerat rhoncus. Vivamus vitae pretium lorem. Nulla elementum odio eu neque faucibus, et lacinia purus venenatis.";
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