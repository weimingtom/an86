package ui.component
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import anlei.util.EnterFrame;
	
	import ui.abs.AbstractComponent;

	/**
	 * 文字滚动
	 * 用法：
	 * var _arr:Vector.<String> = new Vector.<String>();
	 * _arr.push("AAA");
	 * _arr.push("BBB");
	 * _arr.push("CCC");
	 *  _rc = new MyRescroll(_arr);
		_rc.setSize(250,20);
		_rc.move(10,25)
		addChild(_rc);
	 * 
	 * @author Anlei
	 */	
	public class MyRescroll extends MySprite implements AbstractComponent
	{
		public static const SPEED:Number = 1;
		private var NUM_W:Number = 100;
		private var NUM_H:Number = 100;
		
		private var data:Vector.<String> = new Vector.<String>();
		private var viewArr:Vector.<Bitmap>;
		
		private var hbox:MyHVBox = new MyHVBox(MyHVBox.TYPE_H);
		private var mask_sp:Sprite = CreateAlphaSP(false, NUM_W, NUM_H, 0, 0, 0xFF, 1);
		
		public var textColor:String;
		public var textSize:Number = 12;
		
		public var onEndFn:Function;
		
		public function MyRescroll() {
			hbox.mask = mask_sp;
			hbox.x = NUM_W+1;
			hbox.Gap = 30;
			viewArr = new Vector.<Bitmap>;
			addChild(hbox);
			addChild(mask_sp);
		}
		
		public function setData(value:String):void{
			data.push(value);
			inits();
		}
		
		private function delData(i:int):void{
			if(data.length > 0) data.splice(i, 1);
			if(viewArr.length > 0){
				hbox.removeChild(viewArr[i]);
				viewArr.splice(i, 1);
				hbox.pack();
				hbox.updateSize();
			}
		}
		
		private function inits():void{
			hbox.removeAllChild();
			disposeView();
			if(data != null){
				for(var i:int = 0 ; i < data.length; i++)
				{
					viewArr.push(createText(data[i]));
					hbox.addChild(viewArr[i]);
				}
				hbox.pack();
				hbox.updateSize();
			}
			
			EnterFrame.removeEnterFrame = onEnter;
			EnterFrame.enterFrame = onEnter;
		}
		private function onEnter():void{
			hbox.x -= SPEED;
			
			if(hbox.x <= -hbox.width){
				if(onEndFn) onEndFn();
				delData(0);
				hbox.x = NUM_W;
			}
		}
		
		private function createText($text:String):Bitmap{
			var _txt:MyTextField = new MyTextField();
			//_txt.styleSheet = PublicProperty.createCSS();
			_txt.isStroke = true;
			_txt.format.color = textColor;
			_txt.size = textSize;
			_txt.htmlText = $text;
			_txt.wordWrap = false;
			_txt.selectable = true;
			_txt.autoSize = TextFieldAutoSize.LEFT;
//			_txt.border = true;
			return _txt.bitmap;
		}
		
		/**创建一个色块 Sprite **/
		private static function CreateAlphaSP(_mouseEnabled:Boolean,
											 _width:Number, _height:Number,
											 _x:Number = 0, _y:Number = 0,
											 _fillColor:Number = 0xFF0000,
											 _fillAlpha:Number = 0):Sprite{
			var mask_sp:Sprite = new Sprite();
			mask_sp.mouseEnabled = _mouseEnabled;
			mask_sp.graphics.beginFill(_fillColor);
			mask_sp.graphics.drawRect(_x, _y, _width, _height);
			mask_sp.graphics.endFill();
			mask_sp.alpha = _fillAlpha;
			return mask_sp;
		}
		private function disposeView():void{
			var i:int;
			var _len:int = viewArr.length;
			for(i =0; i< _len; i++){
				viewArr[i].bitmapData.dispose();
			}
			for(i =0; i< _len; i++){
				viewArr.pop();
			}
			hbox.removeAllChild();
		}
		public function set GAP($value:Number):void{
			hbox.Gap = $value;
		}
		public function get GAP():Number{
			return hbox.Gap;
		}
		
		override public function dispose():void{
			var _len:int = data.length;
			for(var i:int =0 ;i < _len; i++){
				data.pop();
			}
			
			disposeView();
			
			hbox.dispose();
			hbox = null;
			
			super.dispose();
		}
		public function setSize(_width:Number, _height:Number):void{
			NUM_W = _width;
			NUM_H = _height;
			
			hbox.x = NUM_W+1;
			mask_sp.width = NUM_W;
		}
		public function move(_x:Number, _y:Number):void{
			x = _x;
			y = _y;
		}
	}
}