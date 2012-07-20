package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * 简易的抽象兵种
	 * @author Anlei
	 */
	public class AbstractSoldier extends MovieClip
	{
		private static const SPEED:Number = 10;
		
		private var VISION:Number = 50;//初始视线
		private var RADIUS:Number = 24;//初始大小
		private var isFriend:Boolean;//是否是我方
		
		private var coorX:Number;
		private var coorY:Number;
		
		public var backgroundMC:Sprite;//透明背景，可选中的区域
		private var selectTag:Sprite;//选中呈现的状态
		private var attackRangeMC:Sprite;//攻击范围
		
		public function AbstractSoldier($isFriend:Boolean = true) 
		{
			isFriend = $isFriend;
			inits();
		}
		private function inits():void {
			
			backgroundMC = new Sprite();
			selectTag = new Sprite();
			attackRangeMC = new Sprite();
			
			createBall(backgroundMC, 1, 0, 0, 0, 0, RADIUS);
			changeSelectColor();
			
			addChildAt(backgroundMC, 0);
			addChildAt(attackRangeMC, 0);
			
			this.mouseChildren = false;
		}
		private function changeSelectColor():void {
			if(IsFriend){
				createBall(selectTag, 1, 0xFF9900, 0.5, 0xFF9900, 0.5, RADIUS);
				createBall(attackRangeMC, 0, 0xcccccc, 0.5, 0xcccccc, 0.5, VISION);
			}else {
				createBall(selectTag, 1, 0xFF0000, 0.5, 0xFF0000, 0.5, RADIUS);
				createBall(attackRangeMC, 0, 0xFF0000, 0.5, 0xFF0000, 0.5, VISION);
			}
		}
		
		/**
		 * 绘制一个圆
		 * @param	$source			剪辑
		 * @param	$thick			线条大小
		 * @param	$lineColor		线条色彩
		 * @param	$lineAlpha		线条透明度
		 * @param	$color			填充色
		 * @param	$alpha			埴充透明度
		 * @param	$radius			圆的大小
		 * @return
		 */
		private function createBall($source:Sprite, $thick:Number, $lineColor:uint, $lineAlpha:Number, $color:uint, $alpha:Number, $radius:Number):void {
			var _sp:Sprite = $source;
			_sp.graphics.clear();
			_sp.graphics.lineStyle($thick, $lineColor, $lineAlpha);
			_sp.graphics.beginFill($color, $alpha);
			_sp.graphics.drawCircle(0, 0, $radius);
			_sp.graphics.endFill();
		}
		/**
		 * 设置选中状态的大小
		 * @param	$value
		 */
		public function setRADIUS($value:Number):void {
			RADIUS = $value;
			backgroundMC.scaleX = backgroundMC.scaleY = $value;
			selectTag.scaleX = selectTag.scaleY = $value;
		}
		/**
		 * 攻击范围
		 * @param	$value
		 */
		public function setVISION($value:Number):void {
			VISION = $value;
			attackRangeMC.scaleX = attackRangeMC.scaleY = $value;
		}
		
		/**
		 * 选中或不选中
		 * @param	$value
		 */
		public function select($value:Boolean):void{
			if($value){
				addChildAt(selectTag, 0);
			}else{
				removeChild(selectTag);
			}
		}

		public function walking($x:Number, $y:Number){
			coorX = $x;
			coorY = $y;
			if(!this.hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void{
			//x -= (x - coorX) / 24;
			//y -= (y - coorY) / 24;
			coorX < x ? x -= SPEED : x += SPEED;
			coorY < y ? y -= SPEED : y += SPEED;
			if (getToTargetDistance(new Point(coorX, coorY), new Point(x, y)) <= SPEED) {
				removeEventListener(Event.ENTER_FRAME, onEnter);
			}
		}
		private function getToTargetDistance(_nextPoint:Point, _curr:Point):Number {
			var dx:Number = _nextPoint.x - _curr.x;
			var dy:Number = _nextPoint.y - _curr.y;
			var distance:Number=Math.sqrt(dx * dx + dy * dy);
			return distance;
		}
		public function get IsFriend():Boolean {
			return isFriend;
		}
		public function set IsFriend($value:Boolean):void {
			isFriend = $value;
			changeSelectColor();
		}
	}
}