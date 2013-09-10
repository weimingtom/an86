package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import anlei.away.Anlei3D;
	import anlei.away.d3d.AbsMesh;
	import anlei.away.d3d.AbsRole;
	import anlei.util.EnterFrame;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW")]
	
	public class PcTest3D extends Sprite
	{

		private var _role:AbsRole;
		
		public static const MOVE_SP:Number = 40;
		
		private var map1:AbsMesh;
		
//		private var map:AWPTerrain;
//		private var map:Elevation;
		
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
			
			Anlei3D.ins().changeMap(1, onCom);
			function onCom():void{
				_role = new AbsRole();
				_role.move(0, 1500, 0);
				_role.isPlayer = true;
				Anlei3D.ins().player = _role;
				_role.add("1001", onAmmComp);
			};
		}
		
		private function onAmmComp():void {
			_role.equips.addLHandItem("dun1");
			_role.equips.addRHandItem("jian1");
		}
		
		private function update():void{
			/*
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
			*/
			/*if(_role && _role.mesh && _role.animator.globalPose.jointPoses.length > 0){
				
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
				
			}*/
		}
		
	}
}


