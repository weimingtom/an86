package Events
{
	import flash.events.Event;

	public class GlobalEvent extends Event
	{
		//传入自定义对象
		public var OBJECT:*;
		//传入自定义类型
		public var CUSTOM_TYPE:*;
		
		public function GlobalEvent(type:String, _object:* = null, _customType:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			OBJECT = _object;
			CUSTOM_TYPE = _customType;
			super(type, bubbles, cancelable);
		}
		
	}
}