package anlei.loading.utils
{
	import flash.utils.Dictionary;
	
	import anlei.loading.node.LoaderItemes;
	import anlei.loading.node.LoaderNode;

	public class RequestUtil
	{
		private static var diction:Dictionary = new Dictionary();
		
		/**是否存在列表*/
		public static function getWait($item:LoaderItemes):Boolean {
			return diction[$item.url];
		}
		
		/**添加(创建)一个不同的等待列表*/
		public static function addWait($item:LoaderItemes):void {
			diction[$item.url] = new Vector.<LoaderItemes>();
		}
		
		/**已有正在加载的请求存在，所以添加到等待完成中*/
		public static function addLoading($item:LoaderItemes):void {
			if(diction.hasOwnProperty($item.url)){
				diction[$item.url].push($item);
			}
		}
		
		/**完成加载时，把待列表所有项设成完成加载状态*/
		public static function setSameFinish($node:LoaderNode):void{
			var nodeList:Vector.<LoaderItemes> = $node.list;
			if(nodeList){
				var len:int = nodeList.length;
				for each (var _nodeItem:LoaderItemes in nodeList) {
					if(diction.hasOwnProperty(_nodeItem.url)){
						var list:Vector.<LoaderItemes> = diction[_nodeItem.url];
						for each (var _item:LoaderItemes in list) {
							if(_item.url == _nodeItem.url){
								_item.finish = true;
								_item.node.restart();
								//t.p("setSameFinish:", _item.url);
							}
						}
						delete diction[_nodeItem.url];
					}
					//delete diction[_nodeItem.url];
				}
			}
			
		}
		
	}
}