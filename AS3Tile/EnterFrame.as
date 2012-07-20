package 
{
	import flash.display.Stage;
	import flash.events.Event;

	public class EnterFrame
	{
		private static var Root:Stage;
		
		/**所有要循环的方法池*/		
		//private static var fnarr:Vector.<Function> = new Vector.<Function>;
		private static var fnarr:Array = [];
		//每增加一个方法，该值都会增加1
		private static var arrlen:int = 0;
		
		/**设置要循环的方法*/
		public static function set enterFrame(fn:Function):void{
			if(fn != null){
				fnarr.push(fn);
				arrlen = fnarr.length;
			}
		}
		/**移除要死循环的方法*/
		public static function set removeEnterFrame(fn:Function):void{
			if(fn != null){
				var _index:int = fnarr.indexOf(fn);
				if(_index != -1){
					removeNode(_index);
					arrlen = fnarr.length;
				}
			}
		}
		
		/**开始进入帧死循环*/
		public static function StartEnterFrame($root:Stage):void{
			if(!$root.hasEventListener(Event.ENTER_FRAME)){
				Root = $root;
				Root.addEventListener(Event.ENTER_FRAME, onEnter);
			}
		}
		/**停止进入帧死循环*/
		private static function StopEnterFrame():void{
			Root.removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		/**断开或删除方法池中的一个方法*/		
		private static function removeNode(removeIndex:uint):void{
			fnarr.splice(removeIndex, 1);
		}
		/**执行每个方法体*/		
		private static function onEnter(e:Event):void{
			for(var i:int = 0 ; i < arrlen; i++){
				fnarr[i].apply();
			}
		}
		
	}
}