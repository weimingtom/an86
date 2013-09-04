package ui.abs
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Events.GlobalEvent;
	
	import anlei.util.AnleiFilter;
	
	import ui.component.MyButton;

	public class AbsButton
	{
		public var onOver_hanlder:Function;
		public var onOut_hanlder:Function;
		
		private var parent:MyButton;
		private var btn:MovieClip;
		
		private var click_fn:Function;
		private var _isPopUp:Boolean;
		private var _isDown:Boolean;
		
		/**是否按下状态*/
		private var isSelected:Boolean = false;
		private var _enabled:Boolean = true;
		
		public var isEnabledChange:Boolean = true;
		
		/**是否为TabBar中的Button
		public var isTabInter:Boolean = false;*/
		
		public function AbsButton($btn:MovieClip, $struct:MyButton)
		{
			btn = $btn;
			parent = $struct;
			
			setOut(null);
			parent.addEventListener(MouseEvent.MOUSE_DOWN, setDown);
			parent.addEventListener(MouseEvent.MOUSE_OVER, setOver);
			parent.addEventListener(MouseEvent.MOUSE_OUT, setOut);
			
			parent.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(event:Event):void {
			parent.removeEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function clickHandler():void {
			if(enabled){
				if(click_fn != null){
					click_fn(parent);
				}
				selected = !selected;
			}
		}
		
		private function btnGotoStopTwo():void{
			gotof(2);
		}
		
		public function get selected():Boolean{ return isSelected; }
		public function set selected(value:Boolean):void{
			setSel(value);
			if(!value){
				gotof(1);
			}
		}
		
		private function setSel(value:Boolean):void{
			if(isPopUp){
				isSelected = value;
				if(isSelected){
					gotof(5);
				}else{
					gotof(1);
				}
				
				parent.dispatchEvent(new GlobalEvent(MyButton.SELECTED, isSelected));
				
			}else{
				btnGotoStopTwo();
			}
		}
		
		//////////////////////////////////////////////////
		
		private function setDown(event:MouseEvent):void {
			if(!enabled) return;
			if(isPopUp && isSelected){
				gotof(7);
			}else{
				gotof(3);
			}
			_isDown = true;
			parent.addEventListener(MouseEvent.MOUSE_UP, setUp);
		}
		
		private function setOver(e:MouseEvent):void{
			if(!enabled) return;
			if(_isDown){
				if(isPopUp && isSelected){
					gotof(7);
				}else{
					gotof(3);
				}
			}else{
				if(isPopUp && isSelected){
					gotof(6);
				}else{
					btnGotoStopTwo();
				}
			}
			if(onOver_hanlder) onOver_hanlder();
		}
		
		private function setOut(e:MouseEvent):void{
			if(!enabled) return;
			if(isPopUp){
				if(isSelected){
					gotof(5);
				}else{
					gotof(1);
				}
			}else{
				if(enabled){
					gotof(1);
				}
			}
			if(onOut_hanlder) onOut_hanlder();
		}
		
		private function setUp(e:MouseEvent):void{
			if(!enabled) return;
			if(_isDown){
				clickHandler();
				if(isPopUp && isSelected){
					gotof(6);
				}else{
					btnGotoStopTwo();
				}
			}else{
				btnGotoStopTwo();
			}
			_isDown = false;
			
		}
		
		private var defColor:Number = -1;
		private var chaColor:Number = 0xA6A6A6;//0xFAAE7C;
		private function gotof($frame:int):void{
			btn.gotoAndStop($frame);
			if(!enabled) return;
			if(parent.textField){
				var _col:Number = -1;
				switch($frame){
					case 1:
						if(Number(parent.textField.format.color) != chaColor)
							defColor = Number(parent.textField.format.color);
						if(isPopUp)
							_col = chaColor;
						parent.textField.alpha = 1;
						break;
					case 2:
						if(Number(parent.textField.format.color) != chaColor)
							defColor = Number(parent.textField.format.color);
						parent.textField.alpha = 0.8;
						break;
					case 3:
						parent.textField.alpha = 0.5;
						break;
					case 4:
						parent.textField.alpha = 1;
						break;
					////////////////////////////
					////////////////////////////
					////////////////////////////
					case 5:
						if(Number(parent.textField.format.color) != chaColor)
							defColor = Number(parent.textField.format.color);
						_col = defColor;
						parent.textField.alpha = 1;
						break;
					case 6:
						
						break;
					case 7:
						
						break;
					case 8:
						
						break;
				}
				if(_col > 0){
					parent.textField.format.color = _col;
					parent.textField.flushFormat();
				}
			}
		}
		
		public function addClick(fn:Function):void{
			click_fn = fn;
		}
		
		public function get isPopUp():Boolean{ return _isPopUp; }
		public function set isPopUp(value:Boolean):void{
			_isPopUp = value;
		}
		
		public function get enabled():Boolean { return _enabled; }
		public function set enabled(value:Boolean):void{
			_enabled = value;
			if(!enabled){
				if(isPopUp && isSelected){
					gotof(8);
				}else{
					gotof(4);
				}
				if(isEnabledChange){
					AnleiFilter.setNotColor(btn);
					parent.alpha = 0.8;
				}
				//if(parent.alpha == 1) parent.alpha = 0;
			}else{
				if(isPopUp && isSelected){
					gotof(5);
				}else{
					gotof(1);
				}
				if(isEnabledChange){
					AnleiFilter.setRgbColor(btn);
					parent.alpha = 1;
				}
				//if(parent.alpha == 0) parent.alpha = 1;
			}
			//parent.mouseEnabled = enabled;
		}
		
		public function setStyle($btn:MovieClip):void{
			parent.removeChild(btn);
			
			btn = $btn;
			gotof(1);
			parent.addChildAt(btn, 0);
			setOut(null);
		}
		
		public function dispose():void{
			parent.removeEventListener(MouseEvent.MOUSE_DOWN, setDown);
			parent.removeEventListener(MouseEvent.MOUSE_UP, setUp);
			parent.removeEventListener(MouseEvent.MOUSE_OVER, setOver);
			parent.removeEventListener(MouseEvent.MOUSE_OUT, setOut);
			
			parent = null;
			btn = null;
			
			click_fn = null;
			
		}
		
	}
}