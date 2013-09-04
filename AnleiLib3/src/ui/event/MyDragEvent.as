package ui.event
{
	import flash.events.Event;
	
	public class MyDragEvent extends Event
	{
		/** 当成功的拖动到别的物件上时的事件名 */
		public static const DRAG_COMPLETE:String = 'drag_complete';
		/** 当鼠标按下时 */
		public static const DRAG_START:String = 'drag_start';
		/** 当鼠标按上时 */
		public static const DRAG_END:String = 'drag_end';
		
//		public var accept:Object;
//		public var sender:Object;
		
		public var sender:Object;
		
		public function MyDragEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}