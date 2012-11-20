package net.an86.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class MyLoader extends Loader
	{
		private var path_str:String;
		private var onComplete:Function;
		private var loadContxt:LoaderContext;
		
		public var quest:URLRequest;
		protected var isLoading:Boolean = false;
		
		public function MyLoader($path:String, $onComplete:Function)
		{
			super();
			path_str = $path;
			onComplete = $onComplete;
			inits();
		}
		private function inits():void{
			quest = new URLRequest(path_str);
			contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			startLoad();
		}
		
		public function startLoad():void{
			if(!loadContxt){
				loadContxt = new LoaderContext(false,null,SecurityDomain.currentDomain);
			}
			try{
				load(quest, loadContxt);
			}catch(e:Object){
				load(quest);
			}
			isLoading = true;
		}
		
		private function onLoadComplete(e:Event):void{
			contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			//contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			isLoading = false;
			if(onComplete != null){
				onComplete();
			}
		}
		private function onError(e:IOErrorEvent):void{
			var _msg:String = "加载"+path_str+"文件时出错..............";
			trace(_msg);
			throw new Error(_msg);
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void{
			var _msg:String = "加载"+path_str+"文件时安全域出错..............";
			trace(_msg);
			throw new Error(_msg);
		}
		private function onProgress(e:ProgressEvent):void{
			var loaded:Number = e.bytesLoaded;
			var total:Number = e.bytesTotal;
			var obj:Object = {
				loaded:loaded,
				total:total
			}
		}
		public function dispose():void{
			if(isLoading) unloadAndStop();
			isLoading = false;
		}
		override public function unloadAndStop(gc:Boolean = true):void{
			super.unloadAndStop(gc);
			
			if(isLoading){
				try{
					close();
				}catch(e:*){
					trace("没有来得及加载外部文件!");
				}
			}
			unload();
			unloadAndStop(gc);
			isLoading = false;
		}
		
	}
}