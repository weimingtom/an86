package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import anlei.away.Anlei3D;
	import anlei.away.d3d.AbsMesh;
	import anlei.away.d3d.AbsRole;
	import anlei.away.utils.AnimActions;
	import anlei.loading.AnleiLoader;
	import anlei.loading.utils.ALoaderUtil;
	import anlei.util.EnterFrame;
	
	import away3d.animators.data.JointPose;
	import away3d.controllers.HoverController;
	import away3d.extrusions.Elevation;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	
	import multi.MultiDirection;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW")]
	
	public class PcTest3D extends Sprite
	{

		private var _role:AbsRole;
		
		public static const MOVE_SP:Number = 40;
		
		private var map1:AbsMesh;
		
//		private var map:AWPTerrain;
		private var map:Elevation;
		
		private var dun:AbsMesh;

		private var jian:AbsMesh;
		
		public function PcTest3D()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 

			Anlei3D.ins().inits(this, true);
			EnterFrame.enterFrame = update;
			
//			cameraController = new LookAtController(Anlei3D.ins().view3d.camera, _bg);
			
//			map1 = new AbsMD5Mesh("map1", "assets/scene/");
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
				_heightMaterial = new TextureMaterial(_heightBitmap);
				map = new Elevation(_textureMaterial, BitmapTexture(_heightMaterial.texture).bitmapData,3000, 2000, 3000);
				Anlei3D.ins().add(map);
			}, function():void{});
			
			_role = new AbsRole();
			_role.isPlayer = true;
			_role.add("1001", onAmmComp);
			
		}
		
		private function onAmmComp():void {
			dun = new AbsMesh("dun1", "assets/equip/");
			dun.load(_role.mesh, [["dun1.jpg"], [], ["dun1.AWD"]], null);
			
			jian = new AbsMesh("jian1", "assets/equip/");
			jian.load(_role.mesh, [["jian1.jpg"], [], ["jian1.AWD"]], null);
			//////////////////////
			_role.mesh.position = new Vector3D(0, 1500, 0);
		}
		
		private var oldPos:Vector3D = new Vector3D();

		private var _heightMaterial:TextureMaterial;
		
		private function update():void{
			
			if (_role && _role.mesh && map){
				if(map.material){
					var _hei:Number = map.getHeightAt(_role.mesh.x, _role.mesh.z);
					if(_hei != 0){
						_role.mesh.y += 0.2*(_hei + 20 - _role.mesh.y);
						oldPos.x = _role.mesh.x;
						oldPos.y = _role.mesh.y;
						oldPos.z = _role.mesh.z;
					}else{
						_role.mesh.position = oldPos;
						_role.mesh.moveLeft(MOVE_SP);
					}
				}
			}
			
			if(_role && _role.mesh && _role.animator.globalPose.jointPoses.length > 0){
				
				if(dun && dun.mesh){
					var index1:int = _role.skeleton.jointIndexFromName("Bip001 L Hand");
					var b1:JointPose = _role.animator.globalPose.jointPoses[index1];
					var mat1:Matrix3D = b1.toMatrix3D();
					dun.mesh.position = mat1.position;
				}
				
				if(jian && jian.mesh){
					var index2:int = _role.skeleton.jointIndexFromName("Bip001 R Hand");
					var b2:JointPose = _role.animator.globalPose.jointPoses[index2];
					var mat2:Matrix3D = b2.toMatrix3D();
					jian.mesh.position = mat2.position;
				}
				
			}
		}
		
	}
}


