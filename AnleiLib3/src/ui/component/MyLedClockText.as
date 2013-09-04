package ui.component
{
	import flash.events.Event;

	public class MyLedClockText extends MyTextField
	{
		public var ledClock:MyLedClock;
		private var _desc:String = '';
		
		public function MyLedClockText()
		{
			inits();
		}
		
		private function inits():void
		{
			ledClock = new MyLedClock();
			ledClock.addEventListener(MyLedClock.ADDFRAME, onAddFrame);
			text = '00:00:00';
			
		}
		
		private function onAddFrame(event:Event):void {
			text = _desc + ledClock.currentLed;
		}
		
		public function set desc(value:String):void{
			_desc = value;
		}
		
		override public function dispose():void{
			ledClock.removeEventListener(MyLedClock.ADDFRAME, onAddFrame);
			ledClock.dispose();
			ledClock = null;
			
			super.dispose();
		}
		
		public function setTime(value:uint):void{
			ledClock.setTime(value);
		}
		
		public function get isDay():Boolean{ return ledClock.isDay; }
		public function set isDay(_onf:Boolean):void {
			ledClock.isDay = _onf;
		}
		
		public function get countDown():Boolean{ return ledClock.countDown; }
		public function set countDown(_onf:Boolean):void {
			ledClock.countDown = _onf;
		}
		
	}
}