package net.an86.tile.role
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.ATMapConfig;
	import net.an86.tile.ATWorld;
	import net.an86.tile.ATile;
	import net.an86.utils.MyCartoonContainer;

	
	public class ATRoleBasic extends Sprite
	{
		public static var WH:Number = 32;
		
		public var cartoon:MyCartoonContainer;
		
		private var _isCtrl:Boolean = true;
		
		private var upleft:Boolean;
		private var downleft:Boolean;
		private var upright:Boolean;
		private var downright:Boolean;
		
		private var up:Boolean=false;
		private var down:Boolean=false;
		private var left:Boolean=false;
		private var right:Boolean = false;
		
		public var speed:int = 4;
		public var xtile:int;
		public var ytile:int;
		
		
		public function ATRoleBasic($isCtrl:Boolean = true, _tileWidth:int = 32, _tileHeight:int = 32)
		{
			isCtrl = $isCtrl;
			cartoon = new MyCartoonContainer(_tileWidth, _tileHeight);
			addChild(cartoon);
		}
		
		public function setBitmapData(bd:BitmapData):void{
			cartoon.setBitmapData(bd);
			cartoon.x = -cartoon.width/2;
			cartoon.y = -cartoon.height/2;
		}
		
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
			
			var _id:String = ATGame.world.currentMapData[ytile][xtile];
			if(_id && _id.indexOf('=') != -1){
				var _arr:Array = ATWorld.splitJump(_id);
				_id = _arr[0];
				
				var _i:int = _arr[1];
				var _j:int = _arr[2];
				if(ATGame.role != null){
					xtile = _j;
					ytile = _i;
					ATGame.setPos(this, _i, _j);
				}
			}
			//_id大于1000说明是门ID，则跳转地图
			if(int(_id) > ATile.MAP_SP){
				ATGame.change(ATMapConfig.getMap(int(_id)));
				
			}
			
			ATGame.gameContainer.x = ATGame.centerx-x;
			ATGame.gameContainer.y = ATGame.centery-y;
			
		}
		
		private function onEnter(event:Event):void {
			if(right){
				moveChar(1, 0);
				if(cartoon.currPlayRow != 2){
					cartoon.playRow(2);
				}
			}else 
			if(left){
				moveChar(-1, 0);
				if(cartoon.currPlayRow != 1){
					cartoon.playRow(1);
				}
			}else 
			if(up){
				moveChar(0, -1);
				if(cartoon.currPlayRow != 3){
					cartoon.playRow(3);
				}
			}else 
			if(down){
				moveChar(0, 1);
				if(cartoon.currPlayRow != 0){
					cartoon.playRow(0);
				}
			}
			
			/*
			
			var moveOb:Object = new Object();
					if (getMyCorners(x + keyOb.dirx * speed, y + keyOb.diry * speed) == true) {
						moveOb = keyOb;
					}else{
						//we have hit the wall, place near it
						if(keyOb.dirx < 0){
							x = xtile * ATile.WH;
						}else if(keyOb.dirx > 0){
							xtile = Math.floor((x + speed) / ATile.WH);
							x = (xtile + 1) * ATile.WH - WH;
						}else if(keyOb.diry < 0){
							y = ytile * ATile.WH;
						}else if(keyOb.diry > 0){
							ytile = Math.floor((y + speed) / ATile.WH);
							y = (ytile + 1) * ATile.WH - WH;
						}
						moveOb.dirx = 0;
						moveOb.diry = 0;
						moveOb.sprNum = keyOb.sprNum;
						//try to move hero around the wall tiles
						if(keyOb.dirx != 0){
							var ytc:int = Math.floor((y + WH/2) / ATile.WH);
							if(ATile.getWalk(ATGame.world.currentMapData[xtile + keyOb.dirx][ytc])){
								//align vertically
								var centerY:int = ytc * ATile.WH + (ATile.WH - WH) / 2;
								if(y > centerY){
									//move up
									y--;
								}else if(y < centerY){
									//move down
									y++;
								}
							}
						}else{
							var xtc:int = Math.floor((x + WH/2) / ATile.WH);
							if(ATile.getWalk(ATGame.world.currentMapData[xtc, ytile + keyOb.diry])){
								//align horisontal
								var centerX:int = xtc * ATile.WH + (ATile.WH - WH) / 2;
								if(x > centerX){
									//move left
									x--;
								}else if(x < centerX){
									x++;
								}
							}
						}
					}
			
			*/
					
					
		}
		
		private function addKeydown():void{
			this.addEventListener(Event.ENTER_FRAME, onEnter);
			ATGame.gameContainer.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			ATGame.gameContainer.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyup);
		}
		
		private function removeKeydown():void{
			this.removeEventListener(Event.ENTER_FRAME, onEnter);
			ATGame.gameContainer.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			ATGame.gameContainer.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyup);
		}
		
		private function onKeyup(event:KeyboardEvent):void {
			//cartoon.stopRow(cartoon.currPlayRow, 1);
			switch (event.keyCode) {
				case Keyboard.LEFT :
					left=false;
					break;
				case Keyboard.RIGHT :
					right=false;
					break;
				case Keyboard.UP :
					up=false;
					break;
				case Keyboard.DOWN :
					down=false;
					break;
			}
		}
		private function onKeydown(event:KeyboardEvent):void {
			var keyPressed:Boolean = false;
			switch (event.keyCode) {
				case Keyboard.LEFT :
					left = true;
					break;
				case Keyboard.RIGHT :
					right=true;
					break;
				case Keyboard.UP :
					up=true;
					break;
				case Keyboard.DOWN :
					down=true;
					break;
				default :
					break;
			}
		}
		
		public function get isCtrl():Boolean { return _isCtrl; }
		public function set isCtrl(value:Boolean):void {
			_isCtrl = value;
			if(isCtrl) addKeydown();
			else removeKeydown();
		}

	}
}