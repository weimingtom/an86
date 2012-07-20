package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * 鼠标点击或选取的操作
	 * @author Anlei
	 */
	public class SelectDrawing extends EventDispatcher
	{
		/**
		 * 鼠标点击或选取的操作事件，带tag参数
		 */
		public static const EVENT_SELECT_WALK:String = 'evelt_select_walk';
		/**
		 * 选取事件标识
		 */
		public static const TAG_SELECT:String = 'select_soldier';
		/**
		 * 单击事件标识
		 */
		public static const TAG_WALK:String = 'soldier_walk';
		/**
		 * 当前鼠标操作事件标识
		 */
		private var currenttag:String = '';
		
		private var Root:MovieClip;
		private var draw_sp:Sprite;
		//记录鼠标按钮时的值
		private var oldX:Number = 0;
		private var oldY:Number = 0;
		//鼠标是否在down状态
		private var isDown:Boolean = false;
		//鼠标在down状态下，并且鼠标移动像素在RANGE内属于单击事件，超出则为选取事件
		private const RANGE:int = 15;
		
		private var attackIcon_mc:MovieClip;
		
		private var isAttackIcon:Boolean = false;
		
		public function SelectDrawing($Root:MovieClip) 
		{
			Root = $Root;
			inits();
		}
		
		private function inits():void
		{
			attackIcon_mc = Root.getChildByName("attackIcon_mc") as MovieClip;
			attackIcon_mc.mouseChildren = false;
			attackIcon_mc.mouseEnabled = false;
			draw_sp = new Sprite();
			draw_sp.name = 'ANLEI_draw_sp';
			Root.addChild(draw_sp);
			Root.stage.addEventListener(MouseEvent.MOUSE_UP, onMu);
			Root.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMd);
			Root.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMv);
		}
		
		private function onMu(e:MouseEvent):void {
			//抛出状态
			this.dispatchEvent(new DataEvent(EVENT_SELECT_WALK, false, false, currenttag));
			oldX = 0;
			oldY = 0;
			isDown = false;
			draw_sp.graphics.clear();
		}
		private function onMd(e:MouseEvent):void{
			oldX = Root.stage.mouseX;
			oldY = Root.stage.mouseY;
			draw_sp.x = oldX;
			draw_sp.y = oldY;
			isDown = true;
			onMv(null);
		}
		private function onMv(e:MouseEvent):void {
			if (e != null && e.target != null) {
				var _soldier:AbstractSoldier = e.target as AbstractSoldier;
				if (_soldier != null && !_soldier.IsFriend && _soldier.hitTestPoint(Root.stage.mouseX, Root.stage.mouseY)) {
					attackIconTraceMouse();
				}else {
					Mouse.show();
					if(Root.contains(attackIcon_mc)) Root.removeChild(attackIcon_mc);
				}
			}
			if(isDown){
				var dmx:Number = draw_sp.mouseX;
				var dmy:Number = draw_sp.mouseY;
				//计算两点间的距离
				var odx:Number = Math.abs(0 - dmx) * Math.abs(0 - dmx);
				var ody:Number = Math.abs(0 - dmy) * Math.abs(0 - dmy);
				var sqrt:Number = Math.sqrt(odx + ody);
				
				draw_sp.graphics.clear();
				if (sqrt < RANGE) {
					//鼠标移动像素在RANGE内(单击事件)
					draw_sp.graphics.lineStyle(1);
					draw_sp.graphics.moveTo(0, 0);
					draw_sp.graphics.lineTo(dmx, dmy);
					currenttag = TAG_WALK;
				}else {
					//鼠标移动像素超出RANGE(选取事件)
					draw_sp.graphics.beginFill(0x87AADE, 0.5);
					draw_sp.graphics.lineStyle(1.2, 0x0435A6, 0.7);
					draw_sp.graphics.drawRect(0, 0, dmx, dmy);
					draw_sp.graphics.endFill();
					currenttag = TAG_SELECT;
				}
			}
			if(e!=null) e.updateAfterEvent();
		}
		private function attackIconTraceMouse():void {
			if (isAttackIcon) {
				Mouse.hide();
				Root.addChild(attackIcon_mc);
				attackIcon_mc.x = Root.stage.mouseX;
				attackIcon_mc.y = Root.stage.mouseY;
			}
		}
		/**
		 * 是否显现鼠标为攻击状态
		 * @param	$value	true=攻击状态/false=正常现象
		 */
		public function appearAttackICON($value:Boolean):void {
			isAttackIcon = $value;
		}
	}

}