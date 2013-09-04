package anlei.loading.node
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	import anlei.loading.AnleiLoader;
	import anlei.loading.events.ALoaderProgressEvent;
	import anlei.loading.utils.RequestUtil;

	public class LoaderContent
	{
		private var item:LoaderItemes;
		
		private var quest:URLRequest;
		private var swf_loader:Loader;
		private var txt_loader:URLLoader;
		
		public var totalSize:Number;
		
		/////////////
		private var isGetTotal:Boolean = false;
		private var getTotalExec:Function;
		private var onComplete_loadNext:Function;
		private var node:LoaderNode;
		private var proEvent:ALoaderProgressEvent = new ALoaderProgressEvent(ProgressEvent.PROGRESS);

		private var lc:LoaderContext;

		public function LoaderContent(value:LoaderItemes) {
			item = value;
		}
		
		public function getTotalSize($getTotalExec:Function):void{
			if(RequestUtil.getWait(item)){
				RequestUtil.addLoading(item);
				return;
			}else{
				RequestUtil.addWait(item);
			}
			//if(isGetTotal) return;
			getTotalExec = $getTotalExec;
			getProgress();
			isGetTotal = true;
		}
		
		private function getProgress():void{
			isGetTotal = false;
			var _url:String = item.url+"?" + AnleiLoader.getInstance().version;
			if(!quest) quest = new URLRequest(_url);
			if(!lc) lc = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain.parentDomain), SecurityDomain.currentDomain);
			if(item.type == LoaderItemes.SWF_TYPE){
				swf_loader = new Loader();
				swf_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress_swf);
				swf_loader.load(quest);
				/*try{
					swf_loader.load(quest, lc);
				}catch(e:*){
				}*/
			}else{
				txt_loader = new URLLoader(quest);
				if(item.isBinary){
					txt_loader.dataFormat = URLLoaderDataFormat.BINARY;
				}
				txt_loader.addEventListener(ProgressEvent.PROGRESS, onProgress_txt);
			}
		}
		
		private function onProgress_swf(event:ProgressEvent):void {
			if(isGetTotal){
				totalSize = event.bytesTotal;
				swf_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress_swf);
				swf_loader.close();
				//t.p("totalSize:", item.id, totalSize);
				if(getTotalExec!=null){
					getTotalExec(totalSize);
					getTotalExec = null;
				}
			}
		}
		
		private function onProgress_txt(event:ProgressEvent):void {
			if(isGetTotal){
				totalSize = event.bytesTotal;
				txt_loader.removeEventListener(ProgressEvent.PROGRESS, onProgress_txt);
				txt_loader.close();
				//t.p("totalSize:", item.id, totalSize);
				if(getTotalExec!=null){
					getTotalExec(totalSize);
					getTotalExec = null;
				}
			}
		}
		
		public function start($onComplete_loadNext:Function, $node:LoaderNode):void{
			if(onComplete_loadNext){
				if(item.finish){
					onComplete_loadNext();
					return;
				}else{
					if(item.type == LoaderItemes.SWF_TYPE){
						swf_loader.close();
					}else{
						txt_loader.close();
					}
				}
			}
			onComplete_loadNext = $onComplete_loadNext;
			node = $node;
			proEvent.node = node;
			if(item.type == LoaderItemes.SWF_TYPE){
				swf_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress_start);
				swf_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete_start);
				swf_loader.load(quest);
			}else{
				txt_loader.addEventListener(ProgressEvent.PROGRESS, onProgress_start);
				txt_loader.addEventListener(Event.COMPLETE, onComplete_start);
				txt_loader.load(quest);
			}
		}
		
		private function onComplete_start(event:Event):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, onComplete_start);
			event.currentTarget.removeEventListener(ProgressEvent.PROGRESS, onProgress_start);
			proEvent.bytesLoaded = node.totalSize;
			node.onProgress(proEvent);
			item.finish = true;
			if(onComplete_loadNext){
				onComplete_loadNext();
				onComplete_loadNext = null;
			}
		}
		
		private function onProgress_start(event:ProgressEvent):void {
			proEvent.bytesTotal = node.totalSize;
			proEvent.currentBytesTotal = event.bytesTotal;
			proEvent.bytesLoaded = event.bytesLoaded;
			node.onProgress(proEvent);
		}
		
		
		public function getLoader():*{
			if(swf_loader) return swf_loader;
			return txt_loader;
		}
		
		
	}
}