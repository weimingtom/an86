package ui.abs
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import ui.component.MyAlert;
	import ui.component.MyBorderText;
	import ui.component.MyButton;
	import ui.component.MyHVBox;
	import ui.component.MyWin;
	import ui.event.CloseEvent;

	public class AlertForm extends MyWin
	{
		public var txt:MyBorderText;
		public var hbox:MyHVBox;
		public var yes_btn:MyButton;
		public var no_btn:MyButton;
		public var ok_btn:MyButton;
		public var cancel_btn:MyButton;
		
		public var closeFunction:Function;
		/**按下任务按钮时，是否要关闭窗体*/
		public var isAtuoClose:Boolean;

		//private var bgMC:Sprite;
		
		private var _isAutoDispose:Boolean = true;
		
		public function AlertForm($title:String, $width:Number = -1, $height:Number = -1)
		{
			super($title, $width, $height, 1);
			inits();
		}
		
		private function inits():void
		{
			txt = new MyBorderText('');
			txt.setStyle(0);
			txt.textField.format.color = 11507025;
			txt.textField.isStroke = true;
			txt.textField.isInput = false;
			txt.textField.isBackground = false;
			txt.textField.align = TextFieldAutoSize.CENTER;
			txt.width = _width - 50;
			txt.height= _height - 120;
			txt.isTextCenterY = false;
			//txt.isScroll = true;
			txt.move(24, 56);
			/*
			scroll = new MyScrollBar();
			scroll.source = txt.UI;
			scroll.setSize(txt.width, txt.height);
			scroll.move(20, 40);
			*/
			hbox = new MyHVBox(MyHVBox.TYPE_H);
			hbox.Gap = 8;
			hbox.width = _width;
			//hbox.height = 100;
			hbox.HAlign = MyHVBox.H_CENTER;
			hbox.y = _height - 60;
			
			yes_btn = create('yes_btn');
			no_btn = create('no_btn');
			ok_btn = create('ok_btn');
			cancel_btn = create('cancel_btn');
			
			this.addEventListener(MouseEvent.CLICK, click_close);
			this.addEventListener(Event.CLOSE, onClose_event);
			
			addChild(txt);
			addChild(hbox);
			/*hbox.addChild(yes_btn);
			hbox.addChild(no_btn);
			hbox.addChild(ok_btn);
			hbox.addChild(cancel_btn);*/
			
			removeChild(closeBtn);
			
		}
		
		private function create($name:String):MyButton{
			var _btn:MyButton = new MyButton();
			_btn.setStyle("btn_12");
			_btn.textField.format.color = 0xCE9555;
			_btn.name = $name;
			//_btn.setSize(60, 22);
			return _btn;
		}
		
		override public function dispose():void {
			closeFunction = null;
			
			container.removeAllChild();
			hbox.removeAllChild();
			
			txt.dispose();
			
			txt = null;
			hbox = null;
			yes_btn = null;
			no_btn = null;
			ok_btn = null;
			cancel_btn = null;
			
			super.dispose();
			//removeBG();
		}
		/*
		private function removeBG():void{
			if(bgMC && winRoot.contains(bgMC)){
				winRoot.removeChild(bgMC);
			}
		}
		*/
		public function click_close(e:Event):void{
			var bid:int = -1;
			if(e.target.name == "yes_btn") bid=MyAlert.YES;
			if(e.target.name == "no_btn") bid=MyAlert.NO;
			if(e.target.name == "ok_btn") bid=MyAlert.OK;
			if(e.target.name == "cancel_btn") bid=MyAlert.CANCEL;
			if(bid != -1){
				var evt:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
				evt.detail = bid;
				closeFunction && closeFunction(evt);
				if(isAtuoClose){
					this.removePop();
					//removeBG();
				}
			}
		}
		
		private function onClose_event(e:Event):void{
			this.removeEventListener(Event.CLOSE, onClose_event);
			if(isAutoDispose) dispose();
			//removeBG();
		}
		
		public function setText(value:String):void{
			txt.textField.htmlText = value;
		}
		/*
		override public function pop($x:int=-1, $y:int=-1):void{
			if(bgMC == null){
				bgMC = PublicProperty.CreateAlphaSP(true, Entrance.getInstance().Root.stage.stageWidth, Entrance.getInstance().Root.stage.stageHeight, 0, 0, 0x0, 0.4);
			}
			if(isBG){
				winRoot.addChild(bgMC);
			}
			super.pop($x, $y);
		}
*/
		/**是否自动释放*/
		public function get isAutoDispose():Boolean { return _isAutoDispose; }
		public function set isAutoDispose(value:Boolean):void {
			_isAutoDispose = value;
		}

	}
}