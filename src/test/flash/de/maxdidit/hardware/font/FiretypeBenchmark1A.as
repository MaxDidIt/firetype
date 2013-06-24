package de.maxdidit.hardware.font 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FiretypeBenchmark1A extends Sprite
	{
		[Embed(source = "../../../../../resources/fonts/newscycle/newscycle-bold.ttf",
		fontFamily = "NewsCycle",
		mimeType = "application/x-font",
		advancedAntiAliasing='false',
        embedAsCFF='false')] 
        private static const fontNewsCycleBoldData : Class; 
		
		private var _textField3:TextField;
		private var _textField2:TextField;
		private var _textField1:TextField;
		private var _textField4:TextField;
		
		public function FiretypeBenchmark1A() 
		{
			// stage properties 
			this.stage.scaleMode = StageScaleMode.NO_SCALE; 
			this.stage.align = StageAlign.TOP_LEFT; 
			this.stage.frameRate = 60; 
			
			var font:Font = new fontNewsCycleBoldData();
			var textFormat:TextFormat = new TextFormat("NewsCycle", 20);
			
			_textField1 = new TextField();
			_textField1.width = 400;
			_textField1.defaultTextFormat = textFormat;
			_textField1.multiline = true;
			_textField1.wordWrap = true;
			_textField1.autoSize = TextFieldAutoSize.LEFT;
			_textField1.selectable = false;
			_textField1.embedFonts = true;
			_textField1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque erat ac sapien blandit, vitae egestas arcu adipiscing. Aenean ac lobortis urna. Pellentesque lacinia, ante eu malesuada molestie, sapien metus volutpat est, eu elementum libero tortor ac mauris. Mauris risus nisl, ultricies vel pretium posuere, imperdiet vitae magna. Pellentesque interdum, risus in venenatis egestas, erat felis rhoncus nisi, sit amet tempus nulla sapien viverra orci. Sed pellentesque laoreet congue. In ante neque, interdum et scelerisque sed, aliquet vitae sapien. Mauris nec iaculis sem. Proin pretium faucibus enim ac sollicitudin. Donec mattis est eget nisl pulvinar pellentesque. Vestibulum ut orci at urna eleifend laoreet eget a metus. Aenean eu vehicula nisl. Suspendisse a felis ac tellus sodales eleifend."
			this.addChild(_textField1);
			
			_textField2 = new TextField();
			_textField2.width = 400;
			_textField2.defaultTextFormat = textFormat;
			_textField2.multiline = true;
			_textField2.wordWrap = true;
			_textField2.autoSize = TextFieldAutoSize.LEFT;
			_textField2.selectable = false;
			_textField2.embedFonts = true;
			_textField2.text = "Ut lobortis molestie nibh, et lacinia libero consectetur et. Nullam ut risus eget leo lobortis adipiscing nec sed sem. Sed in dui eu eros tincidunt egestas. Pellentesque rutrum pretium est, a lacinia quam auctor eget. Curabitur sed commodo sem. Quisque id diam bibendum, lobortis tortor nec, iaculis urna. Proin iaculis, eros nec pretium gravida, ante eros varius purus, vel sagittis sapien nibh ut augue. Sed a lorem congue, imperdiet turpis non, elementum lorem. Fusce fringilla, odio ac ullamcorper imperdiet, ante ligula posuere odio, ac hendrerit turpis nibh quis dolor. Suspendisse potenti. Donec et accumsan ipsum. Sed fermentum odio non diam luctus condimentum. Sed interdum, diam in aliquet dignissim, turpis lorem cursus lacus, sed pretium elit arcu eu purus. Cras tempor magna in dolor laoreet fringilla. Suspendisse in scelerisque enim, vel varius velit. Sed malesuada tellus iaculis, semper nunc vitae, ullamcorper nisi. Donec facilisis eros sit amet erat tempus suscipit. Phasellus vitae vehicula nisi, a convallis nisl. Cras eget metus a dui semper gravida a sit amet nisl."
			this.addChild(_textField2);
			
			_textField3 = new TextField();
			_textField3.width = 400;
			_textField3.defaultTextFormat = textFormat;
			_textField3.multiline = true;
			_textField3.wordWrap = true;
			_textField3.autoSize = TextFieldAutoSize.LEFT;
			_textField3.selectable = false;
			_textField3.embedFonts = true;
			_textField3.text = "Mauris malesuada eu lorem non sagittis. Nulla fringilla augue sit amet magna mollis, nec accumsan nisl elementum. Duis sit amet condimentum dui. Cras sed turpis eget neque porttitor pharetra. Vestibulum tempus feugiat dui, luctus mollis felis mattis in. Curabitur porttitor feugiat dui sed tincidunt. Pellentesque eget quam vel lectus scelerisque suscipit. Etiam euismod mi in lectus sodales mollis. Aliquam erat volutpat. Phasellus tristique orci erat, id accumsan quam vulputate ac. Nam sodales porttitor tellus, sit amet posuere justo placerat in. Proin egestas sapien nec suscipit dictum. Curabitur euismod ligula eu nunc ullamcorper bibendum. Pellentesque eleifend dui vitae felis aliquet ullamcorper. Mauris sollicitudin lectus vitae tellus dapibus aliquam. Nulla rutrum turpis vel odio viverra, ut convallis lectus gravida. Curabitur libero nibh, blandit at mi eget, ultricies tristique mauris. Maecenas ut dolor scelerisque, dignissim dolor adipiscing, varius lacus. Aliquam odio nibh, accumsan sed felis vel, tincidunt aliquam orci. Vestibulum eu libero quis lacus semper molestie eu vitae dui. Integer sodales euismod magna, in cursus nulla dictum sed. Ut malesuada nunc vitae nibh congue, ac placerat sapien cursus. Cras rutrum vestibulum dui, ac venenatis velit tincidunt tincidunt. Maecenas rutrum massa et dolor congue volutpat."
			this.addChild(_textField3);
			
			_textField4 = new TextField();
			_textField4.width = 400;
			_textField4.defaultTextFormat = textFormat;
			_textField4.multiline = true;
			_textField4.wordWrap = true;
			_textField4.autoSize = TextFieldAutoSize.LEFT;
			_textField4.selectable = false;
			_textField4.embedFonts = true;
			_textField4.text = "Suspendisse fermentum commodo fringilla. Mauris mattis tristique nisi at eleifend. Donec mauris lectus, ullamcorper in porttitor nec, porta ut diam. Integer elementum laoreet justo, id varius massa dignissim in. Duis et tempor justo. Morbi quis mattis purus. In semper gravida diam, ut dignissim justo semper eget. Nam porttitor luctus magna, at placerat leo mattis sit amet. Nullam non sagittis tortor. Praesent cursus ornare ipsum, nec accumsan diam venenatis ultrices. Morbi vehicula sapien et vestibulum condimentum. Vivamus gravida ipsum eget molestie vestibulum. Pellentesque sodales augue eget dapibus semper. Pellentesque vel aliquet elit, id tempus mauris. Ut feugiat odio nibh, id laoreet magna dapibus vitae. Ut aliquet erat non mauris viverra porta nec eu ante. Quisque vel tortor sit amet augue condimentum hendrerit ut in libero. Donec adipiscing nunc id varius rhoncus. Aenean fermentum mattis mi, a tristique leo mollis et. Suspendisse in libero lectus. Nulla convallis est eu est adipiscing aliquam. Aliquam mattis sagittis orci at feugiat."
			this.addChild(_textField4);
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void 
		{
			const centerX:Number = stage.stageWidth / 2;
			const centerY:Number = stage.stageHeight / 2;
			const time:Number = Number(getTimer());
			
			_textField1.x = centerX + Math.sin(time / 2000) * centerY;
			_textField1.y = centerY + Math.cos(time / 2000) * centerY;
			
			_textField2.x = centerX + Math.sin(time / 3000) * centerY;
			_textField2.y = centerY + Math.cos(time / 3000) * centerY;
			
			_textField3.x = centerX + Math.sin(-time / 3000) * centerY;
			_textField3.y = centerY + Math.cos(-time / 3000) * centerY;
			
			_textField4.x = centerX + Math.sin(-time / 1000) * centerY;
			_textField4.y = centerY + Math.cos(-time / 1000) * centerY;
		}
		
	}

}