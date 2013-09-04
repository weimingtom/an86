package ui.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import anlei.util.PublicProperty;
	
	public class MyImage extends MySprite
	{
		private static var BD_DICT:Dictionary = new Dictionary();
		
		private var _url:String;
		protected var _loader:MyLoader;
		private var _draw:Bitmap;
		
		private var _tempDrawWidth:Number = -1;
		private var _tempDrawHeight:Number = -1;
		
		public var onComplete:Function;
		
		public function MyImage($url:String = '', $onAddToStageComplete:Function = null, $x:int = 0, $y:int = 0)
		{
			
			url = $url;
			onComplete = $onAddToStageComplete;
			if(url == '') return;
			x = $x;
			y = $y;
			mouseChildren = false;
			
			if(BD_DICT[url]){
				this.addEventListener(Event.ACTIVATE, onActivate);
				return;
			}else{
				inits();
			}
		}
		
		private function onActivate(event:Event):void {
			this.removeEventListener(Event.ACTIVATE, onActivate);
			if(BD_DICT[url]){
				reDrawBitmap();
			}
		}
		
		private function inits():Boolean{
			if(!_loader){
				_loader = new MyLoader(url, onLoadComplete);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
				return false;
			}
			return true;
		}
		
		private function onLoadComplete():void{
			if(isBitmap()){
				BD_DICT[url] = _loader.content;
			}
			reDrawBitmap();
		}
		
		private function reDrawBitmap():void{
			this.removeAllChild();
			if(isBitmap()){
				if(_draw == null) _draw = getBitmap();
				_draw.bitmapData = getBitmapData();
				addChild(_draw);
				
				if(_draw && _loader && _loader.content){
					_draw.width = _loader.content.width;
					_draw.height= _loader.content.height;
				}
				
				if(_tempDrawWidth != -1){
					_draw.width = _tempDrawWidth;
					_tempDrawWidth = -1;
				}
				
				if(_tempDrawHeight != -1){
					_draw.height = _tempDrawHeight;
					_tempDrawHeight = -1;
				}
				
			}else{
				//addChild(BD_DICT[url]);
				addChild(_loader);
			}
			
			if(onComplete != null) onComplete();
			/*if(onComplete != null) TweenLite.delayedCall(0.5, onComplete);//构造还未完成*/
		}
		
		/**是位图还是SWF*/
		private function isBitmap():Boolean{
			if(url && url.indexOf(".swf") == -1) return true;
			return false;
		}
		
		protected function onLoaderError(e:IOErrorEvent):void{
			trace(e.text);
		}
		
		override public function dispose():void{
			this.removeAllChild();
			super.dispose();
			if(_loader){
				_loader.dispose();
				_loader = null;
			}
			onComplete = null;
		}
		
		public function get content():DisplayObject{
			if(isBitmap()) return _draw;
			return _loader;
		}
		
		/**重新加载*/
		public function reload():void{
			var _b:Boolean = inits();
			if(_b){
				_loader.setQuestUrl(url);
			}
		}
		
		public function playSwf():void{
			if(url && url.indexOf(".swf") != -1 && _loader.content){
				_loader.content['play']();
			}
		}
		
		public function stopSwf():void{
			if(url && url.indexOf(".swf") != -1 && _loader.content){
				_loader.content['stop']();
			}
		}
		//播放一次性光效方法
		private var tempmv:MovieClip;
		public function playAndStopSwf():void
		{
			if(url && url.indexOf(".swf") != -1 && _loader.content){
				tempmv = MovieClip(_loader.content);
				if(tempmv){
					tempmv.visible=true;
					tempmv.gotoAndPlay(1);
					tempmv.addFrameScript(tempmv.totalFrames-1,playOverHandle);
				}
			}
		}
		
		private function playOverHandle():void
		{
			tempmv.stop();
			tempmv.visible=false;
			tempmv.addFrameScript(tempmv.totalFrames-1,null);
		}
		
		private function getBitmap():Bitmap{
			//var _s:BitmapData = getBitmapData();
			var _bit:Bitmap = new Bitmap();
			return _bit;
		}
		
		private function getBitmapData():BitmapData{
			return (BD_DICT[url] as Bitmap).bitmapData;
		}
		
		public function move($x:int = 0, $y:int = 0):void{
			x = $x;
			y = $y;
		}

		/**记得要reload()下*/
		public function get url():String { return _url; }
		public function set url(value:String):void {
			_url = value;
			_tempDrawWidth = -1;
			_tempDrawHeight= -1;
			setURL();
		}
		
		private function setURL():void{
			_url = MyLoader.setUrlHttp(_url);
			if(!_url){
				if(_loader) _loader.unloadAndStop();
				if(_draw){
					_draw.bitmapData = null;
				}
				this.removeAllChild();
			}else{
				if(BD_DICT[url]){
					reDrawBitmap();
				}
			}
		}
		
		override public function get width():Number{
			/*if(!_draw){ return super.width; } return _draw.width;*/
			if(_tempDrawWidth == -1){
				return super.width;
			}
			return _tempDrawWidth;
		}
		
		override public function set width(value:Number):void{
			if(!_draw){
			}else{
				_draw.width = value;
			}
			_tempDrawWidth = value;
		}
		
		override public function get height():Number{
			/*if(!_draw){ return super.height; } return _draw.height;*/
			if(_tempDrawHeight == -1){
				return super.height;
			}
			return _tempDrawHeight;
		}
		
		override public function set height(value:Number):void{
			if(!_draw){
			}else{
				_draw.height = value;
			}
			_tempDrawHeight = value;
		}
		
	}
}