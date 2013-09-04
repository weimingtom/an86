package anlei.loading.events
{
	import flash.events.ProgressEvent;
	
	import anlei.loading.node.LoaderNode;
	
	public class ALoaderProgressEvent extends ProgressEvent
	{
		/**当前加载的文件总大小*/
		public var currentBytesTotal:Number;
		public var node:LoaderNode;
		
		public function ALoaderProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:Number=0, bytesTotal:Number=0)
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}