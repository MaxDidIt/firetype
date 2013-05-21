package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageTag;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTag;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import de.maxdidit.hardware.text.HardwareCharacterCache;
	import de.maxdidit.hardware.text.HardwareFontFormat;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRenderer;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRenderer;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Program3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	/**
	 * This is a runnable demo class to test the HardwareFont class.
	 *
	 * @author Max Knoblich
	 */
	public class HardwareFontDemo extends Sprite
	{
		private var stage3d:Stage3D;
		private var context3d:Context3D;
		
		private var viewProjectionMtx:Matrix3D;
		private var cache:HardwareCharacterCache;
		private var hardwareText:HardwareText;
		
		private var mouseDown:Boolean;
		private var textClickY:Number;
		private var mouseClickY:Number;
		
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontDemo()
		{
			// stage properties
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.frameRate = 60;
			
			this.stage.addEventListener(Event.RESIZE, handleResize);
			
			// init stage3d
			stage3d = this.stage.stage3Ds[0];
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
			stage3d.addEventListener(ErrorEvent.ERROR, handleContextCreationError);
			stage3d.requestContext3D(Context3DRenderMode.AUTO);
		}
		
		private function handleResize(e:Event):void 
		{
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, false);
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
			
			if (hardwareText)
			{
				hardwareText.calculateTransformations(viewProjectionMtx, true);
			}
		}
		
		private function handleContextCreated(e:Event):void
		{
			context3d = (e.target as Stage3D).context3D;
			
			context3d.enableErrorChecking = true;
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, false);
			
			var hardwareParser:OpenTypeParser = new OpenTypeParser();
			
			hardwareParser.addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
			//hardwareParser.loadFont("arial.ttf");
			//hardwareParser.loadFont("impact.ttf");
			//hardwareParser.loadFont("newscycle-bold.ttf");
			//hardwareParser.loadFont("DAUNPENH.TTF");
			hardwareParser.loadFont("TIMES.TTF");
			//hardwareParser.loadFont("L_10646.TTF");
			//hardwareParser.loadFont("CONSOLA.TTF");
			//hardwareParser.loadFont("COUR.TTF");
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
			
			var color:Vector.<Number> = new Vector.<Number>();
			color.push(0.0, 0.0, 0.0, 1.0);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		private function handleMouseUp(e:MouseEvent):void 
		{
			mouseDown = false;
		}
		
		private function handleMouseDown(e:MouseEvent):void 
		{
			textClickY = hardwareText.y;
			
			mouseClickY = e.stageY;
			
			mouseDown = true;
		}
		
		private function handleContextCreationError(e:ErrorEvent):void
		{
			trace("Yaahrg");
		}
		
		private function handleFontParsed(e:FontEvent):void
		{
			var hardwareFontFormat:HardwareFontFormat = new HardwareFontFormat();
			hardwareFontFormat.font = e.font;
			hardwareFontFormat.subdivisions = 1;
			
			cache = new HardwareCharacterCache(new BatchedGlyphRenderer(context3d, new EarClippingTriangulator()));
			
			hardwareText = new HardwareText(cache);
			hardwareText.scaleX = hardwareText.scaleY = 0.15;
			hardwareText.width = 40000;
			
			hardwareText.standardFormat = hardwareFontFormat;
			hardwareText.standardScript = ScriptTag.LATIN;
			hardwareText.standardLanguage = LanguageTag.ENGLISH;
			
			hardwareText.text = "Hold the left mouse button and drag the text up and down.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ipsum mi, commodo eget lacinia eget, condimentum porta nisi. Praesent tincidunt euismod pulvinar. Nam aliquam odio nec justo laoreet sed commodo arcu viverra. Vestibulum sodales ultricies sollicitudin. Aenean felis urna, auctor et elementum interdum, hendrerit eget orci. Morbi aliquet, nunc vitae vehicula tempor, massa nulla imperdiet lectus, eu vehicula dolor massa non nisl. Duis cursus lobortis facilisis. Sed in tortor lacus, vel rutrum elit. Morbi vulputate mi vel elit pellentesque gravida. Quisque gravida neque nec nunc malesuada pharetra. Aliquam enim massa, vulputate ut faucibus vel, adipiscing vel tortor. Pellentesque malesuada ipsum eu diam fringilla molestie.\n\nAenean hendrerit velit a massa scelerisque pulvinar bibendum velit iaculis. Sed id enim eget augue hendrerit laoreet et quis est. Donec placerat dignissim leo dignissim imperdiet. Integer pharetra enim non risus porttitor dignissim et vel libero. Aenean blandit feugiat leo interdum tincidunt. Ut in diam non purus venenatis scelerisque. Integer eleifend varius porta. Morbi sollicitudin convallis tortor, non egestas mi imperdiet at. Maecenas eget felis a eros hendrerit luctus. Vestibulum accumsan viverra lorem id vestibulum. Quisque suscipit pulvinar arcu, ut faucibus ligula aliquam nec. Sed commodo tempus velit, varius laoreet diam consequat eu. Sed molestie dignissim metus ac tempor. Maecenas non neque vitae odio laoreet vulputate ultricies et elit. Nulla nunc nulla, bibendum eu volutpat in, luctus at augue.\n\nNunc aliquet nunc non mauris pretium at hendrerit dui volutpat. Sed vitae condimentum nunc. Nam eget est non augue egestas tincidunt vel consectetur felis. Nulla facilisi. Praesent quis purus sed odio tincidunt iaculis. Nullam vulputate nisi vitae augue congue gravida. Phasellus magna metus, elementum nec adipiscing eget, interdum eu lorem. Nulla ornare lacinia ante at rhoncus.";
			
			hardwareText.calculateTransformations(viewProjectionMtx, true);
			
			var font:HardwareFont = e.font;
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			if (mouseDown)
			{
				hardwareText.y = textClickY - (stage.mouseY - mouseClickY) * 10;
				hardwareText.calculateTransformations(viewProjectionMtx);
			}
			
			context3d.clear(1, 1, 1);			
			cache.render();			
			context3d.present();
		}
	
	}

}