package net.an86.tile
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import net.an86.tile.role.ATRoleBasic;

	public class ATGame
	{
		private static const visx:int = 3;
		private static const visy:int = 3;
		public static const halfvisx:int = int(visx/2);
		public static const halfvisy:int = int(visy/2);
		public static var centerx:int;
		public static var centery:int;
		/////////////////////////////
		//private static var bgBitmap:Bitmap = new Bitmap(new BitmapData();
		public static var gameContainer:Sprite = new Sprite();
		public static var world:ATWorld;
		public static var role:ATRoleBasic;
		
		public function ATGame(){}
		
		public static function init(root:Sprite):void{
			centerx = root.stage.width/2;
			centery = root.stage.height/2;
			
			root.addChild(gameContainer);
			//gameContainer.addChild(bgBitmap);
			world = new ATWorld();
		}
		
		public static function change($map:Array):void{
			world.create($map);
			if(role){
				role.reset();
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