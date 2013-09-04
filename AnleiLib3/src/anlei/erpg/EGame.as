package anlei.erpg
{
	import com.D5Power.utils.CharacterData;
	
	import flash.display.Sprite;
	
	import anlei.erpg.role.ERole;
	import anlei.util.EnterFrame;

	public class EGame
	{
		public static var userdata:CharacterData;
		
//		public static var W:Number = 0;
//		public static var H:Number = 0;
		
		public static var HTTP:String = '';
		public static var camera:ECamera;
		
		public var layer:Sprite;
		public var scene:EScene;
		
		public var isRun:Boolean = true;
		
		protected var mapid:int;
		
		public function EGame($layer:Sprite, $mapid:int = -1)
		{
			layer = $layer;
			mapid = $mapid;
			userdata = new CharacterData();
			if($mapid!=-1) changeMap(mapid);
		}
		
		public function changeMap($mapid:int, $startX:Number = 0, $startY:Number = 0):void{
			mapid = $mapid;
			if(mapid == -1) return;
			var _role:ERole;
			if(scene){
				_role = scene.playRole;
				scene.dispose();
				layer.removeChild(scene);
			}
			
			buildScene();
			
			if(!camera){
				camera = new ECamera();
			}
			camera.game = this;
			if(_role){
				///_role.move($startX, $startY);
				_role.x = $startX;
				_role.y = $startY;
				scene.addPlayer(_role);
			}
		}
		
		/**创建场景中*/
		protected function buildScene():void{
			if(scene) scene.dispose();
			scene = new EScene(mapid);
			layer.addChild(scene);
		}
		
		/**暂停游戏*/
		public function pause():void{
			isRun = false;
			EnterFrame.StopEnterFrame();
			var _len:int = scene.member_arr.length;
			for (var i:int = 0; i < _len; i++) {
				scene.member_arr[i].pause();
			}
			scene.playRole.pause();
			scene.playRole.roleCtrl.unLinstener();
		}
		
		/**恢复游戏*/
		public function reply():void{
			isRun = true;
			EnterFrame.StartEnterFrame();
			var _len:int = scene.member_arr.length;
			for (var i:int = 0; i < _len; i++) {
				scene.member_arr[i].reply();
			}
			scene.playRole.reply();
			scene.playRole.roleCtrl.addListener(scene);
		}
		
		
		public static function get W():Number{
			return EGame.camera.game.scene.W;
		}
		
		public static function get H():Number{
			return EGame.camera.game.scene.H;
		}
	}
}