package anlei.util.richtext
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class GifPlayer
	{
		//*****************************************************
		// 以下为包外类-----------
		//*****************************************************
		
		//==============================================================================================
		// gifPlayer
		// 注:gifPlayer作者是bytearray.org ,此处为引用,如需源码,请查看http://code.google.com/p/as3gif/;
		//==============================================================================================
		
		private var _gifPlayerClass:Class;
		private var _gifPlayerEvent:Class;
		private var _byteArray:ByteArray;
		private var _loader:Loader;
		
		private const GIFPLAYERSTR:String ="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"
		
		public function GifPlayer()
		{
			_byteArray = new Base64(GIFPLAYERSTR);
			_loader = new Loader();
			createClass();
		}
		public function createGif($container:Sprite, $url:String, $onComplete:Function = null, $onError:Function = null):void
		{
			var $_gifPlayer:*;
			var $_fun:Function = function():void
			{
				$_gifPlayer = new _gifPlayerClass();
				$container.addChild($_gifPlayer);
				$_gifPlayer.load( new URLRequest ($url) );	
				$_gifPlayer.addEventListener( _gifPlayerEvent.COMPLETE, $onComplete);
				$_gifPlayer.addEventListener(IOErrorEvent.IO_ERROR, $onError );
			}
			createClass($_fun);
		}
		
		private function createClass($onComplete:Function = null):void
		{
			if (_gifPlayerClass != null ) {
				if ($onComplete != null) $onComplete();
				return;
			}
			//trace("create");
			var $_completeHandler:Function = function(evt:Event):void {
				_gifPlayerClass = _loader.contentLoaderInfo.applicationDomain.getDefinition("org.bytearray.gif.player.GIFPlayer") as Class;
				_gifPlayerEvent = _loader.contentLoaderInfo.applicationDomain.getDefinition("org.bytearray.gif.events.GIFPlayerEvent") as Class;
				if ($onComplete != null) $onComplete();
			}
			_loader.loadBytes(_byteArray);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, $_completeHandler);
		}
		public function get gifPlayerClass ():Class
		{
			return _gifPlayerClass;
		}
		public function get gifPlayerEvent ():Class
		{
			return _gifPlayerEvent;
		}

	}
}
import flash.utils.ByteArray;

//============================================================================
// Base64 
// 通用的base64转byteArray;
//============================================================================

internal class Base64 extends ByteArray {
	private static  const BASE64:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,0,0,0,63,52,53,54,55,56,57,58,59,60,61,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,0,0,0,0,0,0,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,0,0,0,0,0];
	public function Base64(str:String):void {
		var n:int, j:int;
		for (var i:int = 0; i < str.length && str.charAt(i) != "="; i++) {
			j = (j << 6) | BASE64[str.charCodeAt(i)];
			n += 6;
			while (n >= 8) {
				writeByte((j >> (n -= 8)) & 0xFF);
			}
		}
		position = 0;
	}
}