package ui.component
{
	import anlei.util.PublicProperty;
	
	import fl.controls.ScrollPolicy;
	import fl.controls.TextArea;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import ui.UIConfig;
	import ui.abs.AbstractComponent;
	import ui.skin.MyScrollBarSkin;
	import ui.skin.MyTextAreaSkin;

	public class MyTextArea extends MySprite implements AbstractComponent
	{
		/*public static const FONT:String = '宋体';
		private static const TextSize:int = 12;*/
		private var textformat:TextFormat;
		public var textField:MyTextField;
		public var scroll:MyUIScrollBar;
		
		private var _isBG:Boolean = true;
		
		private var _gf:GlowFilter = new GlowFilter(0x0,1,2,2,10,1);
		private var _filter:Array;
		
		private var _isInput:Boolean = false;
		
		private var _tempUpSkin:Object;
		private var _newSkin:Class;
		
		public function MyTextArea()
		{
			textField = new MyTextField();
			addChild(textField);
			//textField.mouseEnabled = false;
			
			textformat = new TextFormat(MyTextFormat.FONT, MyTextFormat.TextSize, 0xFF0000);
			format = textformat;
			
			_filter = textField.filters;
//			isScroll = false;
		}
		
		public function flushFormat():void{ format = format; }
		
		public function set format($format:TextFormat):void{
			textformat = $format;
			textField.setTextFormat($format);
			textField.defaultTextFormat = $format;
		}
		
		public function get format():TextFormat{
			return textformat;
		}
		
		public function get size():int{ return int(format.size); }
		public function set size(value:int):void{
			format.size = value;
			flushFormat();
		}
		
		public function get isInput():Boolean{ return _isInput; }
		public function set isInput(b:Boolean):void{
			_isInput = b;
			if(b){
				textField.type = TextFieldType.INPUT;
			}else{
				textField.type = TextFieldType.DYNAMIC;
			}
		}
		
		public function get selectable():Boolean{
			return textField.selectable;
		}
		public function set selectable(b:Boolean):void{
			textField.selectable = b;
		}
		
		/**TextFieldAutoSize.LEFT*/
		public function set align(value:String):void{
			format.align = value;
			flushFormat();
		}
		
		/**是否要背景*/
		public function get isBackground():Boolean{ return _isBG; }
		/*public function set isBackground(b:Boolean):void{
			_isBG = b;
			if(b){
				setStyle('upSkin', _tempUpSkin);
			}else{
				if(!_tempUpSkin){
					_tempUpSkin = getStyle('upSkin');
				}
				if(!_newSkin){
					_newSkin = PublicProperty.GetSourceMCClass('NullContaine', UIConfig.UI_SKIN);
				}
				setStyle('upSkin', _newSkin);
			}
			flushFormat();;
		}*/
		public function set isBackground(b:Boolean):void{
			_isBG = b;
		}
		
		/**描边色彩*/
		public function get strokeColor():uint{ return _gf.color; }
		public function set strokeColor(value:uint):void{ _gf.color = value; isStroke = true; }
		
		/**是否要描边文本*/
		public function get isStroke():Boolean{ return textField.isStroke; }
		public function set isStroke(b:Boolean):void{
			textField.isStroke = b;
		}
		/*
		public function get isScroll():Boolean{
			var _onf:Boolean = false;
			if(verticalScrollPolicy == ScrollPolicy.ON){
				_onf = true;
			}
			return _onf;
		}
		
		public function set isScroll(value:Boolean):void{
			if(value){
				verticalScrollPolicy = ScrollPolicy.ON;
			}else{
				verticalScrollPolicy = ScrollPolicy.OFF;
			}
		}
		*/
		
		
		public function get isScroll():Boolean{
			var _onf:Boolean = false;
			if(scroll && contains(scroll)){
				_onf = true;
			}
			return _onf;
		}
		
		public function set isScroll(value:Boolean):void{
			if(value){
				if(!scroll){
					scroll = new MyUIScrollBar();
					scroll.scrollTarget = textField;
					MyScrollBarSkin.set(scroll);
					textField.width -= scroll.width;
				}
				addChild(scroll);
				scroll.x = textField.width;
				scroll.y = textField.y;
				scroll.height = textField.height;
			}else{
				if(scroll && contains(scroll)){
					removeChild(scroll);
				}
			}
		}
		
		public function get text():String { return textField.text; }
		public function set text(value:String):void{
			textField.text = value;
			flushFormat();
		}
		public function get htmlText():String { return textField.htmlText; }
		public function set htmlText(value:String):void{
			textField.htmlText = value;
			//flushFormat();
		}
		////////////////////////////
		
		
		override public function dispose():void{
			super.dispose();
			textField = null;
			scroll = null;
			_gf = null;
			_filter = null;
			_tempUpSkin = null;
		}
		
		override public function set width(value:Number):void{
			textField.width = value;
			if(isScroll){
				isScroll = true;
				scroll.update();
			}
		}
		
		override public function set height(value:Number):void{
			textField.height= value;
			if(isScroll){
				isScroll = true;
				scroll.update();
			}
		}
		
		public function setSize(_width:Number, _height:Number):void{
			width = _width;
			height= _height;
		}
		
		public function move(_x:Number, _y:Number):void{
			x = _x;
			y = _y;
		}
		
	}
}