package net.an86.utils
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	public class MyImage extends Bitmap
	{
		private static var BD_DICT:Dictionary = new Dictionary();
		
		private var _url:String='';
		protected var _loader:MyLoader;
		
		private var _tempDrawWidth:Number = -1;
		private var _tempDrawHeight:Number = -1;
		
		protected var onComplete:Function;
		
		public function MyImage($url:String = '', $onComplete:Function = null, $x:int = 0, $y:int = 0)
		{
			_url = $url;
			if(_url == '')
				return;
			onComplete = $onComplete;
			x = $x;
			y = $y;
			
			if(BD_DICT[_url]){
				reDrawBitmap();
				return;
			}
			inits();
		}
		
		private function inits():Boolean{
			if(!_loader){
				_loader = new MyLoader(url, onLoadComplete);
				return false;
			}
			return true;
		}
		
		private function onLoadComplete():void{
			BD_DICT[url] = _loader.content as Bitmap;
			
			reDrawBitmap();
		}
		
		private function reDrawBitmap():void{
			bitmapData = getBitmapData();
			
			if(_tempDrawWidth != -1){
				width = _tempDrawWidth;
				_tempDrawWidth = -1;
			}
			
			if(_tempDrawHeight != -1){
				height = _tempDrawHeight;
				_tempDrawHeight = -1;
			}
			if(onComplete != null) onComplete();
		}
		
		public function getBitmapData():BitmapData{
			return (BD_DICT[url] as Bitmap).bitmapData;
		}
		
		public function dispose():void{
			if(_loader){
				_loader.dispose();
				_loader = null;
			}
		}
		
		private function load():void{
			var _b:Boolean = inits();
			if(_b){
				_loader.quest.url = url;
				_loader.startLoad();
			}
		}
		
		public function move($x:int = 0, $y:int = 0):void{
			x = $x;
			y = $y;
		}

		public function get url():String { return _url; }
		public function set url(value:String):void {
			_url = value;
			load();
		}
		
		
	}
}