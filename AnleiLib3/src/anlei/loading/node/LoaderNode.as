package anlei.loading.node
{
	import com.greensock.TweenLite;
	
	import anlei.loading.AnleiLoader;
	import anlei.loading.utils.ALoaderUtil;
	import anlei.loading.utils.RequestUtil;

	public class LoaderNode
	{
		
		public static var I:int = 0;
		public var II:int = 0;
		
		public var addi:int = 0;
		private var _list:Vector.<LoaderItemes>;
		public var onComplete:Function;
		public var onComplete2:Function;
		public var onProgress:Function;
		
		private var currLoadID:int = 0;
		public var totalSize:Number = 0;
		
		public var testName:String = '';
		
		public function loadNext():void {
			currLoadID++;
			if(list.length <= currLoadID){
				if(onComplete){
					AnleiLoader.getInstance().merger(_list);
					RequestUtil.setSameFinish(this);
					onComplete();
					onComplete2();
				}
			}else{
				if(list[currLoadID].finish){
					loadNext();
				}else{
					list[currLoadID].loader.start(loadNext, this);
				}
			}
		}
		
		private static var tween:TweenLite;
		
		public function restart():void{
			addi = 0;
			currLoadID = 0;
			if(tween) tween.kill();
			tween = TweenLite.delayedCall(0.5, start);
		}
		
		/**开始(会先获取总长度)*/
		public function start():void{
			I++;II=I;
			var _len:int = list.length;
			if(_len<=0){//如果列表长度为0，则不需要加载，直接执么完成方法
				onComplete();
				onComplete2();
			}else{
				for (var i:int = 0; i < _len; i++) {
					list[i].id = I;
					list[i].loader.getTotalSize(getTotalComplete);
				}
			}
		}
		
		private function getTotalComplete($totalSize:Number):void{
			totalSize+=$totalSize;
			addi++;
			//t.p(testName, "addi:", addi);
			if(addi >= list.length){
				onGetTotalComplete(-1);
				//t.p("onGetTotalComplete();", II);
			}
		}
		
		/**得到总长度后开始加载*/
		private function onGetTotalComplete($i:int):void {
			currLoadID = 0;
			list[$i+1].loader.start(loadNext, this);
		}

		public function get list():Vector.<LoaderItemes> { return _list; }
		public function set list(value:Vector.<LoaderItemes>):void {
			_list = value;
			for (var i:int = 0; i < list.length; i++) {
				list[i].node = this;
			}
			
			ALoaderUtil.trimReItem(list);
			ALoaderUtil.trimPoolItem(list);
		}
		
		
		public function dispose():void{
			_list = null;
			onComplete = null;
			onComplete2 = null;
			onProgress = null;
		}
		
	}
}