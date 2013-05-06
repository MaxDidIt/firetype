package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
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
	import flash.geom.Matrix3D;
	
	/**
	 * This is a runnable demo class to test the HardwareFont class.
	 *
	 * @author Max Knoblich
	 */
	public class HardwareFontDemo extends Sprite
	{
		private var stage3d:Stage3D;
		private var context3d:Context3D;
		
		private const VERTEX_SHADER:String = "m44 op, va0, vc0"
		
		private const FRAGMENT_SHADER:String = "mov oc, fc0";
		
		private var vertexAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var fragmentAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var programPair:Program3D;
		private var hardwareGlyph1:HardwareGlyph;
		private var hardwareGlyph2:HardwareGlyph;
		private var hardwareGlyph3:HardwareGlyph;
		private var hardwareGlyph4:HardwareGlyph;
		private var hardwareGlyph5:HardwareGlyph;
		private var hardwareGlyph6:HardwareGlyph;
		private var hardwareGlyph7:HardwareGlyph;
		private var hardwareGlyph8:HardwareGlyph;
		private var hardwareGlyph9:HardwareGlyph;
		private var hardwareGlyph0:HardwareGlyph;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontDemo()
		{
			// stage properties
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.frameRate = 60;
			
			// init stage3d
			stage3d = this.stage.stage3Ds[0];
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
			stage3d.addEventListener(ErrorEvent.ERROR, handleContextCreationError);
			stage3d.requestContext3D(Context3DRenderMode.AUTO);
			
			// init shaders
			vertexAssembly.assemble(Context3DProgramType.VERTEX, VERTEX_SHADER);
			fragmentAssembly.assemble(Context3DProgramType.FRAGMENT, FRAGMENT_SHADER);
		}
		
		private function handleContextCreated(e:Event):void
		{
			context3d = (e.target as Stage3D).context3D;
			
			context3d.enableErrorChecking = true;
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, false);
			
			var hardwareParser:OpenTypeParser = new OpenTypeParser(context3d);
			
			hardwareParser.addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
			hardwareParser.loadFont("arial.ttf");
			
			programPair = context3d.createProgram();
			programPair.upload(vertexAssembly.agalcode, fragmentAssembly.agalcode);
			context3d.setProgram(programPair);
			
			context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX, 0, new Matrix3D(), true );
			context3d.setProgramConstantsFromVector( Context3DProgramType.FRAGMENT, 0, new Vector.<Number>(4), 1 );
		}
		
		private function handleContextCreationError(e:ErrorEvent):void
		{
			trace("Yaahrg");
		}
		
		private function handleFontParsed(e:FontEvent):void
		{
			var font:HardwareFont = e.font;
			
			hardwareGlyph1 = font.getHardwareGlyph("a".charCodeAt(0), 0);
			hardwareGlyph2 = font.getHardwareGlyph("a".charCodeAt(0), 1);
			hardwareGlyph3 = font.getHardwareGlyph("a".charCodeAt(0), 2);
			hardwareGlyph4 = font.getHardwareGlyph("a".charCodeAt(0), 3);
			hardwareGlyph5 = font.getHardwareGlyph("a".charCodeAt(0), 4);
			
			hardwareGlyph6 = font.getHardwareGlyph("B".charCodeAt(0), 0);
			hardwareGlyph7 = font.getHardwareGlyph("B".charCodeAt(0), 1);
			hardwareGlyph8 = font.getHardwareGlyph("B".charCodeAt(0), 2);
			hardwareGlyph9 = font.getHardwareGlyph("B".charCodeAt(0), 3);
			hardwareGlyph0 = font.getHardwareGlyph("B".charCodeAt(0), 4);
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			context3d.clear(0.3, 0.3, 0.3);
			
			hardwareGlyph1.render(context3d);
			hardwareGlyph2.render(context3d);
			hardwareGlyph3.render(context3d);
			hardwareGlyph4.render(context3d);
			hardwareGlyph5.render(context3d);
			
			hardwareGlyph6.render(context3d);
			hardwareGlyph7.render(context3d);
			hardwareGlyph8.render(context3d);
			hardwareGlyph9.render(context3d);
			hardwareGlyph0.render(context3d);
			
			context3d.present();
		}
	
	}

}