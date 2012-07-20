package {
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	

 
	[SWF(height=600,width=800)]
	public class PaoWuXian extends Sprite {

		public var speed:Number=0.00095;
		public var dx:Number=0.2;
		public var dy:Number=-0.8;
		public var lastTime:int=getTimer();
		public var ball1:Sprite;
		public var ball:Sprite;

		public function PaoWuXian() {
			stage?init():addEventListener(Event.ADDED_TO_STAGE,init);
		}

		public function init(e:Event=null):void {
			ball=new Sprite  ;
			ball1=new Sprite  ;
			ball1.graphics.beginFill(0x0000ff);
			ball1.graphics.drawCircle(0,0,30);
			ball1.graphics.endFill();
			ball1.x=350;
			ball1.y=300;
			addChild(ball1);
			ball.graphics.beginFill(0xff0000);
			ball.graphics.drawCircle(0,0,30);
			ball.graphics.endFill();
			ball.x=30;
			ball.y=300;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME,enters);
			removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.addEventListener(MouseEvent.CLICK, onClickStage);
		}
		
		private function onClickStage(e:*):void{
			ball.x=30;
			ball.y=200;
			dx=0.2;
			dy=-0.8;
		}

		public function enters(event:Event):void {
			var times:int=getTimer() - lastTime;
			lastTime+= times;
			dy+= speed * times;
			ball.x+= times * dx;
			ball.y+= times * dy;
			ball1.x += 2;
			if (ball && ball.hitTestObject(ball1)) {
				//楼主的代码出在这里，改成如下：
				
			//ball.x=30;
			//ball.y=300;
				//removeChild(ball);
				//ball=null;
				//removeEventListener(Event.ENTER_FRAME,enters);
			}
		}

	}
}