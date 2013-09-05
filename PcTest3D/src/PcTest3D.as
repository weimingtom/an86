package
{
	import com.hurlant.math.bi_internal;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import anlei.away.Anlei3D;
	import anlei.away.d3d.AbsMD5Mesh;
	import anlei.away.utils.AnimActions;
	import anlei.loading.AnleiLoader;
	import anlei.loading.utils.ALoaderUtil;
	
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.extrusions.Elevation;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	
	import multi.MultiDirection;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW")]
	
	public class PcTest3D extends Sprite
	{
		private var cameraController:HoverController;

		private var role:AbsMD5Mesh;
		
		public static const MOVE_SP:Number = 40;

		private var map1:AbsMD5Mesh;

		private var map:Elevation;
		
		public function PcTest3D()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 

			Anlei3D.ins().inits(this, update);
			
//			var cm:ColorMaterial = new ColorMaterial(0xFFFFFF);
//			var _bg:Mesh = new Mesh(new PlaneGeometry(300, 300, 1, 1), cm);
//			_bg.y = 10;
//			Anlei3D.ins().add(_bg);
//			cameraController = new LookAtController(Anlei3D.ins().view3d.camera, _bg);
			
			map1 = new AbsMD5Mesh("map1", "assets/scene/");
//			map1.load(null, [["map1.jpg"],[], ["map1.AWD"]], function(evt:AbsMD5Mesh):void{
//				var _textm:TextureMaterial = TextureMaterial(evt.mesh.subMeshes[0].material);
//				map = new Elevation(_textm, BitmapTexture(_textm.texture).bitmapData);
//				Anlei3D.ins().remove(map1.mesh);
//				map.addChild(map1.mesh);
//			});
			
			AnleiLoader.getInstance().start(ALoaderUtil.c([["assets/scene/map1/heightland.png", "heightland"],["assets/scene/map1/map1.jpg", "map1texture"]]), function():void{
				var _textureBitmap:BitmapTexture = new BitmapTexture(AnleiLoader.getInstance().getBitmap("map1texture").bitmapData);
				var _textureMaterial:TextureMaterial = new TextureMaterial(_textureBitmap);
				var _heightBitmap:BitmapTexture = new BitmapTexture(AnleiLoader.getInstance().getBitmap("heightland").bitmapData);
				var _heightMaterial:TextureMaterial = new TextureMaterial(_heightBitmap);
				map = new Elevation(_textureMaterial, BitmapTexture(_heightMaterial.texture).bitmapData,3000, 1000, 3000);
				Anlei3D.ins().add(map);
			}, function():void{});
			role = new AbsMD5Mesh('1001');
			role.load(null, [
				[ "Warrior_3.jpg", "Warrior_4.jpg", "Warrior_2.jpg", "Warrior_1.jpg","Warrior_5.jpg", "Warrior_6.jpg"],
				["attack1.MD5ANIM", "attack2.MD5ANIM",
				"battleStand.MD5ANIM", "block.MD5ANIM", "die.MD5ANIM",
				"hit.MD5ANIM", "run.MD5ANIM", "stand.MD5ANIM",
				"walk.MD5ANIM"], ["role.MD5MESH"]],
				onAmmComp
			);
			/*
			var dun:AbsMD5Mesh = new AbsMD5Mesh("dun1", "assets/equip/");
			dun.load(amm.mesh, [["dun1.jpg"], [], ["dun1.AWD"]]);
			
			var jian:AbsMD5Mesh = new AbsMD5Mesh("jian1", "assets/equip/");
			jian.load(amm.mesh, [["jian1.jpg"], [], ["jian1.AWD"]]);*/
			
			
		}
		
		private function onClick():void {
			var _rnd:int = Math.random()*100;
			var _action:String = AnimActions.attack1;
			if(_rnd > 50) _action = AnimActions.attack2;
			role.play(_action);
		}
		
		private function onAmmComp(evt:AbsMD5Mesh):void {
			cameraController = new HoverController(Anlei3D.ins().view3d.camera, evt.mesh, 0, 22, 1000);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			new MultiDirection(stage, null, onMultiMove, onMultiEnd, onClick);
		}
		
		private function update():void{
			if(cameraController) cameraController.update();
			if (role && role.mesh && map){
				role.mesh.y += 0.2*(map.getHeightAt(role.mesh.x, role.mesh.z) + 20 - role.mesh.y);
			}
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

	}
}


