package ui.component
{
	
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import anlei.util.PublicProperty;
	
	import anlei.util.HtmlConve;
	
	/**
	 * 用法：
	 * addChild(new MyTextButton("文字按钮"));
	 * @author Anlei
	 */
	public class MyTextButton extends MyHVBox
	{
		public static const textColor:uint = 0xFFFF00;
		public var ID:Object ={};
		
		private var _icon:MyImage;
		private var _txt:MyTextField;
		private var _tf:TextFormat;
		private var _text:String;
		private var _isUL:Boolean;
		
		
		private var _html:String = '';
		
		private var _filterColor:uint = 0x0;
		
		
		private var _textcolor:uint = textColor;
		public var downColor:uint = 0xCCCCCC;
		public var overColor:uint = 0xFF0000;
		
		public var isU:Boolean = false;
		
		public function MyTextButton($text:String = '' , $isUL:Boolean = true)
		{
			_text = $text;
			_isUL = $isUL;
			super(MyHVBox.TYPE_H);
			inits();
		}
		
		private function inits():void{
			VAlign = MyHVBox.V_MID;
			//isBG = true;
			
			_txt = new MyTextField();
			addChild(_txt);
			_txt.text = _text;
			_txt.selectable = false;
			//_txt.border = true;
			_txt.wordWrap = false;
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.antiAliasType=AntiAliasType.ADVANCED;
			_tf = _txt.format;//new TextFormat(MyTextField.FONT);
			if(_isUL){
				_tf.underline = true;
			}
			_txt.format = _txt.format;
			fontSize = 12;
			fontColor = textColor;
			
			
			width = _txt.textWidth;
			height= _txt.textHeight;
			
			this.mouseChildren = false;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onOver);
			
			
		}
		
		private function onDown(e:MouseEvent):void{
//			_txt.textColor = downColor;
			filterColor = downColor;
		}
		
		private function onOver(e:MouseEvent):void{
//			_txt.textColor = overColor;
			filterColor = overColor;
		}
		
		private function onOut(e:MouseEvent):void{
//			_txt.textColor = _textcolor;
			_txt.strokeColor = 0;
		}
		
		override public function dispose():void{
			if(_txt!=null){
				removeChild(_txt);
				_txt = null;
			}
			if(_icon !=null){
				removeChild(_icon);
				_icon.dispose();
				_icon = null;
			}
			
			this.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onOut);
			
			super.dispose();
		}
		
		public function get bold():Boolean{ return _txt.format.bold; }
		public function set bold(value:Boolean):void{ _txt.format.bold = value; _txt.format = _txt.format; }
		
		public function get underline():Boolean{ return _txt.format.underline; }
		public function set underline(value:Boolean):void{ _txt.format.underline = value; _txt.format = _txt.format; }
		
		public function get label():String{ return _html; }
		public function set label(value:String):void{
			_html = value;
			value = HtmlConve.color(_html);
			_txt.htmlText = value;
			pack();
		}
		/*
		public function get isUse():Boolean{ return _txt.mouseEnabled; }
		public function set isUse(onf:Boolean):void{
			_txt.mouseEnabled = onf;
		}
		*/
		
		
		/** 设置文字色彩 */		
		public function get fontColor():uint { return _textcolor; }
		public function set fontColor($color:uint):void{
			_textcolor = $color;
			_tf.color = $color;
			_txt.textColor = $color;
		}
		
		/** 设置文字大小 */
		public function get fontSize():uint{ return uint(_tf.size); }
		public function set fontSize($size:uint):void{
			_tf.size = $size;
			_txt.format = _txt.format;
			if(_icon) pack();
		}
		
		public function get isFilter():Boolean {
			var _onf:Boolean = false;
			if(_txt.filters && _txt.filters.length > 0){
				_onf = true;
			}
			return _onf;
		}
		public function set isFilter(value:Boolean):void {
			if(value){
				_txt.filters = [PublicProperty.OEffect(filterColor)];
			}else{
				_txt.filters = null;
			}
		}
		
		/** 设置滤镜 */
		public function get filterColor():uint{ return _filterColor; }
		public function set filterColor($color:uint):void{
			_filterColor = $color;
			isFilter = true;
		}
		
		override public function pack():void{
			if(_icon){
				width = _icon.width + Gap + _txt.width;
				height = _icon.height > _txt.height ? _icon.height : _txt.height;
			}
			updateSize();
		}
		
		public function get textField():MyTextField{ return _txt; }

		/** 设置图标 */
		public function get icon():String{
			if(_icon == null ) return '';
			return _icon.url;
		}
		public function set icon($url:String):void{
			if(!_icon){
				_icon = new MyImage($url, function():void{
					pack();
					reset();
				});
			}else{
				_icon.url = $url;
				_icon.reload();
			}
			if(_icon != null){
				addChild(_icon);
				addChild(_txt);
//				_txt.x = _icon.width + 3;
//				_txt.y = (_icon.height - _txt.height)/2;
			}
		}
		
		public function setSize(w:Number, h:Number):void{
			textField.setSize(w, h);
		}
		
		public function move(_x:Number, _y:Number):void{
			this.x = _x;
			this.y = _y;
		}
	}
}