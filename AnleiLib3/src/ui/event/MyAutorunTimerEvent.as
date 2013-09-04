package ui.event
{
	import flash.events.Event;
	
	public class MyAutorunTimerEvent extends Event
	{
		/**
		 * 当倒时间结束时发出的事件
		 */		
		public static const AUTO_CENCEL:String = 'auto_cencel';
		
		/**
		 * 每秒会触发一次事件
		 */		
		public static const SECOND_TRIGGER:String = 'second_trigger';
		
		public function MyAutorunTimerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}