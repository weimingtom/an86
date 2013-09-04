package ui.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import Events.GlobalEvent;
	
	import anlei.util.EnterFrame;
	
	/**
	 * 特别用于iPhone(IOS)开发
	 * 使用指定的 delay 和 repeatCount 状态构造新的 MyTimer 对象
	 * 
	 * 
	 * 
			var myTimer:MyTimer = new MyTimer(1000);
			myTimer.addEventListener(MyTimer.TIMER, function(e:*):void{
				trace(e.OBJECT);
			});
			myTimer.start();
			
			
	  
	 * @author Anlei	http://www.an86.net
	 * 
	 */	
	public class MyTimer extends EventDispatcher
	{
		/**
		 * 每次累加时发出的事件
		 */		
		public static const TIMER:String = 'add_active';
		public static const TIMER_COMPLETE:String = 'added_active_complete';
		
		private var _delay:Number;//延迟
		private var _second:Number;
		private var _repeatCount:Number;//计时器运行总次数。
		private var _currentCount:uint = 0;
		
		private var _timerID:uint = 0;//每次时段累加的秒数
		private var _oldtime:uint;//记录上次的时间
		private var _initTime:uint;//记录第一次的时间，以用于矫正误差
		private var _running:Boolean = false;
		
		private var disp:Sprite;
		/**
		 * 使用指定的 delay 和 repeatCount 状态构造新的 MyTimer 对象
		 * @param delay			豪秒延时
		 * @param repeatCount	触发多少次(0为无限)
		 * 
		 */
		public function MyTimer(delay:Number, repeatCount:int = 0)
		{
			_delay = delay;
			_second = delay*0.001;
			_repeatCount = repeatCount;
			disp = new Sprite();
		}
		
		/**
		 * 如果计时器正在运行，则停止计时器，并将 currentCount 属性设回为 0，这类似于秒表的重置按钮。 Timer 
		 */
		public function reset():void {
			_timerID = 0;
			_oldtime = getTimer();
			start();
			_currentCount++;
		}
		
		/**
		 * 如果计时器尚未运行，则启动计时器。
		 */
		public function start():void {
			_running = true;
			_oldtime = getTimer();
			_initTime = _oldtime;
			
			EnterFrame.removeEnterFrame = onEnter;
			EnterFrame.enterFrame = onEnter;
		}
		
		/**
		 * 停止计时器。
		 */
		public function stop():void {
			_running = false;
			EnterFrame.removeEnterFrame = onEnter;
		}
		
		/**
		 * [read-only] 计时器从 0 开始后触发的总次数
		 */		
		public function get currentCount():uint{ 
			return _currentCount;
		}
		
		/**
		 * 计时器事件间的延迟（以毫秒为单位）。
		 */		
		public function get delay():Number{
			return _delay;
		} 
		public function set delay(value:Number):void{
			_delay = value;
			_second = value*0.001;
		}
		
		/**
		 * 计时器运行的次数。
		 */		
		public function get repeatCount():uint{
			return _repeatCount;
		}
		public function set repeatCount(value:uint):void{
			_repeatCount = value;
		}
		 
		/**
		 * [read-only] 计时器的当前状态；如果计时器正在运行，则为 true，否则为 false。
		 */		
		public function get running() : Boolean{
			return _running;
		}
		
		/*****--------------------------------------******/
		/**
		 * 实时计算秒数
		 * 每次记录当前与下一个时间的相差值(getTimer())
		 * @param e
		 * 
		 */		
		private var moveDate:Number=0;
		private var lastDate:Number=0;
		private function onEnter(e:Event = null):void{
			while(getTimer()-_oldtime>=delay)
			{
				if(_second>=1){
					var da:Date =new Date();
					var dagt:Number = da.getTime();
					moveDate = (dagt+100) * 0.001;
					if(moveDate<lastDate + _second){
						_oldtime = getTimer();
						continue;
					}
					lastDate = dagt * 0.001;
				}
				
				_oldtime += delay;
				_timerID++;
				_currentCount++;
				if(_currentCount%60 == 0){
					var gtt:uint = getTimer();
					_timerID = (gtt-_initTime)*0.001;
					_oldtime = gtt;
				}
				if(running) this.dispatchEvent(new GlobalEvent(TIMER, _timerID));
				if(_timerID == repeatCount){
					onEnd();
					break;
				}
			}
		}
		private function onEnd():void{
			_timerID = 0;
			_oldtime = getTimer();
			EnterFrame.removeEnterFrame = onEnter;
			
			_running = false;
			this.dispatchEvent(new Event(TIMER_COMPLETE));
		}

	}
}
