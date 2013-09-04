package ui.component
{
	import Events.GlobalEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 数值时钟倒时时组件
	 * 
	 * var txt:MyTextField = new MyTextField();
			txt.filters = PublicProperty.TextFilter();
			addChild(txt);
			txt.move(100,100);
			var myClock:MyLedClock = new MyLedClock();
			myClock.setTime(123456);
			myClock.isDay = true;
			myClock.countDown = true;
			myClock.addEventListener(MyLedClock.ADDFRAME, function():void{
				txt.text = myClock.currentLed + "," + myClock.Second;
			});
			myClock.addEventListener(MyLedClock.TIMEOVER, function():void{
				trace("时间结束!");
			});
			stage.addEventListener(MouseEvent.CLICK, function():void{
				myClock.setTime(12);
				//myClock.stop();
			});
	 * @author Anlei
	 * 
	 */	
	public class MyLedClock extends EventDispatcher
	{
		/** 天的表达示*/ 
		public static var DAY_String:String="Day";
		/**
		 * 倒计时结束后派发该事件
		 */ 
		public static const TIMEOVER:String="time_over";
		/**
		 * 每次延时触发时发出的事件
		 */		
		public static const ADDFRAME:String = 'addframe';
		/**
		 * 跨小时
		 */		
		public static const CROSS_MINUTES:String = 'cross_minutes';
		
		private var _timer:MyTimer;
		private var _time:uint;//秒数，随着计时器的增减
		private var _initSecond:uint;//该属性只是为了存一个数值而已
		
		/**
		 * 是否为倒计时
		 * true表示倒计时
		 * false 表示正常时钟行走
		 */
		public var countDown:Boolean=true;  
		private var _isday:Boolean = false;
		
		
		private var __hours:uint;//小时
		private var __minutes:uint;//分钟
		private var __secondes:uint;//秒
		
		public function MyLedClock()
		{
			_timer=new MyTimer(1000);
			_timer.addEventListener(MyTimer.TIMER,timerComplete);			
		}
		/**销毁定时器*/
		public function dispose():void{
			if(_timer!=null){
				_timer.reset();
				_timer.stop();
				_timer.removeEventListener(MyTimer.TIMER, timerComplete);
				_timer = null;
			}
		}
		private function timerComplete(evt:GlobalEvent = null ):void{
			if(countDown){
				_time--;
				if(_time<=0){
					_timer.reset();
					_timer.stop();
					dispatchAddframe();
					this.dispatchEvent(new Event(TIMEOVER));
					return;
				}
			}else{
				_time++;
				if(_time % 3600 == 0) this.dispatchEvent(new Event(CROSS_MINUTES));
			}
			dispatchAddframe();
//			_timer.reset();
//			_timer.stop();
//			_timer.start();
		}
		private function dispatchAddframe():void{
			this.dispatchEvent(new Event(ADDFRAME));
		}
		/** 设置时间 
		 * @param value 秒
		 */
		public  function setTime(value:uint):void{
//			_timer.reset();
//			_timer.stop();
			this._time=value;
			dispatchAddframe();
			if(!_timer.running){
				_timer.reset();
			}
		}
		/** 停止计时器 */		
		public function stop():void{
			if(_timer!=null){
				_timer.reset();
				_timer.stop();
			}
		}
		/**返回当前全时的秒数*/
		public function get Second():uint{ return _time; }
		
		/**初始时间**该属性只是为了存一个数值而已*/
		public function get initSecond():uint{ return _initSecond; }
		public function set initSecond(_value:uint):void{ _initSecond = _value; }
		
		/**是否要显示天数**/
		public function get isDay():Boolean{ return _isday; }
		public function set isDay(_onf:Boolean):void {
			_isday = _onf;
		}
		/**
		 * 返回当前倒计时的时间
		 */		
		public function get currentLed():String{
			return returnLed(this.Second);
		}
		
		private static var _ins:MyLedClock = new MyLedClock();
		/**返回格式化后的时间*/
		public static function getLED(time:uint, isDay:Boolean = false):String{
			_ins.isDay = isDay;
			return _ins.returnLed(time);
		}
		/**
		 * 传入秒数显示LED格式 34:22:21
		 */		
		public function returnLed(time:uint):String{
			if(time<=0)time=_time;
			
			var timeStr:String = '';
			
			if (_isday) {
				var _day:uint = Math.floor(time / (3600 * 24));
				time -= _day * 3600 * 24;
				timeStr = _day + ' '+DAY_String+' ';
			}
			
			__hours = Math.floor(time/3600);
			time -= (__hours*3600);
			__minutes=time/60;
			time-=(__minutes*60);
			__secondes=time;
			if(__hours/10<1){
				timeStr += "0"+__hours.toString()+":";
			}else{
				timeStr += __hours.toString()+":";
			}
			if(__minutes/10<1){
				timeStr+="0"+__minutes.toString()+":";
			}else{
				timeStr+=__minutes.toString()+":";
			}
			if(__secondes/10<1){
				timeStr+="0"+__secondes.toString();
			}else{
				timeStr+=__secondes.toString();
			}
			return timeStr;
		}
		
		public function get day():uint{
			var _day:uint = Math.floor(_time / (3600 * 24));
			return _day;
		}

		public function get hours():uint
		{
			currentLed;
			return __hours;
		}

		public function set hours(value:uint):void
		{
			__hours = value;
		}

		public function get minutes():uint
		{
			currentLed;
			return __minutes;
		}

		public function set minutes(value:uint):void
		{
			__minutes = value;
		}

		public function get secondes():uint
		{
			currentLed;
			return __secondes;
		}

		public function set secondes(value:uint):void
		{
			__secondes = value;
		}


	}
}