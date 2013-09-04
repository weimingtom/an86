package ui.component
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TriggerAnimation extends EventDispatcher
	{
		public static const TRIGGER:String = 'TriggerAnimation';
		private var timer:Timer;
		private var gaptime:int;
		private var rndlen:int;
		private var WayNum:int;
		/**
		 * 定时触发器， 用于人物随机行走时改变方向
		 * 
		 * @param _gapTimer		多久触发一次
		 * @param _len			随机的最大数
		 * 
		 */		
		public function TriggerAnimation(_gapTimer:int = 1000, _len:int = 3)
		{
			gaptime = _gapTimer;
			rndlen = _len;
			inits();
		}
		private function inits():void
		{
			timer = new Timer(gaptime, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			resetTimer();
		}
		/**
		 * 释放资源
		 */		
		public function dispose():void{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			
			timer = null;
			gaptime = 0;
			rndlen = 0;
			WayNum = 0;
		}
		private function onTimer(e:TimerEvent):void 
		{
			resetTimer();
		}
		/***
		 * 如果 _ut不等于-1 时，就不用随机选。
		 * 如果 _ut等于-1时，就随机选。
		 * **/
		private function resetTimer(_ut:int = -1):void
		{
			timer.stop();
			timer.reset();
			timer.start();
			if (_ut != -1) {
				WayNum = _ut;
			}else{
				WayNum = Wayrnd();
			}
			this.dispatchEvent(new Event(TRIGGER));
		}
		/**
		 * 任意获取一个随机数
		 */		
		public function Wayrnd():int{
			return int(Math.random() * rndlen);
		}
		public function get Gap():int{
			return gaptime;
		}
		
		public function get RndLen():int{
			return rndlen;
		}
		
		public function get Value():int{
			return WayNum;
		}
		/**
		 * 多久触发一次
		 */		
		public function set Gap(_int:int):void{
			gaptime = _int;
			timer.delay = gaptime;
		}
		/**
		 * 随机的最大数
		 */		
		public function set RndLen(_int:int):void{
			rndlen = _int;
		}
		
	}
}