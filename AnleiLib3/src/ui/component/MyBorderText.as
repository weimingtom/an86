package ui.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;
	
	import anlei.util.PublicProperty;
	
	import ui.UIConfig;
	
	/**有边框的文本*/
	public class MyBorderText extends MySprite
	{
		/**文本框*/
		public var textField:MyTextField;
		
		private var _lrPad:Number = 4;
		
		public var bg:Sprite;
		private var _text:String;
		private var _isTextCenterY:Boolean = true;
		private var style:int;
		
		
		public function MyBorderText($text:String = 'MyBorderText') {
			_text = $text;
			inits();
			///this.mouseChildren = false;
		}
		
		public function getStyle():int{ return style; }
		public function setStyle(n:int):void{
			style = n;
			if(bg && this.contains(bg)){
				this.removeChild(bg);
			}
			var o:Object = UIConfig.mcContent;
			bg = PublicProperty.GetSourceMC(UIConfig.mcContent.titleStyleCount[n], UIConfig.UI_SKIN) as Sprite;
			addChildAt(bg, 0);
			setTextSize();
		}
		
		private function inits():void {
			textField = new MyTextField();
//			textField.border = true;
			//textField.multiline = true;
			textField.wordWrap = false;
			//textField.autoSize = TextFieldAutoSize.CENTER;
			textField.format.align = TextFieldAutoSize.CENTER;
			textField.isStroke = true;
			textField.height = 21;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.gridFitType = GridFitType.SUBPIXEL;
			textField.sharpness = 400;
			textField.htmlText = _text;
			addChild(textField);
			setStyle(0);
			
			setTextSize();
			addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(event:Event):void {
			setTextFieldCenterX();
			setTextFiledCenterY();
		}
		
		private function setTextSize():void{
			if(bg){
				//width = width;
				height = height;
				flushLrPad();
				/*if(bg.scale9Grid.x > 0){
					width = bg.scale9Grid.width + textField.width;
				}else{
					width = width;
				}
				if(bg.scale9Grid.y > 0){
					height = bg.scale9Grid.height + textField.height;
				}else{
					height = height;
				}*/
				setTextFieldCenterX();
				setTextFiledCenterY();
			}
		}
		
		private function setTextFieldCenterX():void{
			//textField.x = int(bg.scale9Grid.x);
			textField.x = int((width - textField.width)/2);
		}
		
		private function setTextFiledCenterY():void{
			//textField.y = 0;
			/*if(isTextCenterY){
				textField.y = (height - textField.textHeight)/2;
			}else{*/
				if(bg.scale9Grid){
					textField.y = int(bg.scale9Grid.y);
				}
			/*}*/
		}
		
		private function flushLrPad():void{
			textField.x = _lrPad;
			textField.width = bg.width - _lrPad;
		}
		
		public function pack():void{
			setTextSize();
		}
		
		/**垂直居中*/
		public function get isTextCenterY():Boolean{ return _isTextCenterY; }
		public function set isTextCenterY(onf:Boolean):void{
			_isTextCenterY = onf;
			setTextFiledCenterY();
		}
		
		override public function dispose():void{
			removeChild(textField);
			textField.dispose();
			textField = null;
			
			removeEventListener(Event.RESIZE, onResize);
			
			super.dispose();
		}
		
		override public function get width():Number{ return bg.width; }
		override public function set width(value:Number):void{
			bg.width = value;
			/*if(bg.scale9Grid){
				textField.width = value - bg.scale9Grid.x*2;
			}*/
			textField.width = value;
			//setTextFieldCenterX();
		}
		
		override public function get height():Number{ return bg.height; }
		override public function set height(value:Number):void{
			bg.height = value;
			/*if(bg.scale9Grid){
				textField.height = value - bg.scale9Grid.y*2;
			}*/
			textField.height = value;
			//if(isTextCenterY){
				setTextFiledCenterY();
			//}
		}
		
		/*
		public function size($w:Number, $h:Number):void{
			//textField.setSize($w, $h);
			setTextSize();
		}
		*/
		public function move($x:int = 0, $y:int = 0):void{ x = $x; y = $y; }

		public function get text():String { return _text; }
		public function set text(value:String):void {
			_text = value;
			textField.htmlText = _text;
			setTextFiledCenterY();
			/*if(isTextCenterY){
				setTextFiledCenterY();
			}*/
			//pack();
		}

		public function get lrPad():Number { return _lrPad; }
		public function set lrPad(value:Number):void {
			_lrPad = value;
			flushLrPad();
		}
		
	}
}