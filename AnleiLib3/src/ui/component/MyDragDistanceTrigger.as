package ui.component
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	/**
	 * 鼠标拖动到一定的范围外触发事件，范围内也会触发
	 * 如：iPhone触摸效果
	 * @author Anlei
	 */
	public class MyDragDistanceTrigger
	{
		public const CURR_MOUSE_STATE_CLICK:String = 'curr_mouse_state_click';
		public const CURR_MOUSE_STATE_SELECT:String = 'curr_mouse_state_select';
		public var CURR_MOUSE_STATE:String = '';
		
		private var draw_sp:Sprite;
		
		public var isDown:Boolean = false;
		public var isMove:Boolean = false;
		
		//记录鼠标按钮时的值
		private var oldX:Number = 0;
		private var oldY:Number = 0;
		/**
		 * 拖动到范围
		 */
		public var RANGE:int = 10;
		
		private var containe:Sprite;
		
		private var _onMU:Function;
		private var _onMD:Function;
		private var _onMV:Function;
		
		/**
		 * 鼠标拖动到一定的范围外触发事件，范围内也会触发
		 * @param $containe	所要拖动的容器
		 * @param $onMD		在容器内按下鼠标的事件
		 * @param $onMU		在容器内按上鼠标的事件
		 * @param $onMV		在容器内移动鼠标的事件
		 */
		public function MyDragDistanceTrigger($containe:Sprite, $onMD:Function = null, $onMU:Function = null, $onMV:Function = null){
			containe = $containe;
			draw_sp = new Sprite();
			draw_sp.mouseEnabled = false;
			containe.addChild(draw_sp);
			
			_onMU = $onMU;
			_onMD = $onMD;
			_onMV = $onMV;
		}
		public function dispose():void{
			removeMouseEvent();
			if(containe.contains(draw_sp)) containe.removeChild(draw_sp);
			draw_sp = null;
			containe = null;
			
			_onMU = null;
			_onMD = null;
			_onMV = null;
		}
		public function removeMouseEvent():void{
			containe.removeEventListener(MouseEvent.MOUSE_DOWN, onMD);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMU);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMV);
		}
		
		public function addMouseEvent():void{
			containe.removeEventListener(MouseEvent.MOUSE_DOWN, onMD);
			containe.addEventListener(MouseEvent.MOUSE_DOWN, onMD);
		}
		
		private function onMD(e:MouseEvent):void{
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMU);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMV);
			
			oldX = containe.mouseX;
			oldY = containe.mouseY;
			draw_sp.x = oldX;
			draw_sp.y = oldY;
			isDown = true;
			onMV(null);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMU);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMV);
			
			_onMD(e);
		}
		
		private function get stage():Stage{
			return Entrance.getInstance().Root.stage;
		}
		
		private function onMU(e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMU);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMV);
			
			if(isDown) _onMU(e);
			
			oldX = 0;
			oldY = 0;
			isDown = false;
			isMove = false;
		}
		private function onMV(e:MouseEvent):void{
			if(isDown){
				if(!isMove){
					var dmx:Number = draw_sp.mouseX;
					var dmy:Number = draw_sp.mouseY;
					//计算两点间的距离
					var odx:Number = Math.abs(0 - dmx) * Math.abs(0 - dmx);
					var ody:Number = Math.abs(0 - dmy) * Math.abs(0 - dmy);
					var sqrt:Number = Math.sqrt(odx + ody);
					
					//draw_sp.graphics.clear();
					if (sqrt < RANGE) {
						//鼠标移动像素在RANGE内(单击事件)draw_sp.graphics.lineStyle(1); draw_sp.graphics.moveTo(0, 0); draw_sp.graphics.lineTo(dmx, dmy);
						CURR_MOUSE_STATE = CURR_MOUSE_STATE_CLICK;
					}else {
						//鼠标移动像素超出RANGE(选取事件)draw_sp.graphics.beginFill(0x87AADE, 0.5); draw_sp.graphics.lineStyle(1.2, 0x0435A6, 0.7); draw_sp.graphics.drawRect(0, 0, dmx, dmy); draw_sp.graphics.endFill();
						CURR_MOUSE_STATE = CURR_MOUSE_STATE_SELECT;
						oldX = containe.mouseX;
						oldY = containe.mouseY;
						isMove = true;
					}
				}else{
					//开始拖动
					e&&_onMV(e);
//					trace(containe.mouseX, containe.mouseY);
					e&&e.updateAfterEvent();
				}
				
			}
			
		}
		
	}
}

