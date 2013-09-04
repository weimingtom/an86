package anlei.erpg.utils
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import anlei.db.AccessDB;
	import anlei.util.LoaderSource;
	
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	public class AssetsPool
	{
		private static var _instance:AssetsPool;
		public function AssetsPool(signle:Signle) { }
		public static function getInstance():AssetsPool {
			if (_instance == null)
				_instance = new AssetsPool(new Signle());
			return _instance;
		}
		/////////////////////
		/////////////////////
		/////////////////////
		private var ERPG_NAME:String = 'erpg_name';
		public var source:LoaderSource;
		/**返回一个剪辑**/
		public function GetSourceMC(_class:String, _swfkey:String, _isRes:Boolean = false):*{
			if(source == null){
				try{
					var o:Object = getDefinitionByName(_class);
					if(o){
						var ClassReference:Class = o as Class;
						return new ClassReference;
					}
				}catch(e:Event){
					trace(e);
				}
			}
			
			var reSwfKey:LoadingItem = source.Bulk.get(_swfkey);
			if(reSwfKey == null) return null;
			if(_isRes) return reSwfKey;
			return reSwfKey.getDefinition(_class);
		}
		
		/////////////////////
		/////////////////////
		/////////////////////
		private var dict:Dictionary = new Dictionary();
		
		public function hasSource(key:String):Boolean{
			if(dict[key]) return true;
			return false;
		}
		public function getSource(cls:String, key:String, _isRes:Boolean=false):Object{
			var _mc:Object = GetSourceMC(cls, key, _isRes);
			if(_mc){
				if(!dict[key]) dict[key] = 0;
				dict[key]++;
				trace("add "+key+":", dict[key]);
			}
			return _mc;
		}
		public function dispose(url:String, key:String):void{
			if(dict[key]) dict[key]--;
			else return;
			trace("remove "+key+":", dict[key], dict[key] <= 0 ? "释放资源":"");
			if(dict[key] <= 0){
				delete dict[key];
				source.remove(url, key);
			}
		}
		public function loadSource(key:String, url:String, Quote:Object, onComplete:Function):void{
			if(source == null) source = new LoaderSource(ERPG_NAME);
			var loaderVO:DymainLoaderRoleVO = new DymainLoaderRoleVO();
			loaderVO.keyID = key;
			loaderVO.desc = '';
			loaderVO.path = url;
			
			var loaderVO_list:Vector.<DymainLoaderRoleVO> = new Vector.<DymainLoaderRoleVO>();
			loaderVO_list.push(loaderVO);
			
			var execDict:Function = function():void{
				delete DymainLoaderRole.getInstance().execLoadComDictFn[execDict['ying']];
				if(onComplete != null){
					onComplete();
					onComplete = null;
				}
				execDict = null;
			};
			execDict['ying'] = Quote;
			DymainLoaderRole.getInstance().execLoadComDictFn[execDict['ying']] = execDict;
			DymainLoaderRole.getInstance().loadMainSource(loaderVO_list);
		}
		
		public function toString():String{
			var _str:String = '';
			for(var _mc:Object in dict){
				var _name:String = String(_mc).split("_")[0];
				var _xml:XML = AccessDB.getInstance().zip.getFieldList("ae_monster_property", "skinId", _name);
				if(_xml) _name = _xml.name;
				if(!_xml){
					_xml = AccessDB.getInstance().zip.getFieldList("client_npc", "npcId", _name);
					if(_xml) _name = _xml.npcName;
				}
				if(!_xml) _name = '';
				_str += "\n" + _name + " " + _mc + ": " + dict[_mc];
			}
			_str = "AssetsPool:" + _str;
			return _str;
		}
		
	}
}
class Signle{}