package de.maxdidit.hardware.font.parser 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FontLoaderJob extends EventDispatcher
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _url:String;
		private var _urlLoader:URLLoader;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontLoaderJob() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get urlLoader():URLLoader 
		{
			return _urlLoader;
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function loadFont(url:String):void
		{
			var urlRequest:URLRequest = new URLRequest(_url);
			
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			_urlLoader.addEventListener(Event.COMPLETE, handleFontLoaded);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFontLoadingFailed);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleFontLoadingFailed);
			
			_urlLoader.load(urlRequest);
		}
		
		private function removeEventHandlerFromLoader(urlLoader:URLLoader):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, handleFontLoaded);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFontLoadingFailed);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleFontLoadingFailed);
		}
		
		private function handleFontLoadingFailed(e:Event):void 
		{
			// TODO: provide feedback that the font could not be loaded and why.
			
			var urlLoader:URLLoader = e.target as URLLoader;
			removeEventHandlerFromLoader(urlLoader);
		}
		
		private function handleFontLoaded(e:Event):void 
		{			
			var urlLoader:URLLoader = e.target as URLLoader;
			removeEventHandlerFromLoader(urlLoader);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}

}