package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class CurveTest extends Sprite
	{
		var P1:Point;
		var P2:Point;
		var Vx:Number,k:Number;
		var V2:Number;
		var P:Point;
		var t:Number;
		var ball:Sprite,brick:Sprite;
		public function CurveTest()
		{
			ball=new m_arrow();
			this.addChild(ball);
			brick=new Sprite();
			brick.graphics.beginFill(0x00FF00);
			brick.graphics.drawRect(-3,-3,6,6);
			this.addChild(brick);
			P1=new Point(20,300);
			P2=new Point(400,300);
			Vx=5;
			k=0.005;
			V2=1;	
			test();
		}
		private function test(){
			var g:Graphics=this.graphics;
			g.clear();
			g.lineStyle(2,0x00FF00);
			g.moveTo(P1.x,P1.y);
			P=P1.clone();
			t=0;
			this.addEventListener(Event.ENTER_FRAME,onDraw);
		}
		
		private var oldP:Point = new Point();
		
		private function onDraw(e:Event){
			t+=1;
			//V2+=(Math.random()-0.5)*0.1;
			P.x=P1.x+Vx*t+V2*t;
			P.y=P1.y+k*(Vx*t-(P2.x-P1.x)/2)*(Vx*t-(P2.x-P1.x)/2)-0.25*k*(P2.x-P1.x)*(P2.x-P1.x);

			ball.rotation = getRotation(new Point(oldP.x, oldP.y), new Point(P.x, P.y));
			oldP = P.clone();
			ball.x=P.x,ball.y=P.y;
			
			var g:Graphics=this.graphics;
			g.lineTo(P.x,P.y);
			
			brick.y=P2.y;
			brick.x=mouseX;
			
			if(P.y>P1.y) test();
		}
		
		
		
		/**
		 * 返回旋转度
		 */
		public function getRotation(targetPoint:Point, currentPoint:Point):Number {
			return getAngle(targetPoint,currentPoint)*(180/Math.PI)+90;
		}
		/**
		 * 返回两点间的距离
		 */
		public function getAngle(targetPoint:Point, currentPoint:Point):Number {
			var dx:Number=targetPoint.x - currentPoint.x;
			var dy:Number=targetPoint.y - currentPoint.y;
			return Math.atan2(dy,dx);
		}
		
	}
}