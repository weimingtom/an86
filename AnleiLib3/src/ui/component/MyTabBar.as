package ui.component
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import Events.GlobalEvent;
	
	import ui.UIConfig;
	
	[Event(name="TAB_CHANGE", type="Events.GlobalEvent")]

	public class MyTabBar extends MySprite
	{
		/**表切换事件*/
		public static const TAB_CHANGE:String = 'TAB_CHANGE_event'
		public static const DONT_CREATE_NAME:String = 'dont_create_name';
		
		public static const TOP:String = 'top';
//		public static const BOT:String = 'bot';
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		
		private static const BTN_NAME:String = 'btn_';
		
		public var Init_Btn_Style:String = 'tabtn_0';
		
		public static var Init_Border_Style:String = 'border_3';
		
		private var _offe:Number = 2;
		
		private var _layout:String = TOP;
		
		private var dict:Dictionary = new Dictionary();
		
		public var buttonHBox:MyHVBox;
		private var btnConArr:Array = [];
		private var currI:int = -1;
		
		
//		public var border:MyBorder;
		
		public function MyTabBar()
		{
			inits();
		}
		
		private function inits():void {
//			border = new MyBorder();
//			border.setStyle(Init_Border_Style);
			
			buttonHBox = new MyHVBox(MyHVBox.TYPE_H);
			//buttonHBox.width = buttonHBox.height = 2;
			//buttonHBox.isBG = true;
			super.addChild(buttonHBox);
			buttonHBox.addEventListener(MouseEvent.CLICK, onHBox_clickhandler);
			this.addEventListener(Event.REMOVED, onRemoveChild);
		}
		
		override public function dispose():void{
			buttonHBox.removeEventListener(MouseEvent.CLICK, onHBox_clickhandler);
			this.removeEventListener(Event.REMOVED, onRemoveChild);
			
			dict = null;
			buttonHBox.dispose();
			buttonHBox = null;
			btnConArr = null;
//			border.dispose();
//			border = null;
			
			super.dispose();
		}
		
		private function onRemoveChild(event:Event):void {
			var _dod:DisplayObject = event.target as DisplayObject;
			delete dict[_dod];
		}
		
		private function onHBox_clickhandler(event:MouseEvent):void {
			var _btn:MyButton = event.target as MyButton;
			if(_btn && _btn.enabled && _btn.name.indexOf(BTN_NAME) != -1){
				selectedIndex = event.target.data;
			}
		}
		
		private function setContaineXY2BorderXY():void{
			var _x:int;
			var _y:int;
			for (var i:int = 0; i < btnConArr.length; i++) 
			{
				switch(layout){
					case TOP:
						_x = 0;
						_y = buttonHBox.height;
						break;
					case LEFT:
						_x = buttonHBox.width;
						_y = 0;
						break;
					case RIGHT:
						_x = buttonHBox.width;
						_y = 0;
						break;
				}
				btnConArr[i].container.x = _x;
				btnConArr[i].container.y = _y;
			}
			
		}
		
		private function setLayoutTopHVBox():void{
			buttonHBox.width = buttonHBox.containe.width + _offe;
			buttonHBox.height= buttonHBox.containe.height+ _offe;
			
			buttonHBox.x = 0;
			buttonHBox.y = 0;//buttonHBox.height;
			
//			border.x = 0;
//			border.y = buttonHBox.containe.height - borderOffe;
			
			buttonHBox.Type   = MyHVBox.TYPE_H;
			buttonHBox.VAlign = MyHVBox.V_BOT;
			buttonHBox.HAlign = MyHVBox.H_LEFT;
			
			setContaineXY2BorderXY();
		}
		
		private function setLayoutBotHVBox():void{
			buttonHBox.width = buttonHBox.containe.width + _offe;
			buttonHBox.height= buttonHBox.containe.height+ _offe;
			
			buttonHBox.x = 0;
			buttonHBox.y = 0;//buttonHBox.height;//border.height - borderOffe;
			
//			border.x = 0;
//			border.y = 0;
			
			buttonHBox.Type   = MyHVBox.TYPE_H;
			buttonHBox.VAlign = MyHVBox.V_TOP;
			buttonHBox.HAlign = MyHVBox.H_LEFT;
			
			setContaineXY2BorderXY();
		}
		
		private function setLayoutLeftHVBox():void{
			buttonHBox.width = buttonHBox.containe.width + _offe;
			buttonHBox.height= buttonHBox.containe.height+ _offe;
			
			buttonHBox.x = 0;//buttonHBox.width;
			buttonHBox.y = 0;
			
//			border.x = buttonHBox.width - borderOffe;
//			border.y = 0;
			
			buttonHBox.Type   = MyHVBox.TYPE_V;
			buttonHBox.VAlign = MyHVBox.V_TOP;
			buttonHBox.HAlign = MyHVBox.H_RIGHT;
			
			setContaineXY2BorderXY();
		}
		
		private function setLayoutRightHVBox():void{
			buttonHBox.width = buttonHBox.containe.width + _offe;
			buttonHBox.height= buttonHBox.containe.height+ _offe;
			
			buttonHBox.x = 0;//buttonHBox.width;//border.width - borderOffe;
			buttonHBox.y = 0;
			
//			border.x = 0;
//			border.y = 0;
			
			buttonHBox.Type   = MyHVBox.TYPE_V;
			buttonHBox.VAlign = MyHVBox.V_TOP;
			buttonHBox.HAlign = MyHVBox.H_LEFT;
			
			setContaineXY2BorderXY();
		}
		/////////////////////////////////////////////
		/*public function get isBG():Boolean{
			var _onf:Boolean = false;
			if(this.contains(border)){
				_onf = true;
			}
			return _onf;
		}
		public function set isBG(value:Boolean):void{
			if(value == false){
				if(border.parent){
					border.parent.removeChild(border);
				}
			} else {
				super.addChildAt(border, 0);
			}
		}*/
		
		public function get selectedIndex():int { return currI; }
		public function set selectedIndex(i:int):void{
			if(btnConArr.length<=0)return;
			for (var j:int = 0; j < btnConArr.length; j++) {
				//把所有的容器移除
				if(btnConArr[j].container.parent){
					super.removeChild(btnConArr[j].container);
				}
				//把有按钮设成鼠标可用状态
				btnConArr[j].button.mouseEnabled = true;
				//恢复被选中的按钮(不选中)
				if(btnConArr[j].button.selected){
					btnConArr[j].button.selected = false;
					btnConArr[j].button.enabled = btnConArr[j].button.enabled;
				}
			}
			//按钮为选中状态
			btnConArr[i].button.selected = true;
			super.addChild(btnConArr[i].container);
			btnConArr[i].button.mouseEnabled = false;
			
			currI = i;
			
			this.dispatchEvent(new GlobalEvent(TAB_CHANGE, i));
		}
		
		public function getButton(i:int):MyButton {
			return BtnContainerGroup(btnConArr[i]).button;
		}
		
		public function getContainer(i:int):MySprite{
			return BtnContainerGroup(btnConArr[i]).container;
		}
		
		public function getContainers():Array{
			var _arr:Array = [];
			var _len:int = btnConArr.length;
			for (var i:int = 0; i < _len; i++) {
				_arr.push(BtnContainerGroup(btnConArr[i]).container);
			}
			return _arr;
		}
		
		public function getLabels():Array{
			var _arr:Array = [];
			var _len:int = btnConArr.length;
			for (var i:int = 0; i < _len; i++) {
				_arr.push(BtnContainerGroup(btnConArr[i]).button.label);
			}
			return _arr;
		}
		
		public function getStyle():int{ return Init_Btn_Style.split('_')[1]; }
		public function addTab(lab:String):void{
			var _btn:MyButton = new MyButton(lab);
			_btn.isPopUp = true;
			_btn.setStyle(Init_Btn_Style);
			
			var mc_obj:Object = UIConfig.mcContent;
			var _obj:Object = mc_obj.tabtnStyleConfig[getStyle()];
			_btn.textField.format.bold = _obj.b;
			_btn.fontSize = _obj.s;
			
			_btn.textField.height = _btn.textField.textHeight;
			var _con:MySprite = new MySprite();
			_con.name = DONT_CREATE_NAME;
			var _g:BtnContainerGroup = new BtnContainerGroup(_btn, _con);
			btnConArr.push(_g);
			_btn.name = BTN_NAME + (btnConArr.length-1);
			_btn.data = (btnConArr.length-1);
			_btn.textField.strokeColor = 0x202020;
			if(btnConArr.length == 1){
				selectedIndex = 0;
			}
			buttonHBox.addChild(_btn);
			
//			if(isBG){
//				super.addChildAt(border, 0);
//			}
			
			flush();
		}
		
		public function addTabChild(child:DisplayObject, i:int):void{
			btnConArr[i].container.addChild(child);
		}
		
		public function getHasContaine(i:int):Boolean{
			if(i < 0 || i >= btnConArr.length) return false;
			return true;
		}
		
		public function getContaineIndex(con:DisplayObject):int{
			for (var i:int = 0; i < btnConArr.length; i++) 
			{
				if(btnConArr[i].container == con){
					return i;
				}
				/*var _len:int = btnConArr[i].container.numChildren;
				for (var j:int = 0; j < _len; j++) 
				{
					if(btnConArr[i].container.getChildAt(j) == con){
						return i;
					}
				}*/
			}
			return -1;
		}
		
		public function removeTabAll():void{
			var _len:int = getLabels().length;
			for (var i:int = 0; i < _len; i++) 
			{
				removeTab(0);
			}
		}
		
		public function removeTab(i:int):void{
			if(!getHasContaine(i)) return;
			
			var _arr:Array = btnConArr.splice(i, 1);
			buttonHBox.removeChild(_arr[0].button);
			if(super.contains(_arr[0].container)){
				super.removeChild(_arr[0].container);
			}
			
			for (var j:int = 0; j < btnConArr.length; j++) {
				btnConArr[j].button.data = j;
			}
			
		}
		
		public function setButtonStyle(str:String):void{
			for (var j:int = 0; j < btnConArr.length; j++) {
				Init_Btn_Style = str;
				var _btn:MyButton = MyButton(btnConArr[j].button)
				_btn.setStyle(Init_Btn_Style);
				var mc_obj:Object = UIConfig.mcContent;
				var _obj:Object = mc_obj.tabtnStyleConfig[getStyle()];
				_btn.textField.format.bold = _obj.b;
				_btn.fontSize = _obj.s;
			}
			flush();
		}
		
		public function flush():void{ layout = _layout; }
		
		public function get layout():String { return _layout; }
		public function set layout(str:String):void{
			switch(str){
				case TOP:
					
					if(_layout == LEFT || _layout == RIGHT){
						setLayoutBotHVBox();
					}
					setLayoutTopHVBox();
					
					break;
				/*case BOT:
					
					if(_layout == LEFT || _layout == RIGHT){
						setLayoutTopHVBox();
					}
					setLayoutBotHVBox();
					
					break;*/
				case LEFT:
					
					if(_layout == TOP/* || _layout == BOT*/){
						setLayoutRightHVBox();
					}
					setLayoutLeftHVBox();
					
					break;
				case RIGHT:
					
					if(_layout == TOP/* || _layout == BOT*/){
						setLayoutLeftHVBox();
					}
					setLayoutRightHVBox();
					
					break;
			}
			
			buttonHBox.updateSize();
			buttonHBox.reset();//////////////
			_layout = str;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{ return child; }
		
		//private var _width:Number = 0;
		override public function get width():Number{ return buttonHBox.width; }// _width == 0 ? buttonHBox.width + _offe : _width; }
		override public function set width(value:Number):void{
			/*_width = value + _offe;
			buttonHBox.width = _width;
			buttonHBox.updateSize();
			buttonHBox.reset();*/
		}
		
		//private var _height:Number = 0;
		override public function get height():Number { return buttonHBox.height;}// _height == 0 ? buttonHBox.height + _offe : _height; }
		override public function set height(value:Number):void{
			/*_height = value + _offe;
			buttonHBox.height = _height;
			buttonHBox.updateSize();
			buttonHBox.reset();*/
		}

		/**按钮压边的间距
		public function get borderOffe():Number { return _borderOffe; }
		public function set borderOffe(value:Number):void {
			_borderOffe = value;
			flush();
		}*/

		
	}
}


import ui.component.MyButton;
import ui.component.MySprite;

class BtnContainerGroup {
	
	public var button:MyButton;
	public var container:MySprite;
	
	public function BtnContainerGroup($btn:MyButton, $con:MySprite) {
		button = $btn;
		container = $con;
	}
	
}