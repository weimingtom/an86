package anlei.erpg.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import anlei.erpg.role.AbsERole;

	/**深度排序*/
	public class SceneLayerEnter
	{
		/**所要参与排序的容器*/
		public static var actionLayer:Sprite;
		/**开始实时排序*/
		public static function onEnter(e:Event = null):void
		{
			if(actionLayer != null){
				var sortedLayers:Array = [];
				var maxNum:int = actionLayer.numChildren;
				for(var i:int = 0 ; i < maxNum; i++){
					sortedLayers.push(actionLayer.getChildAt(i));
				}
				
				//sortedLayers.sortOn("y", Array.DESCENDING);
				sortedLayers.sort(onSort, Array.DESCENDING);
				
				var item:* = null;
				var child:* = null;
				for (i = 0; i < maxNum; i++) {
					item = sortedLayers[i];
					child = actionLayer.getChildAt(i);
					if (child != null && item != null && child != item) {
						actionLayer.swapChildren(child, item);
					}
				}
				
			}
			
		}
		
		private static function onSort(a:AbsERole, b:AbsERole):int {
			if (a.y > b.y) {
				return -1;
			} else {
				if(a.y == b.y){
					a.y = a.y + a.SORT_ID;
					return -1;
				}
				return 1;
			}
			return 0;
		}
		
		
	}
}