package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.events.FontEvent;
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
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeTutorial4 extends Sprite 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _context3d:Context3D;
		private var _hardwareText:HardwareText;
		private var viewProjection:Matrix3D;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeTutorial4() 
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
			
			viewProjection = new Matrix3D(viewProjectionRawData);
			
			_hardwareText.calculateTransformations(viewProjection, true);
		}
		
		private function initializeText():void 
		{
			_hardwareText = new HardwareText(_context3d);
			
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
			
			var openTypeParser:OpenTypeParser = new OpenTypeParser();
			openTypeParser.loadFont("newscycle-bold.ttf").addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
			
			// react to resizing the stage
			this.stage.addEventListener(Event.RESIZE, handleResize);
			
			// Set up the update loop.
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function handleFontParsed(e:FontEvent):void 
		{
			//_hardwareText.standardFormat.font = e.font;
			
			_hardwareText.cache.fontMap.addFont(e.font);
			
			_hardwareText.text = "Lorem ipsum dolor sit amet, <format font='" + e.font.uniqueIdentifier + "'>consectetur adipiscing elit</format>. Sed facilisis lacus nec sollicitudin fermentum. Vivamus urna mi, fringilla eu diam ac, lobortis bibendum mi. <format font='" + e.font.uniqueIdentifier + "'>Vestibulum laoreet augue</format> id ligula ullamcorper, sit amet <format font='" + e.font.uniqueIdentifier + "'>malesuada diam</format> tincidunt.";
			
			_hardwareText.flagForUpdate();
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