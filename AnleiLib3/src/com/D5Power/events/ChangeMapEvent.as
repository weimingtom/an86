package com.D5Power.events
{
	import flash.events.Event;
	
	/**
	 * 更换地图事件
	 */ 
	public class ChangeMapEvent extends Event
	{
		private var _toMap:uint;
		private var _toX:uint;
		private var _toY:uint;
		public static const CHANGE:String = 'changeMap';
		
		public function ChangeMapEvent(mapid:uint,x:uint,y:uint)
		{
			_toMap = mapid;
			_toX = x;
			_toY = y;
			super(CHANGE, bubbles, cancelable);
		}
		
		public function get toMap():uint
		{
			return _toMap;
		}
		
		public function get toX():uint
		{
			return _toX;
		}
		
		public function get toY():uint
		{
			return _toY;
		}
	}
}