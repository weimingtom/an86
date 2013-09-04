package ui.abs
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import anlei.util.PublicProperty;
	
	import ui.component.MyBorderText;
	import ui.component.MySprite;

	/**
	 * 用法:
			AbsWin.Window = this;
			var _win:AbsWin = new AbsWin('anlei', 300, 300);
			_win.pop();
			_win.removePop();
			_win.dispose();
	 * */
	public class AbsWin extends Sprite
	{
		////////////////////////初始配置//////////////////////////
		
		/**[必须]弹出窗体的容器*/
		public static var Window:Sprite;
		/**[可变]窗体的图片[1]默认*/
		/**[可变]关闭按钮类须继承SimpleButton类*/
		public static var CloseBtn_class:Class;
		/**[不变]弹出和关闭效果的时间*/
		public static const TWEEN_TIME:Number = .3;
		/**[不变]弹窗Y轴的动画偏移量*/
		public static const Y_OFFECT:Number = 20;
		
		public var container:MySprite = new MySprite();
		
		/////////////////////////私有字段////////////////////////////
		protected var init_width:int;
		protected var init_height:int;
		protected var _width:int;
		protected var _height:int;
		private var _bg:Sprite;
		private var winEffect:WinEffect;
		
		private var _title:String;
		
		private var currentBitmap:Bitmap;
		private var mask_mc:Sprite;
		private var _isMask:Boolean = false;
		
		
		////////////////////////////////////////////////////
		
		private var _winRoot:Sprite;
		/**关闭按钮*/
		public var closeBtn:SimpleButton;
		/**窗体打开否 true=开/false=关*/
		public var isOpenWin:Boolean = false;
		/**窗体是否被ESC关闭 true=是/false=否*/
		public var isESCCloseWin:Boolean = true;
		/**标题栏*/
		public var title_txt:MyBorderText;
		private var _isDrag:Boolean = true;
		
		////////////////////////////////////////////////////
		
		/**窗体的图片[2]参数传入*/
//		private var bitmapData:BitmapData;
		/**9宫格切片 new Rectangle(50, 50, 12, 9)从50,50坐标到宽12高9(用PS取中间部分)*/
//		public var rect9Scale:Rectangle = new Rectangle(50, 50, 12, 9);
		/**关闭按钮的相对右对齐的X坐标*/
		protected var CloseBtn_OFF_X:Number = 8;
		/**关闭按钮的Y坐标*/
		protected var CloseBtn_OFF_Y:Number = 7;
		
		/////////////////////////////////////////////////////
		/**弹窗时是否在最顶层*/
		public var isTop:Boolean = true;
		/**弹窗时是否要出现3D动画效果*/
		public var isCartoon:Boolean = false;
		/**是否在pop打开新窗体时，再pop后会关闭窗体*/
		public var isAutoPR:Boolean = true;
		/**忽略动画效果，强制打开或关闭窗体*/
		public var isIrogEffect:Boolean = true;
		
		public function AbsWin($title:String = '', $width:Number = -1, $height:Number = -1)
		{
			title = $title;
			_width = $width;
			_height= $height;
			winRoot = Window;
		}
		
		private function getStage():Stage{
			var _stage:Stage = Entrance.getInstance().Root.stage;
			return _stage; 
		}
		
		/**窗口样式*/
		public function get bg():Sprite { return _bg; }
		public function set bg(value:Sprite):void {
			if(value){
				if(bg && this.contains(bg)){
					super.removeChild(bg);
				}
				_bg = value;
				init_width = bg.width;
				init_height= bg.height;
				
				if(_width > 0){
					bg.width = _width;
				}
				
				if(_height> 0){
					bg.height = _height;
				}
				
				setInit();
			}
		}

		private function setInit():void{
			/*if(sbs == null){
				inits();
			}*/
			inits();
		}
		
		private function inits():void {
			super.addChildAt(bg, 0);
			
			if(winEffect == null){
				winEffect = new WinEffect();
			}
			
			if(title_txt == null){
				title_txt = new MyBorderText(title);
				title_txt.setStyle(0);
				title_txt.mouseChildren = false;
				title_txt.mouseEnabled = false;
				title_txt.textField.format.color = 0xE5C491;
				super.addChild(title_txt);
			}
			resetTitleText_X();
			
			if(currentBitmap == null){
				currentBitmap = new Bitmap();
			}
			
			if(!super.contains(container)){
				super.addChild(container);
			}
			
			if(CloseBtn_class == null){
				CloseBtn_class = TempCloseBtn_class;
			}
			if(closeBtn == null){
				closeBtn = new CloseBtn_class();
				closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtn);
				closeBtn.name = "closeBtn";
				super.addChild(closeBtn);
			}
			resetCloseBtnXY();
			
		}
		
		private function dispatchClose():void{
			var evt:MouseEvent = new MouseEvent(MouseEvent.CLICK);
			closeBtn.dispatchEvent(evt);
		}
		
		/**窗体是否可以被拖动*/
		public function get isDrag():Boolean { return _isDrag; }
		public function set isDrag(value:Boolean):void {
			_isDrag = value;
			if(isDrag){
				bg.removeEventListener(MouseEvent.MOUSE_DOWN, onMD);
				bg.addEventListener(MouseEvent.MOUSE_DOWN, onMD);
			}else{
				bg.removeEventListener(MouseEvent.MOUSE_DOWN, onMD);
			}
		}

		public function onCloseBtn(e:MouseEvent):void{
			removePop();
		}
		
		private function onMD(e:MouseEvent):void{
			//addTop();
			mouseChildren = false;
			mouseEnabled = false;
			if(isDrag){
				startDrag(false,new Rectangle(0, 0, getStage().stageWidth - bg.width, getStage().stageHeight - bg.height));
			}
			
			if(!bg.hasEventListener(MouseEvent.MOUSE_MOVE))
				bg.addEventListener(MouseEvent.MOUSE_MOVE, onMM);
			
			if(!getStage().hasEventListener(MouseEvent.MOUSE_UP))
				getStage().addEventListener(MouseEvent.MOUSE_UP, onMU);
		}
		
		private function onMU(e:MouseEvent):void{
			mouseChildren = true;
			mouseEnabled = true;
			if(isDrag) stopDrag();
			clearEvent();
//			if(e){
//				e.stopImmediatePropagation();
//				e.stopPropagation();
//			}
		}
		
		private function onMM(e:MouseEvent):void{
			e.updateAfterEvent();
		}
		
		private function clearEvent():void{
			bg.removeEventListener(MouseEvent.MOUSE_MOVE, onMM);
			if(getStage())
				getStage().removeEventListener(MouseEvent.MOUSE_UP, onMU);
		}
		
		/**全局键盘事件, 不被内存释放处理*/
		private function addKeyEvent():void{
			//if(!getStage().hasEventListener(KeyboardEvent.KEY_DOWN)){
			removeKeyEvent();
			getStage().addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			//}
		}
		private function removeKeyEvent():void{
			getStage().removeEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
		}
		/**按下ESC键时关闭窗口*/		
		private function onKeydown(e:KeyboardEvent):void{
			if(e.charCode == 27){
				var _win:AbsWin = winRoot.getChildAt(winRoot.numChildren - 1) as AbsWin;
				if(_win && _win.isESCCloseWin){
					_win.removePop();
				}
			}
		}
		/******-----------------------------********/
		
		private function onShowStart():void{
			addTop();
			if(isDrag){
				if(!bg.hasEventListener(MouseEvent.MOUSE_DOWN))
					bg.addEventListener(MouseEvent.MOUSE_DOWN, onMD);
			}
			if(winRoot.contains(currentBitmap)){
				winRoot.removeChild(currentBitmap);
			}
		}
		
		private function onHideFn():void {
			if(this.parent)
				this.parent.removeChild(this);
			bg.removeEventListener(MouseEvent.MOUSE_DOWN, onMD);
		}
		
		private function onRemoveCurrentBitmap():void {
			if(currentBitmap.parent)
				currentBitmap.parent.removeChild(currentBitmap);
			this.dispatchEvent(new Event(Event.CLOSE));
		}
		
		private function addTop():void{
			if(isTop){
				winRoot.addChild(this);
			}else{
				winRoot.addChildAt(this, 0);
				if(mask_mc)
					winRoot.addChildAt(mask_mc, 0);
			}
		}
		
		protected function resetCloseBtnXY():void{
			closeBtn.x = bg.width - CloseBtn_OFF_X - closeBtn.width;
			closeBtn.y = CloseBtn_OFF_Y;
		}
		
		/** 获取动画前的截图 */
		private function getBitmap():Bitmap{
			var _w:Number = width;
			var _h:Number = height;
			if(_w > 2000) _w = 2000;
			if(_w < 0) _w = 1;
			if(_h > 2000) _h = 2000;
			if(_h < 0) _h = 1;
			var bmd:BitmapData = new BitmapData(_w, _h, true,0x000000);
			bmd.draw(this);
			if(currentBitmap.bitmapData) currentBitmap.bitmapData.dispose();
			currentBitmap.bitmapData = bmd;
			return currentBitmap;
		}
		
		/******-----------------------------********/
		
		public function dispose():void{
			clearEvent();
			bg.removeEventListener(MouseEvent.MOUSE_DOWN, onMD);
			
			container.removeAllChild();
			container.clearListeners();
			super.removeChild(container);
			container = null;
			
			if(contains(closeBtn)){
				removeChild(closeBtn);
			}
			closeBtn = null;
			
			winEffect = null;
			
			removeChild(bg);
			
			bg = null;
			
			if(this.parent)
				this.parent.removeChild(this);
		}
		
		public function get winRoot():Sprite {
			if(_winRoot == null) _winRoot = Window;
			return _winRoot;
		}
		public function set winRoot(value:Sprite):void { _winRoot = value; }

		public function get isTitle():Boolean{
			if(super.contains(title_txt)){
				return true;
			}
			return false;
		}
		
		public function set isTitle(value:Boolean):void{
			if(value){
				super.addChild(title_txt);
			}else{
				if(super.contains(title_txt)){
					super.removeChild(title_txt);
				}
			}
		}
		
		/**是否要遮照*/
		public function get isMask():Boolean { return _isMask; }
		public function set isMask(value:Boolean):void {
			_isMask = value;
			setMask();
		}
		
		private function setMask():void{
			if(isMask && isOpenWin){
				if(!mask_mc){
					mask_mc = PublicProperty.CreateAlphaSP(true, getStage().width, getStage().height, 0, 0, 0x0, 0.4);
				}
				winRoot.addChild(mask_mc);
			}else{
				if(mask_mc && mask_mc.parent){
					mask_mc.parent.removeChild(mask_mc);
				}
			}
		}
		
		public function resetTitleText_X():void{
			///title_txt.pack();
			//title_txt.x = int((bg.width - title_txt.width)/2);
			title_txt.width = bg.width;
			title_txt.height= 35;
		}
		
		override public function set width(value:Number):void{
			if(value <= 0){
				bg.width = init_width;
			}else{
				bg.width = value;
				_width = value;
			}
			resetCloseBtnXY();
			resetTitleText_X();
		}
		
		override public function set height(value:Number):void{
			if(value <= 0){
				bg.height = init_height;
			}else{
				bg.height = value;
				_height = value;
			}
		}
		
		public function size($w:Number, $h:Number):void{
			width = $w;
			height= $h;
		}
		
		override public function addChild(dod:DisplayObject):DisplayObject{
			setInit();
			return container.addChild(dod);
		}
		
		/*override public function removeChild(child:DisplayObject):DisplayObject{
		return container.removeChild(child);
		}*/
		/*
		override public function contains(child:DisplayObject):Boolean{
			return container.contains(child);
		}
		*/
		public function remove(child:DisplayObject):DisplayObject{
			if(child == null || !container.contains(child)) return null;
			return container.removeChild(child);
		}
		
		public function set title(value:String):void{
			_title = value;
			if(title_txt && title_txt.textField){
				title_txt.textField.htmlText = _title;
				resetTitleText_X();
			}
		}
		public function get title():String{
			return _title;
		}
		/*
		public function move($x:int, $y:int):void{
			x = $x;
			y = $y;
		}
		*/
		public function pop($x:int = -1, $y:int = -1):void{
			if(isIrogEffect && winEffect.isEffect) return;
			
			if(isOpenWin && isAutoPR){
				dispatchClose();
				return;
			}
			///////////////////////
			setInit();
			addTop();
			onHideFn();
			
			if($x == -1){
				x = int(getStage().stageWidth / 2 - bg.width / 2);
			}else{
				x = $x;
			}
			
			if($y == -1){
				y = int(getStage().stageHeight/ 2 - bg.height/ 2 + Y_OFFECT);
			}else{
				y = $y;
			}
			
			currentBitmap.x = x;
			currentBitmap.y = y + Y_OFFECT;
			winRoot.addChild(currentBitmap);
			winEffect.show(getBitmap(), onShowStart, isCartoon);
			isOpenWin = true;
			addKeyEvent();
			setMask();
		}
		
		public function removePop():void{
			if(isIrogEffect && winEffect.isEffect) return;
			onMU(null);
			currentBitmap.x = x;
			currentBitmap.y = y;
			onHideFn();
			winRoot.addChild(currentBitmap);
			winEffect.hide(getBitmap(), onRemoveCurrentBitmap, isCartoon);
			isOpenWin = false;
			removeKeyEvent();
			setMask();
		}

		public function move($x:int, $y:int):void{
			x = $x;
			y = $y;
		}
	}
}
import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Point;

import ui.abs.AbsWin;

/**弹/关窗的效果类*/
class WinEffect{
	
	private var tween:TweenLite;
	
	private function get stage():Stage{
		var _stage:Stage = Entrance.getInstance().Root.stage;
		return _stage;
	}
	
	public function get isEffect():Boolean {
		return tween ? true : false;
	}
	
	public function show(start_bitmap:Bitmap, onStart:Function, is3D:Boolean = true):void{
		if(is3D) setObjectCenter(start_bitmap);
		var init_srx:int = start_bitmap.rotationX;
		var init_x:int = start_bitmap.x;
		start_bitmap.x = int(stage.stageWidth / 2 - start_bitmap.width/4);
		start_bitmap.alpha = 0.01;
		if(is3D) start_bitmap.rotationX = 50;
		start_bitmap.scaleX = start_bitmap.scaleY = 0.5;
		tween = TweenLite.to(start_bitmap, AbsWin.TWEEN_TIME, {x:init_x, scaleX:1, scaleY:1, rotationX:init_srx, alpha:1, y:start_bitmap.y - AbsWin.Y_OFFECT, /*ease:Circ.easeInOut, */onComplete:onStartCom});
		function onStartCom():void{
			if(onStart!=null) onStart();
			replyPro(start_bitmap);
			tween = null;
		}
	}
	
	public function hide(end_bitmap:Bitmap, onEnd:Function, is3D:Boolean = true):void{
		if(is3D) setObjectCenter(end_bitmap);
		var init_srx:int = end_bitmap.rotationX;
		if(is3D) init_srx = -30;
		var init_x:Number = end_bitmap.x + end_bitmap.width/4;
		tween = TweenLite.to(end_bitmap, AbsWin.TWEEN_TIME, {x:init_x, scaleX:0.5, scaleY:0.5, rotationX:init_srx, alpha:0.01, y:end_bitmap.y + AbsWin.Y_OFFECT, /*ease:Circ.easeInOut, */onComplete:onEndCom});
		function onEndCom():void{
			if(onEnd!=null) onEnd();
			replyPro(end_bitmap);
			tween = null;
		}
	}
	
	private function replyPro(bitmap:Bitmap):void{
		bitmap.alpha = 1;
		bitmap.rotationX = 0;
		bitmap.scaleX = bitmap.scaleY = 1;
		//////////////
		if(bitmap.bitmapData) bitmap.bitmapData.dispose();
		bitmap.bitmapData = null;
		bitmap = null;
	}
	
	private function setObjectCenter(start_bitmap:Bitmap):void{
		var _sx:Number = start_bitmap.x + start_bitmap.width/2;
		var _sy:Number = start_bitmap.y + start_bitmap.height/2;
		if(start_bitmap.root!=null){
			start_bitmap.root.transform.perspectiveProjection.projectionCenter = new Point(_sx, _sy);
		}
	}
	
}
/**关闭按钮类*/
class TempCloseBtn_class extends SimpleButton{
	public function TempCloseBtn_class(){
		super(	CreateAlphaSP(true, 24,24,0,0,0xFF0000,0.5),
			   	CreateAlphaSP(true, 24,24,0,0,0xFF0000,0.9),
				CreateAlphaSP(true, 24,24,0,0,0xFF0000,0.2),
				CreateAlphaSP(true, 24,24,0,0,0xFF0000,1)
		); 
	}
	private function CreateAlphaSP(_mouseEnabled:Boolean,
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
}