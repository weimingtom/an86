package anlei.util
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
   
	public class EnterFrame
	{
		private static var Root:Stage;
		private static var _record:Number;
		private static var _delay:Number;
		
		/**所有要循环的方法池*/		
		private static var fnarr:Vector.<Function> = new Vector.<Function>;
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
		/**初始化并进入帧死循环*/
		public static function init($root:Stage):void{
			if(!$root.hasEventListener(Event.ENTER_FRAME)){
				Root = $root;
				StartEnterFrame();
			}
		}
		/**开始进入帧死循环*/
		public static function StartEnterFrame():void{
			if(!Root.hasEventListener(Event.ENTER_FRAME)){
				_record = getTimer();
				_delay = 1000/Root.frameRate;
				Root.addEventListener(Event.ENTER_FRAME, onEnter);
			}
		}
		/**停止进入帧死循环*/
		public static function StopEnterFrame():void{
			Root.removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		/**查找并返回一个方法*/
		public static function hasFunction($fn:Function):Function{
			var _index:int = fnarr.indexOf($fn);
			var _fn:Function = null;
			if(_index != -1){
				_fn = fnarr[_index];
			}
			return _fn;
		}
		
		/**断开或删除方法池中的一个方法*/		
		private static function removeNode(removeIndex:uint):void{
			var tem:Vector.<Function> = new Vector.<Function>;
			for(var i:int = 0 ; i < fnarr.length; i++){
				if(i == removeIndex){
					continue;
				}
				tem.push(fnarr[i]);
			}
			fnarr = tem;
		}
		/**执行每个方法体*/		
		private static function onEnter(e:Event):void{
			
			while(getTimer() - _record >= _delay)
			{
				_record += _delay;
				for(var i:int = 0 ; i < arrlen; i++){
					fnarr[i].apply();
				}
			}
		}
		
	}
}