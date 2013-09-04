package anlei.loading.utils
{
	import anlei.loading.node.LoaderNode;

	public class QueryNodeUtil
	{
		private static var nodeList:Vector.<LoaderNode> = new Vector.<LoaderNode>();
		private static var i:int = 0;
		private static var type:int = -1;
		
		public static function push(node:LoaderNode):void {
			nodeList.push(node);
			node.onComplete2 = onComplete;
		}
		
		private static function onComplete():void {
			i++;
			if(i > nodeList.length-1){//加载完所有队列
				type = -1;
				trace("加载完所有队列");
			}else{//轮询下个队列
				type = 1;
				nodeList[i-1].dispose();
				nodeList[i].list = nodeList[i].list;
				nodeList[i].start();
			}
		}
		
		public static function start():void {
			if(type == -1){
				type = 1;
				nodeList[i].start();
			}
		}
		
	}
}