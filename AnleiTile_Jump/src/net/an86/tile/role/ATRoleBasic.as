package net.an86.tile.role
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.ATWorld;
	import net.an86.tile.ATile;
	import net.an86.tile.role.utils.RoleData;
	
	import ui.component.MyCartoonContainer;

	
	public class ATRoleBasic extends Sprite
	{
		public var roleData:RoleData = new RoleData();
		
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
		public var space_key:Boolean = false;
		////////////
		private var downY:int;
		private var upY:int;
		private var leftX:int;
		private var rightX:int;
		////////////
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
				space_key = false;
			}
		}
		
		private function checkIfOnCloud():Boolean {
			var _tiles:Object = ATGame.world.tiles;
			var _tile:ATile = ATile(_tiles[downY + "_" + leftX]);
			if(!_tile) return true;
			var leftcloud:Boolean = _tile.cloud;
			
			_tile = ATile(_tiles[downY + "_" + rightX]);
			if(!_tile) return true;
			var rightcloud:Boolean= _tile.cloud;
			
			if ((leftcloud || rightcloud) && ytile != downY) {
				return true;
			} else {
				return false;
			}
			
			return false;
		}
		
		private function getMyCorners($x:int, $y:int):void {
			downY 	= int(($y+height/2-1)	/ATile.tileH);
			upY 	= int(($y-height/2)		/ATile.tileH);
			leftX 	= int(($x-width/2)		/ATile.tileW);
			rightX 	= int(($x+width/2-1)	/ATile.tileW);
			/*
			if(upY == -1 || downY == -1 || leftX == -1 || rightX == -1
			|| rightX > ATGame.world.currentMapData[0].length-1 || leftX < 0
			|| downY > ATGame.world.currentMapData.length-1 || upY < 0
			) return;///如果超出上左下右的边界时不执行
			*/
			//检测他们是否是障碍物
			var _tiles:Object = ATGame.world.tiles;
			
			var _tile:ATile = _tiles[upY+"_"+leftX];
			if(!_tile) return;
			upleft = _tile.walkable;
			
			_tile = _tiles[downY+"_"+leftX];
			if(!_tile) return;
			downleft = _tile.walkable;
			
			_tile = _tiles[upY+"_"+rightX];
			if(!_tile) return;
			upright = _tile.walkable;
			
			_tile = _tiles[downY+"_"+rightX];
			if(!_tile) return;
			downright = _tile.walkable;
		}
		
		private function skipJumpSpeed():void{
			if(roleData.jumpspeed > Math.abs(roleData.jumpstart)){
				roleData.jumpspeed = 0;//Math.abs(roleData.jumpstart);
			}
		}
		
		private function moveChar(dirx:int, diry:int, jump:int):void {
			var speed:int;
			if (Math.abs(jump) == 1) {
				speed = roleData.jumpspeed*jump;
			} else {
				speed = roleData.speed;
			}
			////////////
			getMyCorners (x, y+speed*diry);
			if (diry == -1) {
				if (upleft && upright) {
					y += speed*diry;
				} else {
					y = ytile*ATile.tileH+height/2;
					roleData.jumpspeed = 0;
				}
			}
			if (diry == 1) {
				//if (downleft && downright) {
				if (downleft && downright && !checkIfOnCloud()) {
					y += speed*diry;
				} else {
					y = (ytile+1)*ATile.tileH-height/2;
					roleData.jump = false;
					//trace("jump stop");
					//ATGame.world.flushMapTiles();
				}
			}
			getMyCorners (x+speed*dirx, y);
			if (dirx == -1) {
				if (downleft && upleft) {
					x += speed*dirx;
					fall();
				} else {
					x = xtile*ATile.tileW+width/2;
				}
			}
			if (dirx == 1) {
				if (upright && downright) {
					x += speed*dirx;
					fall();
				} else {
					x = (xtile+1)*ATile.tileW-width/2;
				}
			}
			updateChar(dirx, diry);
//			xtile = int(x/ATile.tileW);
//			ytile = int(y/ATile.tileH);
			
			scrollScreen();
		}
		
		private function scrollScreen():void{
			ATGame.gameContainer.x = ATGame.centerx-x;
			ATGame.gameContainer.y = ATGame.centery-y;
			/////////////////////////
			var xnew:int;
			var xold:int;
			var ynew:int;
			var yold:int;
			var i:int;
			if (roleData.xstep < x - ATile.tileW) {
				xnew = xtile+ATGame.halfvisx+1;
				xold = xtile-ATGame.halfvisx-1;
				for (i = ytile-ATGame.halfvisy-1; i<=ytile+ATGame.halfvisy+1; ++i) {
					ATGame.world.changeTile(xold, i, xnew, i);
				}
				roleData.xstep = roleData.xstep+ATile.tileW;
			} else if (roleData.xstep>x) {
				xold = xtile+ATGame.halfvisx+1;
				xnew = xtile-ATGame.halfvisx-1;
				for (i = ytile-ATGame.halfvisy-1; i<=ytile+ATGame.halfvisy+1; ++i) {
					ATGame.world.changeTile(xold, i, xnew, i);
				}
				roleData.xstep = roleData.xstep-ATile.tileW;
			}
			if (roleData.ystep<y-ATile.tileH) {
				ynew = ytile+ATGame.halfvisy+1;
				yold = ytile-ATGame.halfvisy-1;
				for (i = xtile-ATGame.halfvisx-1; i<=xtile+ATGame.halfvisx+1; ++i) {
					ATGame.world.changeTile(i, yold, i, ynew);
				}
				roleData.ystep = roleData.ystep+ATile.tileH;
			} else if (roleData.ystep>y) {
				yold = ytile+ATGame.halfvisy+1;
				ynew = ytile-ATGame.halfvisy-1;
				for (i = xtile-ATGame.halfvisx-1; i<=xtile+ATGame.halfvisx+1; ++i) {
					ATGame.world.changeTile(i, yold, i, ynew);
				}
				roleData.ystep = roleData.ystep-ATile.tileH;
			}
		}
		
		private function updateChar (dirx:int, diry:int):void {
			//ob.clip.gotoAndStop(dirx + diry * 2 + 3);
			xtile = Math.floor(x / ATile.tileW);
			ytile = Math.floor(y / ATile.tileH);
			/*if (ATGame.world.tiles[ytile + "_" + xtile].door && ob == _root.char)
			{
				changeMap (ob);
			}*/
		}
		
		private function checkUpLadder():Boolean {
			var _downY:int = Math.floor((y+height/2-1)/ATile.tileH);
			var _upY:int = Math.floor((y-height/2)/ATile.tileH);
			var upLadder:Boolean = ATile(ATGame.world.tiles[_upY+"_"+xtile]).ladder;
			var downLadder:Boolean = ATile(ATGame.world.tiles[_downY+"_"+xtile]).ladder;
			if (upLadder || downLadder) {
				return true;
			} else {
				///fall();
			}
			return false;
		}
		private function checkDownLadder():Boolean {
			var _downY:int = Math.floor((roleData.speed+y+height/2)/ATile.tileH);
			var downLadder:Boolean = ATile(ATGame.world.tiles[_downY+"_"+xtile]).ladder;
			if (downLadder) {
				return true;
			} else {
				///fall();
			}
			return false;
		}
		
		private function checkPole():Boolean {
			var _rightY:int = Math.floor((x+width/2-1)/ATile.tileW);
			var _leftY:int = Math.floor((x-width/2)/ATile.tileW);
			var leftPole:Boolean = ATile(ATGame.world.tiles[ytile+"_"+_leftY]).pole;
			var rightPole:Boolean = ATile(ATGame.world.tiles[ytile+"_"+_rightY]).pole;
			if (rightPole || leftPole) {
				return true;
			} else {
				fall();
			}
			return false;
		}
		
		private function climbPole(dirx:int):Boolean {
			roleData.pole = true;
			roleData.jump = false;
			y = (ytile*ATile.tileH)+ATile.tileH/2;
			x += roleData.speed*dirx;
			scrollScreen();
			updateChar(dirx, 0);
			return true;
		}
		
		private function climbLadder(diry:int):Boolean {
			roleData.climb = true;
			roleData.jump = false;
			y += roleData.speed*diry;
			///x = (xtile*ATile.tileW)+ATile.tileW/2;
			scrollScreen();
			updateChar(0, diry);
			return true;
		}
		private function jump():Boolean {
			roleData.jumpspeed = roleData.jumpspeed + roleData.gravity;
			/*if (roleData.jumpspeed>ATile.tileH) {
				roleData.jumpspeed = ATile.tileH;
			}*/
			skipJumpSpeed();
			
			if (roleData.jumpspeed<0) {
				moveChar(0, -1, -1);
			} else if (roleData.jumpspeed>0) {
				moveChar(0, 1, 1);
			}
			return true;
		}
		
		public function fall():void {
			roleData.climb = false;
			roleData.pole  = false;
			if (!roleData.jump) {
				getMyCorners(x, y+1);
				//if (downleft && downright) {
				var _cioc:Boolean = checkIfOnCloud();
				var _cdl:Boolean = checkDownLadder();
				if (downleft && downright && !_cioc && !_cdl || (_cioc && _cdl)) {
					roleData.jumpspeed = 0;
					roleData.jump = true;
				}
			}
		}
		
		private function onEnter(event:Event):void {
			if(!isCtrl) return;
			if(space_key && !roleData.jump){
				roleData.jump = true;
				roleData.jumpspeed = roleData.jumpstart;
			}else if(right_key){
				var _crp:Boolean = checkPole();
				if(!_crp){
					getMyCorners (x - roleData.speed, y);
					if (!roleData.climb || /*downleft && upleft && */upright && downright) {
						moveChar(1, 0, 0);
					}else{
						roleData.jump = false;
					}
				}else{
					climbPole(1);
				}
				if(!_crp){
					if(cartoon.currPlayRow != 2){
						cartoon.playRow(2);
					}
				}else{
					if(cartoon.currPlayRow != 5){
						cartoon.playRow(5);
					}
				}
				//moveChar(1, 0, 0);
			}else  if(left_key){
				var _cr:Boolean = checkPole();
				if(!_cr){
					getMyCorners (x - roleData.speed, y);
					if (!roleData.climb || downleft && upleft /*&& upright && downright*/) {
						moveChar(-1, 0, 0);
					}
				}else{
					climbPole(-1);
				}
				if(!_cr){
					if(cartoon.currPlayRow != 1){
						cartoon.playRow(1);
					}
				}else{
					if(cartoon.currPlayRow != 4){
						cartoon.playRow(4);
					}
				}
				//moveChar(-1, 0, 0);
			}else if(up_key){
				if(!roleData.pole){
					if (/*!roleData.jump && */checkUpLadder()) {
						climbLadder(-1);
					}
					if(cartoon.currPlayRow != 3){
						cartoon.playRow(3);
					}
				}else{
					roleData.jump = true;
					roleData.pole = false;
				}
				//moveChar(0, -1, 0);
			}else if(down_key){
				if (/*!roleData.jump && */checkDownLadder ()) {
					climbLadder(1);
					if(cartoon.currPlayRow != 3){
						cartoon.playRow(3);
					}
				}else{
					if(cartoon.currPlayRow != 0){
						cartoon.playRow(0);
					}
					if(roleData.pole){
						roleData.jump = true;
						roleData.pole = false;
					}
				}
				//moveChar(0, 1, 0);
			}
			if (roleData.jump && !roleData.pole) {
				jump();
			}
		}
		
	}
}