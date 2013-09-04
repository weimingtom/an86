package anlei.util
{
	import flash.display.Stage;
	import flash.events.Event;

	public class ResizeManager
	{
		private var stage:Stage;
		private var _resizeList:Vector.<Function> = new Vector.<Function>();
		
		private static var _instance:ResizeManager;
		public function ResizeManager(signle:Signle) { inited(); }
		public static function getInstance():ResizeManager {
			if (_instance == null)
				_instance = new ResizeManager(new Signle());
			return _instance;
		}
		/////////////////////
		/////////////////////
		/////////////////////
		/////////////////////
		private function inited():void {
			_resizeList = new Vector.<Function>();
		}
		
		private function onResize(event:Event):void {
			for (var i:int = 0; i < _resizeList.length; i++) {
				_resizeList[i]();
			}
		}
		
		public function inits($stage:Stage):void {
			stage = $stage;
			stage.addEventListener(Event.RESIZE, onResize);
		}
		public function has(value:Function):int{
			return _resizeList.indexOf(value);
		}
		public function addResize(value:Function):void{
			_resizeList.push(value);
		}
		public function delResize(value:Function):void{
			var _index:int = _resizeList.indexOf(value);
			if(_index != -1){
				_resizeList.splice(_index, 1);
			}
		}
		
	}
}
class Signle{}