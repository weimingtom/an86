package ui.component
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 用法:
	 * 		box1 = CreateAlphaSP(false, 20, 20);
			box2 = CreateAlphaSP(false, 30, 30);
			box3 = CreateAlphaSP(false, 40, 40);
			box4 = CreateAlphaSP(false, 50, 50);
			box5 = CreateAlphaSP(false, 60, 60);
			
			vhbox = new MyHVBox();
			vhbox.x = vhbox.y = 200;
			vhbox.Type = MyHVBox.TYPE_H;
			vhbox.VAlign = MyHVBox.V_TOP;
			vhbox.HAlign = MyHVBox.H_RIGHT;
			vhbox.width = 200;
			vhbox.height = 100;
			vhbox.isMask = true;
			addChild(vhbox);
			vhbox.addChild(box1);
			vhbox.addChild(box2);
			vhbox.addChild(box3);
			vhbox.addChild(box4);
			vhbox.addChild(box5);
	 * @author Anlei
	 */
	public class MyHVBox extends MySprite
	{
		public static const GAP_CHANGE_EVENT:String = 'gap_change_event';
		
		public static const TYPE_V:String = 'v';
		public static const TYPE_H:String = 'h';
		
		public static const H_LEFT:String = 'left';
		public static const H_RIGHT:String = 'right';
		public static const H_CENTER:String = 'center';
		
		public static const V_TOP:String = 'top';
		public static const V_BOT:String = 'bot';
		public static const V_MID:String = 'mid';
		
		private var valign:String = V_TOP;
		private var halign:String = H_LEFT;
		
		private var type:String = TYPE_V;
		private var gap:Number = 4;
		
		private var _width:Number = 1;
		private var _height:Number = 1;
		
		public var containe:MySprite;
		private var mask_sp:Sprite;
		
		
		public function MyHVBox(_type:String = MyHVBox.TYPE_V)
		{
			type = _type;
			inits();
		}
		override public function dispose():void{
			if(containe!=null){
				containe.removeAllChild();
				containe.clearListeners();
				super.removeChild(containe);
			}
			if(mask_sp!=null){
				super.removeChild(mask_sp);
			}
			containe = null;
			mask_sp = null;
			
		}
		private function inits():void 
		{
			containe = new MySprite();
			containe.addEventListener(Event.RESIZE, onContaineResie);
			mask_sp = CreateAlphaSP(false, _width, _height,containe.x,containe.y,0x000000, 0.3);
			super.addChild(mask_sp);
			super.addChild(containe);
			isBG = false;
		}
		
		public function get maskAlpha():Number{ return mask_sp.alpha; }
		public function set maskAlpha(value:Number):void{ mask_sp.alpha = value; }
		
		private function onContaineResie(event:Event):void {
			reset();
		}
		
		public function reset():void 
		{
			sortXorY();
			switch(HAlign)
			{
				case H_LEFT:
					containe.x = 0;
					break;
				case H_RIGHT:
					containe.x = width - containe.width;
					break;
				case H_CENTER:
					containe.x = width / 2 - containe.width / 2;
					break;
			}
			
			switch(VAlign)
			{
				case V_TOP:
					containe.y = 0;
					break;
				case V_BOT:
					containe.y = height - containe.height;
					break;
				case V_MID:
					containe.y = height / 2 - containe.height / 2;
					break;
			}
			sortXorY();
		}
		private function sortXorY():void {
			for (var i:int = 0 ; i < numChildren; i++) {
				var _child:DisplayObject = getChildAt(i);
				var _pchild:DisplayObject;
				if (i > 0) {
					_pchild = getChildAt(i - 1);
				}
				var _h:Number = 0;
				var _w:Number = 0;
				if (Type == TYPE_V) {
					if (i > 0) {
						_w = _pchild.y + _pchild.height + Gap;
					}
					
					switch(HAlign)
					{
						case H_LEFT:
							_h = 0;
							break;
						case H_RIGHT:
							_h = containe.width - _child.width;
							break;
						case H_CENTER:
							_h = (containe.width - _child.width) / 2;
							break;
					}
					
					_child.x = _h;
					_child.y = _w;
				}else if (Type == TYPE_H) {
					if (i > 0) {
						_h = _pchild.x + _pchild.width + Gap;
					}
					
					switch(VAlign)
					{
						case V_TOP:
							_w = 0;
							break;
						case V_BOT:
							_w = containe.height - _child.height;
							break;
						case V_MID:
							_w = (containe.height - _child.height) / 2;
							break;
					}
					
					_child.x = _h;
					_child.y = _w;
				}
			}
		}
		/**
		 * 
		 * @param wh	= 'w' 获取Containe的宽度
		 * 		 		= 'h' 获取Containe的高度
		 * 
		 
		private function getContaineWH(wh:String = 'w'):Number{
			var _num:Number = 0;
			var _len:int = containe.numChildren;
			for(var i:int = 0 ; i < _len; i++){
				var _dod:DisplayObject = containe.getChildAt(i);
				if(wh == 'w'){
					_num += _dod.width + Gap;
				}else if(wh == 'h'){
					_num += _dod.height + Gap;
				}
			}
			return _num - Gap;
		}*/
		private function CreateAlphaSP(_mouseEnabled:Boolean,
											 $width:Number, $height:Number,
											 _x:Number = 0, _y:Number = 0,
											 _fillColor:Number = 0xFF0000,
											 _fillAlpha:Number = 1):Sprite{
			var _sp:Sprite = new Sprite();
			_sp.mouseEnabled = _mouseEnabled;
//			_sp.graphics.lineStyle(1,0,1,true);
			_sp.graphics.beginFill(_fillColor);
			_sp.graphics.drawRect(_x, _y, $width, $height);
			_sp.graphics.endFill();
			_sp.alpha = _fillAlpha;
			return _sp;
		}
		
//		public function set isMask(_onf:Boolean):void {
//			if(_onf){
//				containe.mask = mask_sp;
//			}else {
//				containe.mask = null;
//			}
//		}
		public function set isBG(_onf:Boolean):void {
			mask_sp.visible = _onf;
		}
		public function get isBG():Boolean{
			return mask_sp.visible;
		}
		
		override public function getChildAt(index:int):DisplayObject 
		{
			return containe.getChildAt(index);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			containe.addChild(child);
			reset();
			return child;
		}
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = containe.removeChildAt(index);
			reset();
			return child;
		}
		override public function removeChild(child:DisplayObject):DisplayObject{
			if(contains(child)){
				containe.removeChild(child);
				reset();
			}
			return child;
		}
		
		override public function contains(child:DisplayObject):Boolean{
			return containe.contains(child);
		}
		
		override public function removeAllChild(isDispose:Boolean = false):void {
			var len:int = containe.numChildren;
			for(var i:int = 0 ; i < len; i ++){
				var _dod:DisplayObject = containe.removeChildAt(0);
				if(_dod && isDispose && _dod.hasOwnProperty("dispose")) _dod["dispose"]();
			}
			super.removeAllChild(isDispose);
		}
		
		public function pack():void{
			_width = containe.width;
			_height= containe.height;
		}
		
		public function updateSize():void{
			mask_sp.width = width;
			mask_sp.height = height;
//			mask_sp.width = containe.width;
//			mask_sp.height = containe.height;
		}
		/*
		public function get contentWidth():Number { return getContaineWH('w'); }	
		public function get contentHeight():Number { return getContaineWH('h'); }
		*/
		override public function get width():Number { return _width; }
		override public function set width(value:Number):void  {
			_width = value;
			reset();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number { return _height; }
		override public function set height(value:Number):void {
			_height = value;
			reset();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get numChildren():int { 
			return containe.numChildren; 
		}
		
		public function get VAlign():String {
			return valign;
		}
		public function set VAlign(_str:String):void {
			valign = _str;
			reset();
		}
		
		public function get HAlign():String {
			return halign;
		}
		public function set HAlign(_str:String):void {
			halign = _str;
			reset();
		}
		
		public function get Gap():Number {
			return gap;
		}
		public function set Gap(_num:Number):void {
			gap = _num;
			reset();
			this.dispatchEvent(new Event(GAP_CHANGE_EVENT));
		}
		
		public function get Type():String
		{
			return type;
		}
		public function set Type(_type:String):void {
			type = _type;
			reset();
		}
	}

}