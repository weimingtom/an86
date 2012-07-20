package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import ui.component.MyLoader;
	
	public class MyImage extends Sprite
	{
		private static var BD_DICT:Dictionary = new Dictionary();
		
		private var _url:String;
		private var _loader:MyLoader;
		
		private var onComplete:Function;
		
		public function MyImage($url:String = '', $onComplete:Function = null, $x:int = 0, $y:int = 0)
		{
			_url = $url;
			if(_url == '') return;
			onComplete = $onComplete;
			x = $x;
			y = $y;
			
			if(BD_DICT[_url]){
				addChild(getBitmap());
				return;
			}
			inits();
		}
		
		private function inits():void{
			_loader = new MyLoader(_url, onLoadComplete);
		}
		
		private function onLoadComplete():void{
			BD_DICT[_url] = _loader.content as Bitmap;
			addChild(getBitmap());
			if(onComplete != null){
				onComplete();
			}
		}
		
		public function getBitmap():Bitmap{
			var _s:BitmapData = getBitmapData();
			var _bit:Bitmap = new Bitmap(_s);
			return _bit;
		}
		
		public function getBitmapData():BitmapData{
			return (BD_DICT[_url] as Bitmap).bitmapData.clone();
		}
		
		public function move($x:int = 0, $y:int = 0):void{
			x = $x;
			y = $y;
		}
		
		
	}
	
}