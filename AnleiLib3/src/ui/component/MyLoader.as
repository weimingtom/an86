package ui.component
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	import Events.GlobalEvent;
	
	import anlei.util.PublicProperty;

	public class MyLoader extends Loader
	{
		public var data:Object;
		private var path_str:String;
		private var onComplete:Function;
		private var loadContxt:LoaderContext;
		
		public var quest:URLRequest = new URLRequest();
		protected var isLoading:Boolean = false;
		public var isLoaded:Boolean = false;
		
		private var isParam:Boolean;
		private var isStart:Boolean;
		
		public function MyLoader($path:String, $onComplete:Function, $isParam:Boolean = false, $isStart:Boolean = true)
		{
			super();
			path_str = $path;
			onComplete = $onComplete;
			isParam = $isParam;
			isStart = $isStart;
			inits();
		}
		private function inits():void{
			contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			if(isStart) setQuestUrl(path_str);
		}
		
		public static function setUrlHttp(value:String):String{
			if(value){
				var _index:int;
				var _resStr:String = "";
				var _lanStr:String = "";
				var _xml:XML = PublicProperty.CONFIG_XML;
				if(_xml){
					_resStr = _xml.sourcelang;
					_lanStr = _xml.lang.split(".")[0];
				}
				if(_lanStr != "cn"){
					var _resArr:Array = _resStr.split(",");
					var _len:int = _resArr.length;
					for (var i:int = 0; i < _len; i++) {
						_index = value.indexOf(_resArr[i]);
						if(_index != -1 && _resArr[i]){
							var _str:String = _resArr[i];
							var _arr:Array = _str.split(".");
							_str = _arr[0] + "_" + _lanStr + "." + _arr[1];
							value = value.replace(_resArr[i], _str);
						}
					}
				}
				
				_index = value.indexOf("http://");
				if(_index == -1){
					var sourceURL:String = "";//PublicProperty.CONFIG_XML.source.@path;
					if(_xml){
						sourceURL = _xml.source.@path;
					}
					
					
					value = sourceURL + value;
				}
			}
			return value;
		}
		
		public function setQuestUrl($url:String):void{
			path_str = setUrlHttp($url);
			if(path_str){
				//setPath_str();
				startLoad();
			}
		}
		
		public function startLoad():void{
			if(!loadContxt){
				loadContxt = new LoaderContext(false,null,SecurityDomain.currentDomain);
			}
			setPath_str();
			try{
				load(quest, loadContxt);
			}catch(e:Object){
				load(quest);
			}
			isLoading = true;
		}
		
		private function setPath_str():void{
			if(path_str){
				quest.url = path_str + "?"+PublicProperty.BUILDER_VERSION;
			}
		}
		
		private function removeEvent():void{
			contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			//contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function onLoadComplete(e:Event):void{
			removeEvent();
			isLoading = false;
			isLoaded = true;
			if(onComplete != null){
				if(isParam){
					onComplete(this);
				}else{
					onComplete();
				}
			}
		}
		private function onError(e:IOErrorEvent):void{
			var _msg:String = "加载"+path_str+"文件时出错..............";
			this.dispatchEvent(new GlobalEvent(IOErrorEvent.IO_ERROR, _msg));
			//throw new Error(_msg);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void{
			var _msg:String = "加载"+path_str+"文件时安全域出错..............";
			this.dispatchEvent(new GlobalEvent(SecurityErrorEvent.SECURITY_ERROR, _msg));
			//throw new Error(_msg);
		}
		private function onProgress(e:ProgressEvent):void{
			var loaded:Number = e.bytesLoaded;
			var total:Number = e.bytesTotal;
			var obj:Object = {
				loaded:loaded,
				total:total
			}
		}
		
		public function getResource($name:String):Object{
			var _cls:Class = getClass($name);
			return new _cls();
		}
		
		public function getClass($name:String):Class{
			return this.contentLoaderInfo.applicationDomain.getDefinition($name) as Class;
		}
		
		public function dispose():void{
			//if(isLoading) unloadAndStop();
			if(contentLoaderInfo)
				contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			removeEvent();
			unloadAndStop();
			isLoading = false;
			onComplete = null;
			loadContxt = null;
			data = null;
			quest = null;
		}
		override public function unloadAndStop(gc:Boolean = true):void{
			unload();
			super.unloadAndStop(gc);
			
			if(isLoading){
				try{
					close();
				}catch(e:*){
					trace("没有来得及加载外部文件就被释放了");
				}
			}
			isLoading = false;
		}
		
	}
}