package ctrl
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import global.util.LoaderSource;
	import global.util.PublicProperty;

	/**
	 * 控制加载资源类
	 * @author Anlei
	 */
	public class DymainLoaderSource
	{
		private static var _instance:DymainLoaderSource;
		public function DymainLoaderSource(signle:Signle)
		{
			inits();
		}
		public static function getInstance():DymainLoaderSource
		{
			if(_instance == null) _instance = new DymainLoaderSource(new Signle());
			return _instance;
		}
		
		/** 加载完资源后执行该方法 */
		public var execLoadCompleteFunction:Function;
		
		private function inits():void{
			Entrance.getInstance().Root.addChild(PublicProperty.source);
		}
		
		/**加载资源完成*/
		private function loadLoginComplete(e:Event):void{
//			PublicProperty.source.removeEventListener(BulkLoader.PROGRESS, ProgressListener.onProgress);
			PublicProperty.source.removeEventListener(Event.COMPLETE, loadLoginComplete);
			if(execLoadCompleteFunction != null ) execLoadCompleteFunction();
		}
		
		private var sourceID_arr:Vector.<DymainLoaderVO>;
		
		/** 开始加载主资源 
		 * @param $sourceID_arr		资源ID列表
		 */
		public function loadMainSource($sourceID_arr:Vector.<DymainLoaderVO>):void{
			sourceID_arr = $sourceID_arr;
			onShow();
			PublicProperty.source.Start();
		}
		
		/*--------------------------------------------------------------------*/
		
		private function onShow():void{
//			PublicProperty.source.addEventListener(BulkLoader.PROGRESS, ProgressListener.onProgress);
			PublicProperty.source.addEventListener(Event.COMPLETE, loadLoginComplete);
			
			if(!loopPushSource()) loadLoginComplete(null); 
		}
		
		private function loopPushSource():Boolean{
			//必要的开战资源列表
			var path_arr:Array = [];
			
			for (var i:int = 0; i < sourceID_arr.length; i++) {
				path_arr.push([sourceID_arr[i].path, sourceID_arr[i].keyID, sourceID_arr[i].desc]);
			}
			
			var _o:Boolean = false;
			for(i = 0 ; i < path_arr.length; i++){
				var _onf:Boolean = PublicProperty.source.Push(path_arr[i][0], path_arr[i][1], path_arr[i][2]);
				if(_onf){
					_o = true;
				}
			}
			
			return _o;
		}
		
	}
}
class Signle{}