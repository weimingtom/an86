package anlei.erpg.utils
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * 动态加载资源类
	 * @author Anlei
	 */
	public class DymainLoaderRole
	{
		private static var _instance:DymainLoaderRole;
		public function DymainLoaderRole(signle:Signle)
		{
			inits();
		}
		public static function getInstance():DymainLoaderRole
		{
			if(_instance == null) _instance = new DymainLoaderRole(new Signle());
			return _instance;
		}
		
		/** 加载完资源后执行该方法 */
		public var execLoadComDictFn:Dictionary = new Dictionary();
		
		private function inits():void{
//			Entrance.getInstance().Root.addChild(source);
		}
		
		/**加载资源完成*/
		private function loadLoginComplete(e:Event):void{
			AssetsPool.getInstance().source.removeEventListener(Event.COMPLETE, loadLoginComplete);
			
			for(var _name:Object in execLoadComDictFn){
				execLoadComDictFn[_name]();
			}
		}
		
		private var sourceID_arr:Vector.<DymainLoaderRoleVO>;
		
		/** 开始加载主资源 
		 * @param $sourceID_arr		资源ID列表
		 */
		public function loadMainSource($sourceID_arr:Vector.<DymainLoaderRoleVO>):void{
			sourceID_arr = $sourceID_arr;
			onShow();
			AssetsPool.getInstance().source.Start();
		}
		
		/*--------------------------------------------------------------------*/
		
		private function onShow():void{
			AssetsPool.getInstance().source.addEventListener(Event.COMPLETE, loadLoginComplete);
			if(!loopPushSource()) loadLoginComplete(null); 
		}
		
		private function loopPushSource():Boolean{
			var path_arr:Array = [];
			
			for (var i:int = 0; i < sourceID_arr.length; i++) {
				path_arr.push([sourceID_arr[i].path, sourceID_arr[i].keyID, sourceID_arr[i].desc]);
			}
			
			var _o:Boolean = false;
			for(i = 0 ; i < path_arr.length; i++){
				var _onf:Boolean = AssetsPool.getInstance().source.Push(path_arr[i][0], path_arr[i][1], path_arr[i][2]);
				if(!_onf){
					_onf = !AssetsPool.getInstance().source.hasUrl(path_arr[i][0]);
				}
				if(_onf){
					_o = true;
				}
			}
			
			sourceID_arr = null;
			return _o;
		}
		
	}
}
class Signle{}