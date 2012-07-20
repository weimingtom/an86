package util 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.core.proto.CameraObject3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.BasicView;
	/**
	 * ...
	 * @author Anlei
	 */
	public class MouseCameraControl
	{
		private var mvONF:Boolean = false;
		
		private var Sp:*;
		private var obj3d:CameraObject3D;
		
		private var previousMouseX:Number;
		private var previousMouseY:Number;
		private var cameraPitch:Number = 90;
		private var cameraYaw:Number = 270;
		
		public function MouseCameraControl(_camera:CameraObject3D, _root:*) 
		{
			obj3d = _camera;
			Sp = _root;
			inits();
		}
		
		private function inits(e:Event = null):void
		{
			Sp.stage.addEventListener(MouseEvent.MOUSE_DOWN , md);
			Sp.stage.addEventListener(MouseEvent.MOUSE_UP , mu);
			Sp.stage.addEventListener(MouseEvent.MOUSE_MOVE, mv);
		}
		
		private function md(evt:MouseEvent):void { 
			mvONF = true;
			previousMouseX = evt.stageX;
			previousMouseY = evt.stageY;
		}
		private function mu(evt:MouseEvent):void {
			mvONF = false;
		}
		
		private function mv(evt:MouseEvent):void{
			if (mvONF) {
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
				
				obj3d.orbit(cameraPitch, -89.9999);
				
			}
		}

	}

}