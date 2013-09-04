package anlei.loading
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLLoader;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import anlei.loading.node.LoaderItemes;
	import anlei.loading.node.LoaderNode;
	import anlei.loading.utils.ALoaderUtil;
	import anlei.loading.utils.QueryNodeUtil;

	public class AnleiLoader
	{
		
		private static var _instance:AnleiLoader;
		public function AnleiLoader(signle:Signle) { inits(); }
		
		public static function getInstance():AnleiLoader {
			if (_instance == null)
				_instance = new AnleiLoader(new Signle());
			return _instance;
		}
		
		private function inits():void {
			
		}
		
		/**版本号*/
		public var version:int;
		public var poolList:Vector.<LoaderItemes>;
		
		internal function add(value:LoaderItemes):void{
			if(value){
				if(!poolList) poolList = new Vector.<LoaderItemes>();
				poolList.push(value);
			}
		}
		
		public function merger($list:Vector.<LoaderItemes>):void{
			if(!poolList) poolList = new Vector.<LoaderItemes>();
			//t.p("Loader池合并前:", poolList.length);
			ALoaderUtil.trimPoolItem($list);
			poolList = poolList.concat($list);
			//t.p("Loader池合并后:", poolList.length);
		}
		
		public function remove(id:int):void{
			var _len:int = poolList.length;
			for (var i:int = 0; i < _len; i++) {
				if(poolList[i].id == id){
					poolList.splice(i, 1);
					break;
				}
			}
		}
		
		public function getData(key:String):Object{
			return URLLoader(getLoader(key)).data;
		}
		
		public function getResource(key:String, clsName:String):*{
			var _cls:Class = getClass(key, clsName);
			if(_cls) return new _cls();
			return null;
		}
		
		public function getClass(key:String, clsName:String):*{
			var _load:Loader = Loader(getLoader(key));
			var applicationDomain:ApplicationDomain = _load.contentLoaderInfo.applicationDomain;
			var _c:Class = applicationDomain.getDefinition(clsName) as Class;
			return _c;
		}
		
		public function getBitmap(key:String):Bitmap {
			return getLoader(key).content as Bitmap;
		}
		
		public function getLoader(key:String):* {
			for each (var _item:LoaderItemes in poolList) {
				if(_item.key == key) return _item.loader.getLoader();
			}
			return null;
		}
		
		public function start($list:Vector.<LoaderItemes>, $onComplete:Function, $onProgress:Function):void{
			var _node:LoaderNode = new LoaderNode();
			_node.list = $list;
			_node.onComplete = $onComplete;
			_node.onProgress = $onProgress;
			QueryNodeUtil.push(_node);
			QueryNodeUtil.start();
		}
		
	}
}
class Signle{}