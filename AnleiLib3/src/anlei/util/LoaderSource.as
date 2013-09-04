package anlei.util
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import Events.GlobalEvent;
	
	import anlei.debug.ApplicationStats;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import ui.component.MyLoader;
	
	public class LoaderSource extends EventDispatcher
	{
		private var _loader:BulkLoader;
		private var _loadername:String;
		private var _fileVector:Vector.<String> = new Vector.<String>();
		
		public function LoaderSource(loadername:String)
		{
			_loadername = loadername;
			_loader = new BulkLoader(_loadername);
			_loader.addEventListener(BulkLoader.ERROR, onError);
			_loader.addEventListener(BulkLoader.SECURITY_ERROR, onSecurityError);
			_loader.addEventListener(BulkLoader.PROGRESS, onProgres);
			_loader.addEventListener(BulkLoader.COMPLETE, onComplete);
		}
		public function Push(_file:String, _id:String, _desc:String, _type:String = null):Boolean{
			_file = MyLoader.setUrlHttp(_file);
			var _flag:int = _fileVector.indexOf(_file);
			if(_flag != -1){trace("********************************************重复加载的文件被返回:",_id,'[',_file,']********************************************'); return false;}
			if(_file == '' || _file == ' ') return false;
			if(_id != '' && _id != ' '){
				var _prop:Object = {id:_id, desc:_desc + "&"+PublicProperty.BUILDER_VERSION};
				_type && (_prop.type = _type)
				_loader.add(_file, _prop);
			}else{
				_loader.add(_file);
			}
			//trace("加载的文件被返回:",_id,'[',_file,']');
			//_fileVector.push(_id);
			return true;
		}
		public function remove(_file:String, _id:String):void{
			var _flag:int = _fileVector.indexOf(_file);
			if(_flag != -1){
				_fileVector.splice(_flag, 1);
			}
			//_loader.remove(_file);
			_loader.remove(_id);
		}
		public function Start():void{
			_loader.start();
		}
		
		/**是否存在已加载好的url
		public function hasUrl(url:String):Boolean{
			for each (var _item:LoadingItem in _loader._items) {
				if(_item.url.url == url){
					return true;
				}
			}
			return false;
		}*/
		
		public function hasUrl(url:String):Boolean{
			return _loader._contents.hasOwnProperty(url);
		}
		
		private function onError(e:ErrorEvent):void{
			var _log:String = "\n加载..........\n******"+e.text.toString()+"******\n..........文件时出错";
			ApplicationStats.getInstance().push(_log);
//			throw new Error(_log);
		}
		private function onSecurityError(e:*):void{
			var _log:String = "\n加载文件域..........\n******"+e.text.toString()+"******\n..........文件时出错";
			ApplicationStats.getInstance().push(_log);
//			throw new Error(_log);
		}
		private function onProgres(e:BulkProgressEvent):void{
			this.dispatchEvent(new GlobalEvent(BulkLoader.PROGRESS, e));
		}
		private function onComplete(e:Event):void{
			for(var _name:String in e.target.contents){
				if(_fileVector.indexOf(_name) == -1){
					_fileVector.push(_name);
				}
			}
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		public function get Bulk():BulkLoader{ return _loader; }
		/** 加载当前文件的说明 */		
		public function get currentDesction():String{
			if(Bulk.itemsLoaded <= 0 || Bulk.items.length <= Bulk.itemsLoaded) return "";
			return 	Bulk.items[Bulk.itemsLoaded-1].description;
		}
	}
}