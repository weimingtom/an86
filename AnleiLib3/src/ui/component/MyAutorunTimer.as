package ui.component
{
	import Events.GlobalEvent;
	
	import flash.events.Event;
	
	import ui.abs.AbstractComponent;
	import ui.event.MyAutorunTimerEvent;
	
	
	[Event(name="AUTO_CENCEL", type="ui.event.MyAutorunTimerEvent")]
	[Event(name="SECOND_TRIGGER", type="ui.event.MyAutorunTimerEvent")]
	
	/**
	 * 秒针时钟倒时时组件
	 * @author Aneli
	 */
	public class MyAutorunTimer extends MySprite implements AbstractComponent
	{
		
		private var _timer:MyTimer;
		
		public var label_txt:MyTextField;
		private var _delayCount:uint;
		
		public function MyAutorunTimer()
		{
			inits();
		}
		private function inits():void{
			label_txt = new MyTextField();
			addChild(label_txt);
		}
		private function onTimer(e:GlobalEvent):void{
			_delayCount --;
			if(_delayCount <= 0){
				this.dispatchEvent(new Event(MyAutorunTimerEvent.AUTO_CENCEL));
				_timer.stop();
				label = '0';
				return;
			}
			label = _delayCount.toString();
			this.dispatchEvent(new Event(MyAutorunTimerEvent.SECOND_TRIGGER));
		}
		
		/**
		 * 是否要倒计时自动取消		
		 * @param $times		秒
		 */		
		public function isAutoCencel($times:uint = 20):void
		{
			_delayCount = $times;
			label = _delayCount.toString();
			if(_timer==null){
				_timer = new MyTimer(1000);
				_timer.addEventListener(MyTimer.TIMER, onTimer);
			}
			
			_timer.start();
		}
		/**
		 * 停止 自动取消的计时
		 */		
		public function autoCencelStop():void{
			if(_timer!=null){
				_timer.stop();
			}
		}
		
		/**
		 * 开始 自动取消的计时
		 */	
		public function autoCencelStart():void{
			if(_timer!=null && _delayCount > 0){
				_timer.start();
			}
		}
		
		/**
		 * 可以在计时前显示的文本
		 */
		public function set label(_str:String):void{
			label_txt.text = _str;
		}
		public function get label():String{
			return label_txt.text;
		}
		
		override public function dispose():void{
			if(_timer != null){
				_timer.removeEventListener(MyTimer.TIMER, onTimer);
				_timer.stop();
				_timer = null;
			}
			
			label_txt.dispose();
			this.removeChild(label_txt);
			label_txt = null;
			
			super.dispose();
		}
		
		/**设置大小*/
		public function setSize(_width:Number, _height:Number):void{
			width = _width;
			height= _height;
		}
		
		/**设置位置*/
		public function move(_x:Number, _y:Number):void{
			this.x = _x;
			this.y = _y;
		}
	}
}