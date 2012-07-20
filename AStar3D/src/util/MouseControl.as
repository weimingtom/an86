package util 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.core.proto.CameraObject3D;
	import org.papervision3d.objects.DisplayObject3D;
	/**
	 * ...
	 * @author ... Anlei
	 */
	public class MouseControl
	{
		private var xpoint:int = 0;
		private var ypoint:int = 0;
		private var mvONF:Boolean = false;
		
		private var fr:Number = .965;
		private var oldX:Number = .1;
		private var oldY:Number = .1;
		private var ball_vx:Number = 1;
		private var ball_vy:Number = 1;
		
		private var Sp:*;
		private var obj3d:DisplayObject3D;
		
		private var TowEnter:Boolean;

		public function MouseControl(_camera:DisplayObject3D, _root:*, _towEnter:Boolean = false ) 
		{
			obj3d = _camera;
			Sp = _root;
			TowEnter = _towEnter;
			inits();
		}
		
		private function inits(e:Event = null):void
		{
			trace('inits');
			Sp.stage.addEventListener(MouseEvent.MOUSE_DOWN , md);
			Sp.stage.addEventListener(MouseEvent.MOUSE_UP , mu);
			Sp.stage.addEventListener(MouseEvent.MOUSE_MOVE, mv);
		}
		
		private function md(evt:Event):void { 
			mvONF = true;
			oldX = obj3d.x;
			oldY = obj3d.y; 
			Sp.addEventListener(Event.ENTER_FRAME , trackOld);
			if(TowEnter) Sp.removeEventListener(Event.ENTER_FRAME , onEnter);
		}
		private function mu(evt:Event):void {
			mvONF = false;
			Sp.removeEventListener(Event.ENTER_FRAME , trackOld);
			if(TowEnter) Sp.addEventListener(Event.ENTER_FRAME , onEnter);
		}
		
		private function mv(evt:Event):void{
			if(mvONF){
				obj3d.rotationX += computMouseYSpeed(); 
				obj3d.rotationY += computMouseXSpeed(); 
			}else {
				xpoint = Sp.mouseX;
				ypoint = Sp.mouseY; 
			}
		}

		private function onEnter(evt:Event):void {
			ball_vx *= fr;
			ball_vy *= fr;
			obj3d.rotationY += ball_vy;
			obj3d.rotationX += ball_vx;
			//render();
		}
		private function trackOld(evt:Event):void{ 
			xpoint = Sp.mouseX;
   			ypoint = Sp.mouseY; 

			//obj3d.rotationX = who.mouseY / 5;
			//camer.x = 0;//-who.mouseX * 12;
			//
			ball_vy = obj3d.rotationY - oldY;
			oldY = obj3d.rotationY;
			ball_vx = obj3d.rotationX - oldX;
			oldX = obj3d.rotationX;
			//render();
		}
		// 计算鼠标X移动速度.
		private function computMouseXSpeed():Number{
    		var xx:Number, yy:Number, total:Number;
    		xx = ((Sp.mouseX - xpoint) / 0.12) / 50;
    		yy = 0;
    		total = int(Math.sqrt(xx * xx + yy * yy) * 50) / 50;
			if(xpoint > Sp.mouseX){
				total *= -1;
			}
    		xpoint = Sp.mouseX;
			return total;
		}
		
		// 计算鼠标Y移动速度.
		private function computMouseYSpeed():Number{
    		var xx:Number, yy:Number, total:Number;
    		xx = 0;
    		yy = ((Sp.mouseY - ypoint)/0.12)/50;
    		total = int(Math.sqrt(xx*xx+yy*yy)*50)/50;
			if(ypoint > Sp.mouseY){
				total *= -1;
			}
   			ypoint = Sp.mouseY;
			return total;
		}

	}

}