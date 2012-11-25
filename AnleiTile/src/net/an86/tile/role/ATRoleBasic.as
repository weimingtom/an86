package net.an86.tile.role
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.an86.tile.ATGame;
	import net.an86.utils.ATSceneConfig;
	import net.an86.tile.ATWorld;
	import net.an86.tile.ATile;
	
	import ui.component.MyCartoonContainer;

	
	public class ATRoleBasic extends Sprite
	{
		public var cartoon:MyCartoonContainer;
		
		private var _isCtrl:Boolean = true;
		/**是否是NPC*/
		public var isNpc:Boolean = true;
		
		/**前方可行走的标记*/
		private var upleft:Boolean;
		private var downleft:Boolean;
		private var upright:Boolean;
		private var downright:Boolean;
		
		/**移动方向标记*/
		public var up_key:Boolean=false;
		public var down_key:Boolean=false;
		public var left_key:Boolean=false;
		public var right_key:Boolean = false;
		
		/**移动速度*/
		public var speed:int = 4;
		/**目前在哪个格子X坐标上*/		
		public var xtile:int;
		/**目前在哪个格子Y坐标上*/
		public var ytile:int;
		
		
		public function ATRoleBasic($isCtrl:Boolean = true, _tileWidth:int = 32, _tileHeight:int = 32)
		{
			isCtrl = $isCtrl;
			isNpc = false;
			cartoon = new MyCartoonContainer(_tileWidth, _tileHeight);
			cartoon.setGapTime(160);
			addChild(cartoon);
		}
		
		public function setBitmapData(bd:BitmapData):void{
			cartoon.setBitmapData(bd);
			cartoon.x = -cartoon.width/2;
			cartoon.y = -cartoon.height/2;
		}
		
		/**防止切换地图时顺移到别处*/
		public function reset():void{
			upleft = false;
			downleft = false;
			upright = false;
			downright = false;
		}
		
		private function getMyCorners($x:int, $y:int):void {
			var downY:int 	= int(($y+height/2-1)	/ATile.tileH);
			var upY:int 	= int(($y-height/2)		/ATile.tileH);
			var leftX:int 	= int(($x-width/2)		/ATile.tileW);
			var rightX:int 	= int(($x+width/2-1)	/ATile.tileW);
			/*
			if(upY == -1 || downY == -1 || leftX == -1 || rightX == -1
			|| rightX > ATGame.world.currentMapData[0].length-1 || leftX < 0
			|| downY > ATGame.world.currentMapData.length-1 || upY < 0
			) return;///如果超出上左下右的边界时不执行
			*/
			//检测他们是否是障碍物
			var _tiles:Object = ATGame.world.tiles;
			upleft = ATile(_tiles[upY+"_"+leftX]).walkable;
			downleft = ATile(_tiles[downY+"_"+leftX]).walkable;
			upright = ATile(_tiles[upY+"_"+rightX]).walkable;
			downright = ATile(ATGame.world.tiles[downY+"_"+rightX]).walkable;
		}
		
		private function moveChar(dirx:int, diry:int):void {
			getMyCorners (x, y+speed*diry);
			if (diry == -1) {
				if (upleft && upright) {
					y += speed*diry;
				} else {
					y = ytile*ATile.tileH+height/2;
				}
			}
			if (diry == 1) {
				if (downleft && downright) {
					y += speed*diry;
				} else {
					y = (ytile+1)*ATile.tileH-height/2;
				}
			}
			getMyCorners (x+speed*dirx, y);
			if (dirx == -1) {
				if (downleft && upleft) {
					x += speed*dirx;
				} else {
					x = xtile*ATile.tileW+width/2;
				}
			}
			if (dirx == 1) {
				if (upright && downright) {
					x += speed*dirx;
				} else {
					x = (xtile+1)*ATile.tileW-width/2;
				}
			}
			xtile = int(x/ATile.tileW);
			ytile = int(y/ATile.tileH);
			
			var _cmarr:Array = ATGame.world.currentMapData;
			if(_cmarr[0].length > xtile && _cmarr.length > ytile){
				var _id:String = _cmarr[ytile][xtile];
				var _arr:Array = ATWorld.splitJump(xtile, ytile);
				if(_arr){
					_id = _arr[0];
					var _i:int = _arr[1];
					var _j:int = _arr[2];
					if(ATGame.role != null){
						xtile = _j;
						ytile = _i;
						ATGame.setPos(this, _i, _j);
					}
					ATGame.change(ATSceneConfig.getConfig(int(_id)));
				}
			}
			
			ATGame.gameContainer.x = ATGame.centerx-x;
			ATGame.gameContainer.y = ATGame.centery-y;
			
		}
		
		private function onEnter(event:Event):void {
			if(!isCtrl) return;
			if(right_key){
				moveChar(1, 0);
				if(cartoon.currPlayRow != 2){
					cartoon.playRow(2);
				}
			}else 
			if(left_key){
				moveChar(-1, 0);
				if(cartoon.currPlayRow != 1){
					cartoon.playRow(1);
				}
			}else 
			if(up_key){
				moveChar(0, -1);
				if(cartoon.currPlayRow != 3){
					cartoon.playRow(3);
				}
			}else 
			if(down_key){
				moveChar(0, 1);
				if(cartoon.currPlayRow != 0){
					cartoon.playRow(0);
				}
			}
			
		}
		
		/**是否被玩家控制*/
		public function get isCtrl():Boolean { return _isCtrl; }
		public function set isCtrl(value:Boolean):void {
			_isCtrl = value;
			if(isCtrl){
				if(!this.hasEventListener(Event.ENTER_FRAME)){
					this.addEventListener(Event.ENTER_FRAME, onEnter);
				}
			}else{
				up_key = false;
				down_key = false;
				left_key = false;
				right_key = false;
			}
		}

	}
}