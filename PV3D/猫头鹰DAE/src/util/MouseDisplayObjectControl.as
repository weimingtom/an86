package util 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.core.proto.CameraObject3D;
	import org.papervision3d.objects.DisplayObject3D;
	/**
	 * ...鼠控3D场景，旋转X和Y轴
	 * @author ... Anlei
	 */
	public class MouseDisplayObjectControl
	{
		private var xpoint:int = 0;
		private var ypoint:int = 0;
		private var mvONF:Boolean = false;
		
		private var fr:Number = .965;
		private var oldX:Number = .1;
		private var oldY:Number = .1;
		private var oldZ:Number = .1;
		private var ball_vx:Number = 1;
		private var ball_vy:Number = 1;
		private var ball_vz:Number = 1;
		
		private var Sp:*;
		private var obj3d:DisplayObject3D;
		private var mask_sp:Sprite;
		
		private var TowEnter:Boolean;
		private var _sety:Boolean = true;
		private var _setx:Boolean = true;
		private var _setz:Boolean = true;
		
		/**Camera*/
		private var camer:CameraObject3D;
		private var previousMouseX:Number;
		private var previousMouseY:Number;
		private var cameraPitch:Number = 90;
		private var cameraYaw:Number = 270;
		private var _setcamera:Boolean = true;
		
		
		/**
		 * @param	_camera		被转动的物件，(DisplayObject3D)
		 * @param	_root		场景，用来侦听事件。
		 * @param	_towEnter	绝定是否要有缓冲动画。
		 */
		public function MouseDisplayObjectControl(_obj3d:DisplayObject3D, _camera:CameraObject3D, _root:*, _towEnter:Boolean = false ) 
		{
			obj3d = _obj3d;
			camer = _camera;
			Sp = _root;
			TowEnter = _towEnter;
			inits();
		}
		
		private function inits(e:Event = null):void
		{
			mask_sp = new Sprite();
			mask_sp.name = 'mask_sp';
			mask_sp.graphics.beginFill(0xFF0000);
			mask_sp.graphics.drawRect(0, 0, Stage(Sp.stage).stageWidth, Stage(Sp.stage).stageHeight);
			mask_sp.graphics.endFill();
			mask_sp.alpha = .4;
			Sp.stage.addEventListener(MouseEvent.MOUSE_DOWN , md);
			Sp.stage.addEventListener(MouseEvent.MOUSE_UP , mu);
			Sp.stage.addEventListener(MouseEvent.MOUSE_MOVE, mv);
		}
		
		private function md(evt:MouseEvent):void { 
			mvONF = true;
			oldX = obj3d.x;
			oldY = obj3d.y;
			oldZ = obj3d.z;
			/**Camera*/
			if(SetCamera){
				previousMouseX = evt.stageX;
				previousMouseY = evt.stageY;
			}
			Sp.addEventListener(Event.ENTER_FRAME , trackOld);
			if(TowEnter) Sp.removeEventListener(Event.ENTER_FRAME , onEnter);
		}
		private function mu(evt:MouseEvent):void {
			mvONF = false;
			if(Sp.getChildByName('mask_sp') != null){
				Sp.removeChild(mask_sp);
			}
			Sp.removeEventListener(Event.ENTER_FRAME , trackOld);
			if(TowEnter) Sp.addEventListener(Event.ENTER_FRAME , onEnter);
		}
		
		private function mv(evt:MouseEvent):void{
			if (mvONF) {
				if(Sp.getChildByName('mask_sp') == null){
					Sp.addChild(mask_sp);
				}
				if (SetX) obj3d.rotationX += computMouseYSpeed();
				if (SetY) obj3d.rotationY += computMouseXSpeed(); 
				if (SetZ) obj3d.rotationZ += computMouseXSpeed();
				
				/**Camera*/
				if(SetCamera){
					var differenceX:Number = (evt.stageX - previousMouseX)/3;
					var differenceY:Number = (evt.stageY - previousMouseY)/3;
					cameraPitch -= differenceY;
					cameraYaw -= differenceX;
					
					cameraPitch %= 360;
					cameraYaw %= 360;
					
					cameraPitch = cameraPitch > 90 ? cameraPitch : 89.9999;
					cameraPitch = cameraPitch < 170 ? cameraPitch : 169.9999;
					
					previousMouseX = evt.stageX;
					previousMouseY = evt.stageY;
					
					camer.orbit(cameraPitch, -89.9999);
				}
			}else {
				xpoint = Sp.mouseX;
				ypoint = Sp.mouseY; 
			}
		}

		private function onEnter(evt:Event):void {
			ball_vx *= fr;
			ball_vy *= fr;
			ball_vz *= fr;
			obj3d.rotationY += ball_vy;
			obj3d.rotationX += ball_vx;
			obj3d.rotationZ += ball_vz;
		}
		private function trackOld(evt:Event):void{ 
			xpoint = Sp.mouseX;
   			ypoint = Sp.mouseY; 

			ball_vy = obj3d.rotationY - oldY;
			oldY = obj3d.rotationY;
			ball_vx = obj3d.rotationX - oldX;
			oldX = obj3d.rotationX;
			ball_vz = obj3d.rotationZ - oldZ;
			oldZ = obj3d.rotationZ;
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
		
		
		/***Setter***/
		public function set SetX(_onf:Boolean):void {
			_setx = _onf;
		}
		public function get SetX():Boolean {
			return _setx;
		}
		public function set SetY(_onf:Boolean):void {
			_sety = _onf;
		}
		public function get SetY():Boolean {
			return _sety;
		}
		public function set SetZ(_onf:Boolean):void {
			_setz = _onf;
		}
		public function get SetZ():Boolean {
			return _setz;
		}
		public function set SetCamera(_onf:Boolean):void {
			_setcamera = _onf;
		}
		public function get SetCamera():Boolean {
			return _setcamera;
		}
	}

}