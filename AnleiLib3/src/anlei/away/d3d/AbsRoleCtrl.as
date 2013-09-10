package anlei.away.d3d
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	import anlei.away.Anlei3D;
	import anlei.away.utils.AnimActions;
	
	import away3d.controllers.ControllerBase;
	import away3d.controllers.HoverController;
	import away3d.extrusions.Elevation;
	
	import multi.MultiDirection;

	public class AbsRoleCtrl
	{
		public static const HOVER:String = "HoverController";
		public var MOVE_SP:Number = 40;
		private var role:AbsRole;
		public var cameraController:ControllerBase;
		private var type:String;
		private var oldPos:Vector3D = new Vector3D();
		
		public function AbsRoleCtrl($role:AbsRole)
		{
			role = $role;
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			new MultiDirection(stage, null, onMultiMove, onMultiEnd, onClick);
			controller = HOVER;
		}
		
		private function get stage():Stage{
			return Anlei3D.ins().stage;
		}
		
		private function onClick():void {
			var _rnd:int = Math.random()*100;
			var _action:String = AnimActions.attack1;
			if(_rnd > 50) _action = AnimActions.attack2;
			role.play(_action);
		}
		
		private function onMultiMove(rota:Number):void{
			role.mesh.rotationY = rota-90;
			role.mesh.moveLeft(-MOVE_SP);
			role.play(AnimActions.run);
		}
		
		private function onMultiEnd():void{
			role.play(AnimActions.stand);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode) {
				case Keyboard.UP:
				case Keyboard.W:
					role.mesh.moveLeft(-MOVE_SP);
					//					role.mesh.x += MOVE_SP;
					//					TweenLite.to(role.mesh, 0.5, {rotationY: -90});
					role.play(AnimActions.run);
					break;
				case Keyboard.DOWN:
				case Keyboard.S:
					role.mesh.moveLeft(MOVE_SP/2);
					//					role.mesh.x -= MOVE_SP;
					//					TweenLite.to(role.mesh, 0.5, {rotationY: 90});
					role.play(AnimActions.walk);
					break;
				case Keyboard.LEFT:
				case Keyboard.A:
					role.mesh.rotationY -= 3;
					//					role.mesh.x -= MOVE_SP;
					//					TweenLite.to(role.mesh, 0.5, {rotationY: -180});
					//					role.play(AnimActions.run);
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					role.mesh.rotationY += 3;
					//					role.mesh.x += MOVE_SP;
					//					TweenLite.to(role.mesh, 0.5, {rotationY: 0});
					//					role.play(AnimActions.run);
					break;
			}
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			switch (event.keyCode) {
				case Keyboard.UP:
				case Keyboard.W:
				case Keyboard.DOWN:
				case Keyboard.S:
				case Keyboard.LEFT:
				case Keyboard.A:
				case Keyboard.RIGHT:
				case Keyboard.D:
					role.stop();
					break;
			}
		}
		
		public function set controller(value:String):void{
			type = value;
			if(type == HOVER && role.mesh){
				cameraController = new HoverController(Anlei3D.ins().view3d.camera, role.mesh, 0, 15, 1000);
			}
		}
		
		public function update():void{
			if(cameraController) cameraController.update();
			var map:Elevation = Anlei3D.ins().scene.terrain
			if (role.mesh && map){
				if(map.material){
					var _hei:Number = map.getHeightAt(role.mesh.x, role.mesh.z);
					if(_hei != 0){
						role.mesh.y += 0.2*(_hei + 20 - role.mesh.y);
						oldPos.x = role.mesh.x;
						oldPos.y = role.mesh.y;
						oldPos.z = role.mesh.z;
					}else{
						role.mesh.position = oldPos;
						role.mesh.moveLeft(MOVE_SP);
					}
				}
			}
		}
		
	}
}