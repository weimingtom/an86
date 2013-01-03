package net.an86.tile
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import net.an86.tile.configs.ATConfigVO;
	import net.an86.tile.role.ATNpcBasic;
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.utils.KeyCtrl;

	public class ATGame
	{
		
		private static const visx:int = 11;
		private static const visy:int = 11;
		public static const halfvisx:int = int(visx/2);
		public static const halfvisy:int = int(visy/2);
		public static var centerx:int;
		public static var centery:int;
		/////////////////////////////
		public static var root:Sprite;
		public static var gameContainer:Sprite = new Sprite();
		public static var world:ATWorld;
		
		public static var roleList:Vector.<ATRoleBasic> = new Vector.<ATRoleBasic>();
		public static var npcList:Vector.<ATNpcBasic> = new Vector.<ATNpcBasic>();
		
		public static var keyCtrl:KeyCtrl;
		
		public function ATGame(){}
		
		public static function init($root:Sprite):void{
			root = $root;
			centerx = root.stage.stageWidth/2;
			centery = root.stage.stageHeight/2;
			
			keyCtrl = new KeyCtrl(root.stage);
			
			root.addChild(gameContainer);
			world = new ATWorld();
		}
		
		public static function change($config:ATConfigVO):void{
			world.createMap($config.map);
			world.createDoor($config.door);
			world.createNpc($config.npc);
			if(roleList[0]){
				//role.reset();
				addRole(roleList[0]);
			}
			setContainerCoor();
		}
		
		/**
		 * 添加物件，如地砖
		 */
		public static function add($aTile:ATile, $x:int, $y:int):void{
			$aTile.x = $x;
			$aTile.y = $y;
			gameContainer.addChildAt($aTile, 0);
		}
		
		/**移除场景中的某个物件*/
		public static function remove($aTile:ATile):void {
			if(gameContainer.contains($aTile)){
				gameContainer.removeChild($aTile);
			}
		}
		
		/**
		 * 添加角色到场景中
		 * @param $obj	角色类
		 */
		public static function addRole($obj:ATRoleBasic):void{
			if($obj.isCtrl){
				roleList[0] = $obj;
				/*roleList[1] = $obj;
				roleList[2] = $obj;*/
			}
			gameContainer.addChild(roleList[0]);
		}
		
		public static function addNpc($obj:ATNpcBasic, $i:int = -1, $j:int = -1):void{
			return;
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
			if($j != -1) $dod.x = $j*ATile.tileW+$dod.width/2;
			if($i != -1) $dod.y = $i*ATile.tileH+$dod.height/2;
			if(roleList[0] && $dod == roleList[0]) {
				roleList[0].xtile = $j;
				roleList[0].ytile = $i;
				roleList[0].roleData.xstep = roleList[0].x;
				roleList[0].roleData.ystep = roleList[0].y;
			}
			setContainerCoor();
		}
		
		private static function setContainerCoor():void{
			gameContainer.x = centerx-(roleList[0].xtile*ATile.tileW)-ATile.tileW/2;
			gameContainer.y = centery-(roleList[0].ytile*ATile.tileH)-ATile.tileH/2;
		}
	}
}