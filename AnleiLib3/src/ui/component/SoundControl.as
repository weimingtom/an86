package ui.component
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import anlei.erpg.EGame;
	
	public class SoundControl
	{
		public static var dict:Dictionary = new Dictionary();
		private var _channe:SoundChannel;
		private var _mp3:Sound;
		private var position:Number = 0;
		
		private var isAutoPlay:Boolean;
		private var isLoop:Boolean;
		/**当前是否在播放中*/
		public var isPlay:Boolean = false;
		private var quest:URLRequest;
		
		public function SoundControl(_url:String = null, _isAutoPlay:Boolean = true, _isLoop:Boolean = false)
		{
//			return;
			isAutoPlay = _isAutoPlay;
			isLoop = _isLoop;
			initsUrl(_url);
		}
		
		public function get url():String {
			if(quest) return quest.url;
			return null;
		}
		
		public function initsUrl(_url:String):void{
			if(_url != null){
				if(_url.indexOf(EGame.HTTP) == -1) _url = EGame.HTTP + _url;
				if(quest == null) quest = new URLRequest();
				if(quest.url == _url) return;
				quest.url = _url;
				if(_mp3){
					_mp3.removeEventListener(Event.COMPLETE, onLoadComplete);
					_mp3.removeEventListener(IOErrorEvent.IO_ERROR, onError);
					dispose();
				}
				_mp3 = new Sound();
				_mp3.load(quest);
				
				_mp3.addEventListener(Event.COMPLETE, onLoadComplete);
				_mp3.addEventListener(IOErrorEvent.IO_ERROR, onError);
				
			}
		}
		
		private function onError(event:IOErrorEvent):void {
			trace(event.text);
		}
		
		/**先加入swf库中的Sound对象
		 * 再进行下面的播控操作。
		 * **/
		public function InitSound(_id:Sound):void{
//			return;
			_mp3 = _id;
		}
		public function dispose():void{
//			return;
//			_mp3.close();
			_mp3 = null;
			
			if(_channe != null){
				_channe.stop();
				_channe = null;
			}
			isPlay = false;
		}
		private function onLoadComplete(e:Event):void{
			_mp3.removeEventListener(Event.COMPLETE, onLoadComplete);
			position = 0;
			if(isAutoPlay) Play();
		}
		/**
		 * 播放完成之后，复位
		 * **/
		public function onPlayComplete(e:Event):void{
//			return;
			_channe.removeEventListener(Event.SOUND_COMPLETE, onPlayComplete);
			Stop();
			position = 0;
			trace(position);
		}
		/**
		 * 播放
		 */
		public function Play():void{
//			return;
			if(!isPlay){
				isPlay = true;
				var loop:int = isLoop ? 999999 : 0;
				if(_mp3){
					_channe = _mp3.play(position, loop);
				}
				if(_channe != null){
					_channe.addEventListener(Event.SOUND_COMPLETE, onPlayComplete);
				}
			}
		}
		/**
		 * 暂停
		 * */
		public function Pause():void{
//			return;
			isPlay = false;
			position = _channe.position;
			_channe.stop();
		}
		/**
		 * 停止
		 * */
		public function Stop():void{
//			return;
			isPlay = false;
			if(_channe != null){
				_channe.stop();
			}
			position = 0;
		}

	}
}