package net.an86.tile
{
	import anlei.db.AccessDB;
	
	import com.D5Power.utils.CharacterData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import net.an86.tile.configs.ATConfigVO;
	import net.an86.tile.role.ATNpcBasic;
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.utils.ATMissionConfig;
	import net.an86.utils.KeyCtrl;

	public class ATGame
	{
		public static var userdata:CharacterData;
		
		private static const visx:int = 3;
		private static const visy:int = 3;
		public static const halfvisx:int = int(visx/2);
		public static const halfvisy:int = int(visy/2);
		public static var centerx:int;
		public static var centery:int;
		/////////////////////////////
		public static var root:Sprite;
		public static var gameContainer:Sprite = new Sprite();
		public static var world:ATWorld;
		public static var role:ATRoleBasic;
		
		public static var npcList:Vector.<ATNpcBasic> = new Vector.<ATNpcBasic>();
		
		public static var keyCtrl:KeyCtrl;
		
		public function ATGame(){}
		
		public static function init($root:Sprite):void{
			root = $root;
			centerx = root.stage.stageWidth/2;
			centery = root.stage.stageHeight/2;
			
			
			keyCtrl = new KeyCtrl(root.stage);
			
			var _cls:Class = ATMissionConfig.DATA_ZIP;
			AccessDB.getInstance().zip.setBytes(new _cls());
			userdata = new CharacterData();
			root.addChild(gameContainer);
			world = new ATWorld();
		}
		
		public static function change($config:ATConfigVO):void{
			world.createMap($config.map);
			world.createDoor($config.door);
			world.createNpc($config.npc);
			if(role){
				//role.reset();
				addRole(role);
			}
		}
		
		private static function fill($bd:BitmapData, _x:int, _y:int, _w:int = 32, _h:int = 32):void{
			gameContainer.graphics.beginBitmapFill($bd);
			gameContainer.graphics.drawRect(_x, _y, _w, _h);
			gameContainer.graphics.endFill();
		}
		
		/**
		 * 添加物件，如地砖
		 */
		public static function add($bd:BitmapData, $x:int, $y:int):void{
			fill($bd, $x, $y);
		}
		
		/**移除场景中的某个物件*/
		public static function remove($obj:Bitmap):void {
			if(gameContainer.contains($obj)){
				gameContainer.removeChild($obj);
			}
		}
		
		/**
		 * 添加角色到场景中
		 * @param $obj	角色类
		 */
		public static function addRole($obj:ATRoleBasic):void{
			if($obj.isCtrl){
				role = $obj;
			}
			gameContainer.addChild(role);
		}
		
		public static function addNpc($obj:ATNpcBasic, $i:int = -1, $j:int = -1):void{
			gameContainer.addChild($obj);
			$obj.xtile = $j;
			$obj.ytile = $i;
			if($j != -1) $obj.x = $j * ATile.tileW + $obj.width / 2;
			if($i != -1) $obj.y = $i * ATile.tileH + $obj.height/ 2;
			$obj.setTileNoWalke();
			npcList.push($obj);
		}
		
		/**
		 * 设置主角的行列坐标
		 * @param $i	场景格子的第几行
		 * @param $j	场景格子的第几列
		 */
		public static function setPos($dod:DisplayObject, $i:int = -1, $j:int = -1):void {
			if(role && $dod == role) {
				role.xtile = $j;
				role.ytile = $i;
			}
			if($j != -1) $dod.x = $j*ATile.tileW+$dod.width/2;
			if($i != -1) $dod.y = $i*ATile.tileH+$dod.height/2;
			gameContainer.x = ATGame.centerx-(role.xtile*gameContainer.width)-gameContainer.width/2;
			gameContainer.y = ATGame.centery-(role.ytile*gameContainer.height)-gameContainer.height/2;
		}
	}
}