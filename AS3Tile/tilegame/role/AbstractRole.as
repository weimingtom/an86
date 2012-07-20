package tilegame.role
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import tilegame.TileWorld;
	/**
	 * ...
	 * @author Anlei
	 */
	public class AbstractRole extends Sprite 
	{
		private const speedInit:Number = 4;
		//移动速度
		public var speed:Number = speedInit;
		
		//碰撞用的剪辑
		public var bot:Sprite;
		
		//初始位置（地图二维数组的下标）
		public var xtile:int;
		public var ytile:int;
		
        private var up:Boolean=false;
        private var down:Boolean=false;
        private var left:Boolean=false;
        private var right:Boolean = false;
		
		private var downY:int;
		private var upY:int;
		private var leftX:int;
		private var rightX:int;
		
		private var upleft:Boolean;
		private var downleft:Boolean;
		private var upright:Boolean;
		private var downright:Boolean;
		//是否可跳越
		private var _isJump:Boolean = false;
		//是否可以卷屏（横）
		private var _isHScrolling:Boolean = false;
		//是否可以卷屏（纵）
		private var _isVScrolling:Boolean = false;

		//跳跃的初始速度，
		private var jumpstart:Number = -18;
		//跳跃的速度，
		private var jumpspeed:Number = 0;
		//重力值
		private var gravity:Number = 2;
		//属性用来表示英雄是不是在跳跃过程中
		private var jumping:Boolean = false;
		
		public function AbstractRole() 
		{
			bot = new char_mc();
			addChild(bot);
			this.mouseChildren = false;
		}
		/**
		 * 是否卷屏
		 * @param	$onf
		 */
		public function setIsHScrolling($onf:Boolean):void {
			_isHScrolling = $onf;
		}
		public function setIsVScrolling($onf:Boolean):void {
			_isVScrolling = $onf;
		}
		/**
		 * 是否可跳越
		 * @param	$onf
		 */
		public function setIsJump($onf:Boolean):void {
			_isJump = $onf;
		}
		public function getIsJump():Boolean { return _isJump; }
		/**
		 * 是否可以移动
		 * @param	$onf
		 */
		public function setIsMove($onf:Boolean):void {
			if($onf){
				EnterFrame.enterFrame = onEnter;
			}else {
				EnterFrame.removeEnterFrame = onEnter;
			}
		}
		/**
		 * 是否可用键盘控制
		 * @param	$onf
		 */
		public function setKeyCtrl($onf:Boolean):void {
			setIsMove($onf);
			if($onf){
				stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeydown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyup);
			}else {
				if(stage.hasEventListener(KeyboardEvent.KEY_DOWN))
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
				
				if(stage.hasEventListener(KeyboardEvent.KEY_UP))
					stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyup);
			}
		}
		
		private function onKeydown(event:KeyboardEvent):void 
		{
			var keyPressed:Boolean = false;
			switch (event.keyCode) {
                case Keyboard.LEFT :
                    left = true;
					//moveChar(-1, 0);
                    break;
                case Keyboard.RIGHT :
                    right=true;
					//moveChar(1, 0);
                    break;
                case Keyboard.UP :
                    up=true;
					//moveChar(0, -1);
                    break;
                case Keyboard.DOWN :
                    down=true;
					//moveChar(0, 1);
                    break;
				case Keyboard.SPACE:
					if(!jumping && _isJump){
						jumping = true;
						jumpspeed = jumpstart;
					}
					break;
                default :
                    break;
            }
		}
		
		private function onKeyup(event:KeyboardEvent):void 
		{
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
				case Keyboard.SPACE:
					
                    break;
                default :
                    break;
            }
		}
		
		private function onEnter():void 
		{
			if (left && !right) {
                //x-=speed;
				moveChar(-1, 0, 0);
            }
            if (right && !left) {
                //x+=speed;
				moveChar(1, 0, 0);
            }
            if (up && !down && !_isJump) {
                //y-=speed;
				moveChar(0, -1, 0);
            }
            if (down && !up && !_isJump) {
                //y+=speed;
				moveChar(0, 1, 0);
            }
			if (jumping) {
				execjump();
			}
		}
		private function moveChar(dirx:int, diry:int, jumpvalue:int):Boolean {
			
			if (Math.abs(jumpvalue) == 1)
			{
				speed = jumpspeed * jumpvalue;
			}
			else
			{
				//TileWorld.getInstance().mapLayer.y -= (speed * diry);
				speed = speedInit;
			}
			
			getMyCorners (x, y+speed*diry);
			if (diry == -1) {
				if (upleft && upright) {
					//角色行走
					y += speed * diry;
					//当可滚动地图时，地图反向移动
					if(_isVScrolling) TileWorld.getInstance().mapLayer.y -= (speed * diry);
				} else {
					//当撞到障碍物时
					if (!_isJump) y = ytile * TileWorld.tileH + bot.height / 2;
					else {
						y = ytile * TileWorld.tileH + bot.height/2;
						jumpspeed = 0;
					}
				}
			}
			if (diry == 1) {
				if (downleft && downright) {
					y += speed*diry;
					if(_isVScrolling) TileWorld.getInstance().mapLayer.y -= (speed * diry);
				} else {
					if (!_isJump) y = (ytile + 1) * TileWorld.tileH - bot.height / 2;
					else {
						y = (ytile+1)*TileWorld.tileH-bot.height/2;
						jumping = false;
					}
				}
			}
			getMyCorners (x+speed*dirx, y);
			if (dirx == -1) {
				if (downleft && upleft) {
					x += speed * dirx;
					if (_isJump) fall();
					if(_isHScrolling) TileWorld.getInstance().mapLayer.x -= (speed * dirx);
				} else {
					x = xtile * TileWorld.tileW + bot.width / 2;
				}
			}
			if (dirx == 1) {
				if (upright && downright) {
					x += speed * dirx;
					if(_isJump)	fall();
					if(_isHScrolling) TileWorld.getInstance().mapLayer.x -= (speed*dirx);
				} else {
					x = (xtile+1)*TileWorld.tileW-bot.width/2;
				}
			}
			
			xtile = int(x / TileWorld.tileW);
			ytile = int(y / TileWorld.tileH);
			
			//卷屏到边界时，则不卷屏了
			if (xtile < 3 || xtile > TileWorld.mapW - 3) _isHScrolling = false;
			else
				if (!_isHScrolling)
				{
					_isHScrolling = true;
					//到边界时，减去多移动的偏移量
					TileWorld.getInstance().mapLayer.x -= (speed * dirx);
				}
			
			if (ytile < 3 || ytile > TileWorld.mapH - 3) _isVScrolling = false;
			else
				if (!_isVScrolling)
				{
					_isVScrolling = true;
					TileWorld.getInstance().mapLayer.y -= (speed * diry);
				}
			
			if (TileWorld.getInstance().mapData[ytile][xtile].door) {
				toedDoor();
			}
			return true;
		}
		private function toedDoor():void {
			trace("到门口了");
		}
		private function getMyCorners($x:Number, $y:Number):void {
			downY = int(($y+bot.height/2 -1)/TileWorld.tileH);
			upY = int(($y-bot.height/2)/TileWorld.tileH);
			leftX = int(($x-bot.width/2)/TileWorld.tileW);
			rightX = int(($x+bot.width/2-1)/TileWorld.tileW);
			//检测他们是否是障碍物
			upleft = getWalkable(upY, leftX);
			downleft = getWalkable(downY, leftX);
			upright = getWalkable(upY, rightX);
			downright = getWalkable(downY, rightX);
		}
		private function getWalkable($c:int, $d:int):Boolean {
			if ($c < 0 || $d < 0) return false;
			if ($c >= TileWorld.getInstance().mapData.length) return false;
			else if ($d >= TileWorld.getInstance().mapData[$c].length) return false;
			return TileWorld.getInstance().mapData[$c][$d].walkable;
		}
		//执行跳越过程的方法
		private function execjump():void
		{
			jumpspeed = jumpspeed + gravity;
			if (jumpspeed > TileWorld.tileH)
			{
				jumpspeed = TileWorld.tileH;
			}
			if (jumpspeed < 0)
			{
				moveChar(0, -1, -1);
			}
			else if (jumpspeed > 0)
			{
				moveChar(0, 1, 1);
			}
		}
		/**
		 * 重力下降
		 */
		public function fall():void {
			if (!jumping) {
				getMyCorners(x, y + 1);
				if (downleft && downright) {
					jumpspeed = 0;
					jumping = true;
				}
			}
		}
		protected function localtion():void {
			
		}
	}

}