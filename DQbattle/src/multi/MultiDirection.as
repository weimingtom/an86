package multi
{
	import flash.display.Stage;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import anlei.util.CoorAway;
	import flash.events.Event;

	public class MultiDirection
	{
		private var isTouch:Boolean = false;
		private var touchMap:Dictionary = new Dictionary();
		private var _startPoint:Point;
		private var _endPoint:Point;
		private var stage:Stage;
		
		private var onStart:Function;
		private var onMove:Function;
		private var onEnd:Function;
		private var onClicker:Function;
		
		
		public function MultiDirection($stage:Stage, $onStart:Function, $onMove:Function, $onEnd:Function, $onClick:Function){
			onStart = $onStart;
			onMove = $onMove;
			onEnd = $onEnd;
			onClicker = $onClick;
			
			stage = $stage;
			_startPoint = new Point();
			_endPoint = new Point();
			addEvent();
		}
		
		public function addEvent():void{
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
		}
		
		public function removeEvent():void{
			//stage.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			stage.removeEventListener(Event.ENTER_FRAME, onEnter);
			stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		
		private function onTouchBegin(event:TouchEvent):void {
			if(isTouch){
				//on click;
//				if(onClicker) onClicker();
				return;
			}
			isTouch = true;
			touchMap[event.touchPointID] = true;
			for(var _item:Object in touchMap){
				trace(_item, touchMap[_item]);
			}
			_startPoint.x = event.localX;
			_startPoint.y = event.localY;
			if(onStart) onStart();
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		
		private function onEnter(e:Event):void{
			var _rotation:Number = CoorAway.getRotation(_startPoint, _endPoint);
			if(onMove) onMove(_rotation);
		}
		
		private function onTouchMove(event:TouchEvent):void {
			if(isTouch && touchMap.hasOwnProperty(event.touchPointID)){
				_endPoint.x = event.localX;
				_endPoint.y = event.localY;
				if(CoorAway.getToTargetDistance(_startPoint, _endPoint) > 10){
					stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
					stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove2);
					stage.addEventListener(Event.ENTER_FRAME, onEnter);
				}
			}
		}
		private function onTouchMove2(event:TouchEvent):void {
			_endPoint.x = event.localX;
			_endPoint.y = event.localY;
		}
		
		private function onTouchEnd(event:TouchEvent):void {
			if(isTouch && touchMap.hasOwnProperty(event.touchPointID)){
				removeEvent();
				if(onEnd) onEnd();
				isTouch = false;
				delete touchMap[event.touchPointID];
				return;
			}
		}
		/*
		public static function getRotation(targetPoint:Point, currentPoint:Point):Number {
			return getAngle(targetPoint,currentPoint)*(180/Math.PI)+90;
		}
		
		public static function getAngle(targetPoint:Point, currentPoint:Point):Number {
			var dx:Number=targetPoint.x - currentPoint.x;
			var dy:Number=targetPoint.y - currentPoint.y;
			return Math.atan2(dy,dx);
		}
		*/
	}
}