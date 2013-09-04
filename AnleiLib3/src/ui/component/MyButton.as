package ui.component
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	import anlei.util.AnleiFilter;
	import anlei.util.PublicProperty;
	
	import ui.UIConfig;
	import ui.abs.AbsButton;
	import ui.abs.AbstractComponent;
	
	public class MyButton extends MySprite implements AbstractComponent
	{
		public static const SELECTED:String= 'selected_event';
		public static const StyleLibName:String = 'styleLibName';
		
		public static var FONT:String;
		public static var FONT_SIZE:int;
		
		/**可做为外部记录数据使用(如target.name=='xxx', target.data=='xxxx')*/
		public var data:Object;
		
		public var btnSkin:MovieClip;
		protected var absBtn:AbsButton;
		protected var _textField:MyTextField;
		private var _label:String = '';
		
		public var iconTextContainer:MyHVBox;
		private var icon_url:String = '';
		private var icon_img:MyImage;
		
		
		private var style:String = 'btn_0';
		private var _isUse:Boolean = true;
		
		/**是否超出按钮长度有省略号代替后二个字符*/
		public var isDispose3:Boolean = true;
		
		public function MyButton(lab:String = 'Button')
		{
			btnSkin = GetButtonStyleSource(style);
			btnSkin.gotoAndStop(1);
			addChild(btnSkin as DisplayObject);
			absBtn = new AbsButton(btnSkin as MovieClip, this);
			absBtn.onOver_hanlder = onOver;
			absBtn.onOut_hanlder  = onOut;
			create_it_hvbox();
			create_textField();
			
			label = lab;
			iconTextContainer.reset();
			
			this.mouseChildren = false;
		}
		
		private function onOver():void {
			if(textField.text != _label){
				Layers.toolTip = _label;
			}
		}
		
		private function onOut():void {
			if(textField.text != _label) Layers.toolTip = null;
		}
		
		public static function GetButtonStyleSource(s:String):MovieClip {
			return PublicProperty.GetSourceMC(s, UIConfig.UI_SKIN) as MovieClip;
		}
		
		private function create_it_hvbox():void{
			iconTextContainer = new MyHVBox(MyHVBox.TYPE_H);
			iconTextContainer.mouseChildren = false;
			iconTextContainer.mouseEnabled = false;
			iconTextContainer.width = width;
			iconTextContainer.height = height;
			iconTextContainer.VAlign = MyHVBox.V_MID;
			iconTextContainer.HAlign = MyHVBox.H_CENTER;
			///iconTextContainer.isBG = true;//////
			iconTextContainer.updateSize();
			addChild(iconTextContainer);
		}
		
		private function create_textField():void{
			_textField = new MyTextField();
			_textField.wordWrap = false;
			_textField.multiline = false;
			_textField.storeFilter.color = 0x751C0C;
			//_textField.storeFilter.blurX = 3;
			//_textField.storeFilter.blurY = 3;
			//_textField.storeFilter.strength = 2;
			_textField.isStroke = true;
			_textField.textformat.font = FONT;
			_textField.textformat.size = FONT_SIZE;
			//_textField.textformat.bold = true;
			//_textField.format.color = -1;
			//_textField.textColor = -1;
			///_textField.border = true;//////
			_textField.autoSize = TextFieldAutoSize.LEFT;
			iconTextContainer.addChild(_textField);
		}
		
		private function dispose3Point():void{
			if(!isDispose3) return;
			textField.text = _label;
			var _tw:Number = textField.width;//文本宽
			var _iw:Number = 0;//icon图标宽
			var _ig:Number = 0;//hvbox的gap
			if(icon_img && icon_img.url){//如果有icon图标，则包括icon的宽和hvbox的gap
				_iw = icon_img.width;
				_ig = iconTextContainer.Gap;
			}
			var _tl:Number = _tw+_iw+_ig;//总宽
			var _btnWidth:Number = btnSkin.width;//按钮宽
			if(_tl > _btnWidth){//如果总宽>按钮宽
				var _aw:Number = 0;//字的总宽
				var _aIndex:int = -1;//当前判断的字索引
				for(var i:int = 0 ; i < _label.length; i++){
					var _rect:Rectangle = textField.getCharBoundaries(i);
					if(!_rect) continue;
					_aw += _rect.width;//累加每个字的宽
					if(_aw >= _btnWidth-_iw-_ig){//如果字的总宽>按钮宽-icon图标宽-hvbox的gap
						_aIndex = i;//超宽了，记住最个一个索引
						break;
					}
				}
				if(_aIndex != -1){//有索引值，则把0到索引的字截取出来，替换最后两个字符为(...)
					textField.text = _label.substring(0, _aIndex - 2) + "...";
				}
			}
			//trace(_tw, _iw, _ig, "LT:", _tl, "T:"+_btnWidth);
		}
		
		private function onCompImg():void{
			iconTextContainer.addChild(icon_img);
			if(label)
				iconTextContainer.addChild(textField);
//			iconTextContainer.width = width;
//			iconTextContainer.height = height;
//			iconTextContainer.updateSize();
			iconTextContainer.reset();
		}
		
		public function get icon():String { return icon_url; }
		public function set icon(value:String):void{
			if(value){
				
				if(icon_img == null){
					icon_img = new MyImage(value, onCompImg);
					icon_img.mouseChildren = false;
					icon_img.mouseEnabled = false;
				}
				
				if(icon_url != value){
					if(icon_img){
						icon_img.url = value;
						icon_img.reload();
					}
				}
				
			}else{
				if(icon_img && icon_img.url){
					icon_img.url = '';
					iconTextContainer.removeChild(icon_img);
				}
			}
			
			icon_url = value;
			
			textField.text = _label;
			dispose3Point();
			iconTextContainer.reset();
		}
		
		override public function get enabled():Boolean { return absBtn.enabled; }
		override public function set enabled(value:Boolean):void{ absBtn.enabled = value; }
		
		public function get isEnabledChange():Boolean { return absBtn.isEnabledChange; }
		public function set isEnabledChange(value:Boolean):void{ absBtn.isEnabledChange = value; }
		
		public function get label():String{ return _label; }
		public function set label(value:String):void{
			_label = value;
			textField.text = value;
			if(!value){
				if(iconTextContainer.contains(textField)) iconTextContainer.removeChild(textField);
			}else{
				if(icon_img && icon_img.url){
					onCompImg();
				}else{
					iconTextContainer.addChild(textField);
				}
			}
			dispose3Point();
			iconTextContainer.reset();
		}
		
		public function get fontSize():Number { return textField.size; }
		public function set fontSize(value:Number):void{
			textField.size = value;
			iconTextContainer.reset();
		}
		
		public function get textField():MyTextField{ return _textField; }
		
		public function addClick(fn:Function):void{ absBtn.addClick(fn); }
		
		public function getStyle():String{ return style;}
		public function setStyle(s:String):void{
			
			/*if($isCS){
				var _w:Number = 0;
				var _h:Number = 0;
				if(btnSkin){
					_w = btnSkin.width;
					_h = btnSkin.height;
				}
			}*/
			
			
			style = s;
			btnSkin = GetButtonStyleSource(style);
			btnSkin[StyleLibName] = PublicProperty.obj2ClsName(btnSkin);
			absBtn.setStyle(btnSkin as MovieClip);
			iconTextContainer.width = width;
			iconTextContainer.height= height;
			iconTextContainer.updateSize();
			dispose3Point();
			iconTextContainer.reset();
			
			
			/*if($isCS){
				if(_w > 0){
					width = _w;
				}
				if(_h > 0){
					height= _h;
				}
			}*/
		}
		
		public function get isPopUp():Boolean{ return absBtn.isPopUp; }
		public function set isPopUp(value:Boolean):void{ absBtn.isPopUp = value; }
		
		public function get selected():Boolean{ return absBtn.selected; }
		public function set selected(value:Boolean):void { absBtn.selected = value; }
		
		public function get isUse():Boolean{ return _isUse; }
		public function set isUse(value:Boolean):void{
			_isUse = value;
			if(isUse){
				AnleiFilter.setRgbColor(this);
				mouseEnabled = false;
			}else{
				AnleiFilter.setNotColor(this);
				mouseEnabled = true;
			}
		}
		
		override public function get width():Number{ return btnSkin.width;}
		override public function set width(value:Number):void{
			btnSkin.width = value;
			dispose3Point();
			if(iconTextContainer){
				iconTextContainer.width = value;
				iconTextContainer.updateSize();
			}
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number{ return btnSkin.height; }
		override public function set height(value:Number):void{
			btnSkin.height = value;
			if(iconTextContainer){
				iconTextContainer.height = value;
				iconTextContainer.updateSize();
			}
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function dispose():void {
			iconTextContainer.dispose();
			
			absBtn.dispose();
			absBtn = null;
			btnSkin = null;
			
			super.dispose();
		}
		
		public function setSize(_width:Number, _height:Number):void {
			width = _width;
			height = _height;
			dispose3Point();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		public function move(_x:Number, _y:Number):void {
			x = _x;
			y = _y;
		}
		
	}
}