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
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import de.maxdidit.hardware.text.cache.HardwareTextFormatMap;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
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
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeTutorial5 extends Sprite 
	{
		///////////////////////
		// Embed
		///////////////////////
		
		[Embed(source="../../../../../resources/fonts/newscycle/newscycle-bold.ttf", mimeType="application/octet-stream")]
        private static const fontNewsCycleBoldData : Class;
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _context3d:Context3D;
		private var _hardwareText:HardwareText;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeTutorial5() 
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
			var openTypeParser:OpenTypeParser = new OpenTypeParser();
			var font:HardwareFont = openTypeParser.parseFont(new fontNewsCycleBoldData() as ByteArray);
			
			_hardwareText = new HardwareText(_context3d);
			
			_hardwareText.standardFormat.font = font;
			
			_hardwareText.scaleX = _hardwareText.scaleY = 0.013;
			_hardwareText.x = -320;
			_hardwareText.y = 100;
			_hardwareText.width = 640;
			
			_hardwareText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed facilisis lacus nec sollicitudin fermentum. Vivamus urna mi, fringilla eu diam ac, lobortis bibendum mi. Vestibulum laoreet augue id ligula ullamcorper, sit amet malesuada diam tincidunt.";
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