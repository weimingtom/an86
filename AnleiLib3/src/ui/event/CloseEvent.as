package ui.event
{
	import flash.events.Event;
	
	public class CloseEvent extends Event
	{
		public static const CLOSE:String = Event.CLOSE;
		
		public var detail:int;
		
		public function CloseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}