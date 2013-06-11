package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageTag;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTag;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.cache.HardwareTextFormatMap;
	import de.maxdidit.hardware.text.format.TextAlign;
	import de.maxdidit.hardware.text.format.TextColor;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRenderer;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRendererFactory;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRenderer;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRendererFactory;
	import de.maxdidit.hardware.text.Typesetter;
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
	import flash.utils.getTimer;
	
	/**
	 * This is a runnable demo class to test the HardwareFont class.
	 *
	 * @author Max Knoblich
	 */
	public class FiretypeDemo extends Sprite
	{
		private var stage3d:Stage3D;
		private var context3d:Context3D;
		
		private var viewProjectionMtx:Matrix3D;
		private var cache:HardwareCharacterCache;
		private var hardwareText:HardwareText;
		
		private var mouseDown:Boolean;
		private var textClickY:Number;
		private var mouseClickY:Number;
		private var hardwareParser:OpenTypeParser;
		
		private var highlightFont:HardwareFont;
		private var firetypeFont:HardwareFont;
		private var highlightColor:TextColor;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FiretypeDemo()
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
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, false);
			
			hardwareParser = new OpenTypeParser();
			
			cache = new HardwareCharacterCache(new SingleGlyphRendererFactory(context3d, new EarClippingTriangulator()));
			
			hardwareParser.loadFont("ArchivoNarrow-BoldItalic.ttf").addEventListener(FontEvent.FONT_PARSED, handleFiretypeFontParsed);
			
			//hardwareParser.addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
			//hardwareParser.loadFont("L_10646.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("arial.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("kaiu.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("HDZB_5.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("MSYH.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("DAUNPENH.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("TIMES.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("newscycle-regular.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("framd.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("tahoma.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("MOIRE-REGULAR.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("WBV4.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("CAMBRIAB.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("CONSOLA.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			
			//hardwareParser.loadFont("CAMBRIAZ.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("MSYHBD.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("COURBD.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("impact.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("TIMESBI.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("ariali.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("LINDS.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("JELLYBELLY.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("TLPSMB.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			hardwareParser.loadFont("newscycle-bold.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("jingjing.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("tahomabd.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("MOIRE-BOLD.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
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
		
		private function handleBaseFontParsed(e:FontEvent):void 
		{
			cache.fontMap.addFont(e.font);
		}
		
		private function handleFiretypeFontParsed(e:FontEvent):void 
		{
			firetypeFont = e.font;
			cache.fontMap.addFont(e.font);
		}
		
		private function handleHighlightFontParsed(e:FontEvent):void 
		{
			highlightFont = e.font;
			cache.fontMap.addFont(e.font);
			
			initialize();
		}
		
		private function initialize():void
		{	
			hardwareText = new HardwareText(context3d, cache);
			hardwareText.scaleX = hardwareText.scaleY = 0.15;
			hardwareText.width = 40000;
			
			var highlightFormat:HardwareTextFormat = new HardwareTextFormat();
			highlightFormat.id = "highlight";
			highlightFormat.font = highlightFont;
			highlightFormat.color = 0xFFFF0000;
			highlightFormat.scale = 1.2;
			
			cache.textFormatMap.addTextFormat(highlightFormat);
			
			highlightColor = new TextColor("highlight", 0xFFFF0000);
			cache.textColorMap.addTextColor(highlightColor);
			
			hardwareText.text = "<format font='" + firetypeFont.uniqueIdentifier + "' scale='1.5' color='0xFFFF6600'>firetype</format> by Max Did It\nis an Open Source Actionscript 3 library that can parse TrueType font files and render them via the GPU.\n\n"
			hardwareText.text += "Hold the <format scale='1.2' color='0xFFFF0000'>left mouse button</format> and <format color='0xFFFF6600'>drag</format> the text up and down.\n\n" 
			hardwareText.text += "Each character in this text has been decoded from an <format id='" + highlightFormat.id + "' colorId='" + highlightColor.id + "'>OpenType</format> font file containing TrueType outlines, converted into polygon geometry and is rendered via the 3D graphics card.\n\n" 
			
			if (hardwareText.standardFormat.font.fontFamily == "News Cycle")
			{
				hardwareText.text += "This text uses the font \"News Cycle\", Copyright ©2010-2011, Nathan Willis (nwillis@glyphography.com).\n\n" +
									"The <format font='" + firetypeFont.uniqueIdentifier + "'>firetype</format> logo uses the font \"Archivo Narrow\", Copyright (c) 2012, Omnibus-Type (www.omnibus-type.com|omnibus.type@gmail.com).\n\n" +
									"Both Font Softwares are licensed under the SIL Open Font License, Version 1.1. " +
									"This license is available with a FAQ at:\n" +
									"http://scripts.sil.org/OFL\n\n";
			}
			else
			{
				hardwareText.text += "This text is (mostly) displayed using the font " + hardwareText.standardFormat.font.fontFamily + " " + hardwareText.standardFormat.font.fontSubFamily + ".\n\n";
			}
			
			hardwareText.text += "The font implements the following features for the script '" + hardwareText.standardFormat.scriptTag + "' and the language '" + hardwareText.standardFormat.languageTag + "':\n\n";
			var features:Vector.<FeatureRecord> = hardwareText.standardFormat.font.getAdvancedFeatures(hardwareText.standardFormat.scriptTag, hardwareText.standardFormat.languageTag);
			const l:uint = features.length;
			for (var i:uint = 0; i < l; i++)
			{
				hardwareText.text += features[i].featureTag.description + "\n";
			}
			hardwareText.text += "\n";
			
			hardwareText.text += " 12/8 1/3 á â à Â <format features='" + FeatureTag.STANDARD_LIGATURES.tag +", " + FeatureTag.REQUIRED_LIGATURES.tag + "'>f fi <format color=0xFFFF0000>ffi</format></format> 臥虎藏龍 <format scale=3 vertexDensity=2000>B80</format>\n\n" + //
								"Text alignment: left;\n<format scale='0.75' color='0xFF666666'>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ipsum mi, commodo eget lacinia eget, condimentum porta nisi. <format scale='1' color=0xFFFF0000>Praesent tincidunt euismod pulvinar</format>. Nam aliquam odio nec justo laoreet sed commodo arcu viverra. Vestibulum sodales ultricies sollicitudin. Aenean felis urna, auctor et elementum interdum, hendrerit eget orci. Morbi aliquet, nunc vitae vehicula tempor, massa nulla imperdiet lectus, eu vehicula dolor massa non nisl. Duis cursus lobortis facilisis. Sed in tortor lacus, vel rutrum elit. Morbi vulputate mi vel elit pellentesque gravida. Quisque gravida neque nec nunc malesuada pharetra. Aliquam enim massa, vulputate ut faucibus vel, adipiscing vel tortor. Pellentesque malesuada ipsum eu diam fringilla molestie.\n\n" + //
								"<format scale='1' color='0xFF000000'>Text alignment: center;\n</format><format textAlign='" + TextAlign.CENTER + "'>Aenean hendrerit velit a massa scelerisque pulvinar bibendum velit iaculis. Sed id enim eget augue hendrerit laoreet et quis est. Donec placerat dignissim leo dignissim imperdiet. <format id='" + highlightFormat.id + "'>Integer pharetra enim non risus porttitor dignissim et vel libero. Aenean blandit feugiat leo interdum tincidunt. Ut in diam non purus venenatis scelerisque.</format> Integer eleifend varius porta. Morbi sollicitudin convallis tortor, non egestas mi imperdiet at. Maecenas eget felis a eros hendrerit luctus. Vestibulum accumsan viverra lorem id vestibulum. Quisque suscipit pulvinar arcu, ut faucibus ligula aliquam nec. Sed commodo tempus velit, varius laoreet diam consequat eu. Sed molestie dignissim metus ac tempor. Maecenas non neque vitae odio laoreet vulputate ultricies et elit. Nulla nunc nulla, bibendum eu volutpat in, luctus at augue.\n\n</format>" + //
								"<format scale='1' color='0xFF000000'>Text alignment: right;\n</format><format textAlign='" + TextAlign.RIGHT + "'>Nunc aliquet nunc non mauris pretium at hendrerit dui volutpat. <format script=" + ScriptTag.CYRILLIC + " language=" + LanguageTag.RUSSIAN + ">Sed vitae condimentum nunc</format>. Nam eget est non augue egestas tincidunt vel consectetur felis. <format id='" + highlightFormat.id + "' color='0xFF0011FF'>Nulla facilisi. <format color='0xFF9999CC'>Praesent</format> quis purus <format scale='0.5'>sed</format> odio tincidunt iaculis.</format> Nullam vulputate nisi vitae augue congue gravida. Phasellus magna metus, elementum nec adipiscing eget, interdum eu lorem. Nulla ornare lacinia ante at rhoncus.\n</format></format>";
			//hardwareText.text = "藏";
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
			
			hardwareText.calculateTransformations(viewProjectionMtx, true);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			//cache.clearHardwareGlyphCache();
			//hardwareText.text = "<format id=\"fractions\">12/8</format> Lorem ipsum dolor sit amet, consectetur adipiscing elit. <format id=\"red\">Donec ipsum mi</format>, commodo eget lacinia eget, condimentum porta nisi. Praesent tincidunt euismod pulvinar. Nam aliquam odio nec justo laoreet sed commodo arcu viverra. Vestibulum sodales ultricies sollicitudin. Aenean felis urna, auctor et elementum interdum, hendrerit eget orci. Morbi aliquet, nunc vitae vehicula tempor, massa nulla imperdiet lectus, eu vehicula dolor massa non nisl. Duis cursus lobortis facilisis. Sed in tortor lacus, vel rutrum elit. Morbi vulputate mi vel elit pellentesque gravida. Quisque gravida neque nec nunc malesuada pharetra. Aliquam enim massa, vulputate ut faucibus vel, adipiscing vel tortor. Pellentesque malesuada ipsum eu diam fringilla molestie.\n\n<format id=\"small\">Aenean hendrerit velit a massa scelerisque pulvinar bibendum velit iaculis. Sed id enim eget augue hendrerit laoreet et quis est. Donec placerat dignissim leo dignissim imperdiet. Integer pharetra enim non risus porttitor dignissim et vel libero. Aenean blandit feugiat leo interdum tincidunt. Ut in diam non purus venenatis scelerisque. Integer eleifend varius porta. Morbi sollicitudin convallis tortor, non egestas mi imperdiet at. Maecenas eget felis a eros hendrerit luctus. Vestibulum accumsan viverra lorem id vestibulum. <format id=\"red\">Quisque suscipit pulvinar arcu</format>, ut faucibus ligula aliquam nec. Sed commodo tempus velit, varius laoreet diam consequat eu. Sed molestie dignissim metus ac tempor. Maecenas non neque vitae odio laoreet vulputate ultricies et elit. Nulla nunc nulla, bibendum eu volutpat in, luctus at augue.\n\nNunc aliquet nunc non mauris pretium at hendrerit dui volutpat. Sed vitae condimentum nunc. Nam eget est non augue egestas tincidunt vel consectetur felis. Nulla facilisi. Praesent quis purus sed odio tincidunt iaculis. Nullam vulputate nisi vitae augue congue gravida. Phasellus magna metus, elementum nec adipiscing eget, interdum eu lorem. Nulla ornare lacinia ante at rhoncus." + int(Math.random() * 100) + "</format>";
			
			if (mouseDown)
			{
				hardwareText.y = textClickY - (stage.mouseY - mouseClickY) * 10;
				hardwareText.calculateTransformations(viewProjectionMtx);
			}
			
			highlightColor.colorVector[2] = Math.sin(getTimer() / 500) * 0.5 + 0.5;
			highlightColor.colorVector[0] = Math.cos(getTimer() / 500) * 0.5 + 0.5;
			
			//hardwareText.standardFormat.colorVector[2] = Math.cos(getTimer() * 0.01) * 0.5 + 0.5;
			//hardwareText.standardFormat.colorVector[1] = Math.cos(getTimer() * 0.003) * 0.5 + 0.5;
			//hardwareText.standardFormat.colorVector[0] = Math.cos(getTimer() * 0.001) * 0.5 + 0.5;
			
			context3d.clear(1, 1, 1);
			cache.render();
			context3d.present();
		}
	
	}

}