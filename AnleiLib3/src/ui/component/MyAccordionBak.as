package ui.component
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import ui.abs.AbstractComponent;

	/**
	 * 多级选项卡类
	 * 
	 * 
			myacc = new MyAccordion();
			myacc.setSize(200,150);
			myacc.addChildData(new MyTabControl(), 'anlei1', new MyCheckBox());
			myacc.addChildData(new MyBorder(), 'anlei2', new MyCheckBox());
			myacc.addChildData(new Sprite(), 'anlei3', new MyCheckBox());
			myacc.addChildData(new Sprite(), 'anlei4', new MyCheckBox());
			myacc.openItem(2);
			addChild(myacc);
	 * 
	 * 
	 * @author Anlei
	 * 
	 */	
	public class MyAccordion extends MySprite implements AbstractComponent
	{
		/**横向*/		
		public static const Layout_h:String = 'layout_h';
		/**纵向*/		
		public static const Layout_v:String = 'layout_v';
		private var _Layout:String = Layout_v;
		
		public static const H_left:String = 'h_left';
		public static const H_right:String= 'h_right';
		private var _H:String = H_left;
		
		public static const V_top:String = 'v_top';
		public static const V_bot:String = 'v_bot';
		private var _V:String = V_top;
		
		/**背景宽*/
		private var INIT_Width:Number = 100;
		/**背景高*/
		private var INIT_Height:Number = 100;
		
		/**纵向时，按钮宽*/
		public var BTN_INIT_Width_V:Number = 100;
		/**纵向时，按钮高*/
		public var BTN_INIT_Height_V:Number = 24;
		
		/**横向时，按钮宽*/
		public var BTN_INIT_Width_H:Number = 24;
		/**横向时，按钮高*/
		public var BTN_INIT_Height_H:Number = 100;
		
		/**是否不设置按钮大小*/
		public var isSetBtnWH:Boolean = false;
		
		private var index:int = -1;
		
		/** 卡存储 */		
		private var data_arr:Array = [];
		
		/** 背景图 */		
		private var bg:Sprite;
		
		/** 遮罩*/		
		private var mask_sp:Sprite;
		
		private var content_sp:Sprite;
		
		/** 背景色 */		
		private var bgColor:uint;
		
		/** 按钮样式*/		
		private var btnStyle:String;
		
		private static const SP:String = '_|_';
		public var containers:Dictionary;
		
		/**
		 * 多级选项卡类
		 * @param $bgColor	背景色
		 * @param $btnStyle	按钮样式
		 * 
		 */
		public function MyAccordion($bgColor:uint = 0xEFEBE3, $btnStyle:String = '3')
		{
			bgColor = $bgColor;
			btnStyle =$btnStyle;
			inits();
		}
		
		/**纵向时，按钮在上/下 */
		public function get V():String { return _V; }
		public function set V(value:String):void { _V = value; resetCoor(); }

		/**横向时，按钮在左/右 */
		public function get H():String { return _H; }
		public function set H(value:String):void { _H = value; resetCoor(); }

		/**横纵布局*/
		public function get Layout():String { return _Layout; }
		public function set Layout(value:String):void { _Layout = value; resetCoor(); }

		private function inits():void{
			containers = new Dictionary();
			bg = CreateAlphaSP(true, INIT_Width, INIT_Height, 0,0, bgColor, 1);
			mask_sp = CreateAlphaSP(true, INIT_Width, INIT_Height, 0, 0, 0xFF0000,1);
			content_sp = new Sprite();
			content_sp.mask = mask_sp;
			super.addChild(mask_sp);
			super.addChild(content_sp);
			content_sp.addChild(bg);
		}
		
		/** 完全移除数组中的一个节点 */
		private function removeArrayNode(inputArray:Array, removeIndex:uint):Array{
			var tem:Array = [];
			for(var i:int = 0 ; i < inputArray.length; i++){
				if(i == removeIndex){
					continue;
				}
				tem.push(inputArray[i]);
			}
			return tem;
		}
		
		/**重置坐标*/		
		private function resetCoor():void {
			var temph:Number = 0;
			var allh:Number = 0;
			for(var j:int = 0 ; j < data_arr.length; j++){
				if(Layout == Layout_v){
					allh += ItemTitle(data_arr[i]).Title_btn.height;
				}else if(Layout == Layout_h){
					allh += ItemTitle(data_arr[i]).Title_btn.width;
				}
			}
			
			for(var i:int = 0 ; i < data_arr.length; i++) {
				
				if(Layout == Layout_v){
					ItemTitle(data_arr[i]).x = 0;
					if(V == V_top){
						ItemTitle(data_arr[i]).y = temph;
					}else if(V == V_bot){
						ItemTitle(data_arr[i]).y = INIT_Height - temph;
					}
					
					temph += ItemTitle(data_arr[i]).Title_btn.height;
				}else{
					ItemTitle(data_arr[i]).y = 0;
					if(H == H_left){
						ItemTitle(data_arr[i]).x = temph;
					}else if(H == H_right){
						var _t:Number = temph;
						if(i == 0){
							_t *= 2;
						}
						ItemTitle(data_arr[i]).x = INIT_Width - _t;
					}
					
					temph += ItemTitle(data_arr[i]).Title_btn.width;
				}
				
//				ItemTitle(data_arr[i]).y = temph;
//				temph += ItemTitle(data_arr[i]).Title_btn.height;
//				
//				ItemTitle(data_arr[i]).x = 0;
//				ItemTitle(data_arr[i]).ID = i;
//				ItemTitle(data_arr[i]).width = INIT_Width;
			}
		}
		
		private function onClick(e:MouseEvent):void {
			var it:ItemTitle = ItemTitle(e.currentTarget.parent.parent);
			var id:uint = it.ID;
			openItem(id);
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
		private function onComplete():void{
			for(var j:int = 0 ; j < data_arr.length; j++){
				data_arr[j].contentChild.visible = false;
			}
			data_arr[index].contentChild.visible = true;
		}
		
		private function findTitleIndex(value:String):int{
			for(var i:int = 0; i < data_arr.length; i++){
				if(ItemTitle(data_arr[i]).Title_btn.label == value){
					return i;
				}
			}
			return -1;
		}
		
		public function setTitleAt(n:int, value:String):void{
			for(var i:int = 0; i < data_arr.length; i++){
				if(i == n){
					ItemTitle(data_arr[i]).Title_btn.label = value;
					ChildCon(containers[ItemTitle(data_arr[i]).Child]).title = value;
				}
			}
		}
		
		public function get titles():Array{
			var _arr:Array = [];
			for(var i:int = 0; i < data_arr.length; i++){
				_arr.push(ItemTitle(data_arr[i]).Title_btn.label);
			}
			return _arr;
		}
		
		public function set titles(value:Array):void{
			TweenLite.delayedCall(1, function():void{
				for (var i:int = 0; i < value.length; i++) {
					ItemTitle(data_arr[i]).Title_btn.label = value[i];
					ChildCon(containers[ItemTitle(data_arr[i]).Child]).title = value[i];
				}
			});
		}
		
		/** 更新滚动条 */		
		public function update():void{
			this.resetCoor();
		}
		private var __id:int = 0;
		private function getAddID():int{
			return ++__id;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{
			var _indexObject:Object;
			for(var _item:Object in containers){
				if(_item == child){
					_indexObject = containers[_item];
					break;
				}
			}
			if(_indexObject && ChildCon(_indexObject).title.indexOf(SP) != -1){
				var _index:int = findTitleIndex(ChildCon(_indexObject).title);
				if(_index != -1){
					setTitleAt(_index, ChildCon(_indexObject).title);
				}
			}
			
			if(!_indexObject){
				_indexObject = child;
				var _str:String = String(_indexObject);
				_str = _str.substring(_str.lastIndexOf(' ')+1, _str.length - 1) + SP + getAddID();
				containers[child] = new ChildCon(_indexObject as DisplayObject, _str);
				addChildData(_indexObject as DisplayObject, _str);
			}else{
				addChildData(ChildCon(_indexObject).con, ChildCon(_indexObject).title);
			}
			
			return child;
		}
		
		/**
		 * 添加一个选项卡
		 * @param child		内容
		 * @param label		标签
		 * @param icon		图标
		 */		
		public function addChildData(child:DisplayObject = null, label:String = "", icon:String = '', $btnSkinMc:String = ''):void
		{
			if(child == null) return;
			var it:ItemTitle = new ItemTitle(child,  $btnSkinMc, label, icon);
			data_arr.push(it);
			content_sp.addChild(it);
			it.Title_btn.width = INIT_Width;
			it.Title_btn.addEventListener(MouseEvent.CLICK, onClick);
			resetCoor();
			index = data_arr.length - 1;
			onComplete();
		}
		
		public function removeAllTab():void{
			var _len:int = data_arr.length;
			for (var i:int = 0; i < _len; i++) {
				removeChildData(0);
			}
		}
		
		/**移除选项卡
		 * @param index		ID
		 */		
		public function removeChildData(index:uint):void{
			if(index >= data_arr.length) return;
			content_sp.removeChild(data_arr[index]);
			data_arr[index].Title_btn.removeEventListener(MouseEvent.CLICK, onClick);
			data_arr[index].dispose();
			data_arr = removeArrayNode(data_arr, index);
			
			resetCoor();
		}
		
		/** 默认打开一个卡 从0开始 */		
		public function openItem(id:uint):void{
			var it:ItemTitle = ItemTitle(data_arr[id]);
			index = it.ID;
			var len:uint = data_arr.length;
			
			var _isVis:Boolean = false;
			
			if(it.isDown){
				for(var j:uint = 0 ; j < index + 1; j++){
					it = ItemTitle(data_arr[j]);
					it.isDown = false;
					TweenLite.to(it, 0.3, {y:it.Title_btn.height * it.ID, onComplete:onComplete});
					
					_isVis = true;
				}
			}else{
				for(var i:uint = index + 1; i < len; i++){
					it = ItemTitle(data_arr[i]);
					it.isDown = true;
					TweenLite.to(it, 0.3, {y:INIT_Height-(it.Title_btn.height*(len-i)), onComplete:onComplete});
					
					_isVis = true;
				}
			}
			
			if(_isVis){
				for(var v:int = 0 ; v < len; v++){
					//data_arr[v].contentChild.visible = true;
				}
			}
			
		}
		
		/** 返回当前打开的 ID */		
		public function get selectedIndex():uint{ return index; }
		public function set selectedIndex(value:uint):void{
			TweenLite.delayedCall(1, function():void{
				openItem(value);
			});
		}
		
		/**
		 * 设置标题文本对齐方式
		 * @param value	TextFieldAutoSize
		
		public function setTitleTextAlign(value:String):void
		{
			for(var i:int = 0; i < data_arr.length; i++){
				ItemTitle(data_arr[i]).align = value;
			}
		}
		 */
		
		override public function dispose():void {
			var len:int = data_arr.length;
			for(var i:int = 0 ; i < len; i++){
				removeChildData(0);
			}
			this.removeAllChild();
		}
		
		override public function get width():Number{ return bg.width; }
		override public function set width(value:Number):void{
			INIT_Width = value;
			bg.width = value;
			mask_sp.width = value;
			resetCoor();
		}
		
		override public function get height():Number{ return bg.height; }
		override public function set height(value:Number):void {
			INIT_Height = value;
			bg.height = value;
			mask_sp.height = value;
			resetCoor();
		}
		
		public function setSize(_width:Number, _height:Number):void {
			width = _width;
			height = _height;
		}
		
		public function move(_x:Number, _y:Number):void
		{
			this.x = _x;
			this.y = _y;
		}
		
		
	}
}
import flash.display.DisplayObject;
import flash.display.Sprite;

import ui.component.MyButton;
import ui.component.MySprite;

class ItemTitle extends MySprite
{
	private var title_sp:Sprite = new Sprite();//标题组
	public var Title_btn:MyButton;//标题按钮
	public var Child:DisplayObject;//显示内容
	
	public var isDown:Boolean = false;//是否在下方 true(在上方) false(在下方)
	
	public var ID:int = -1;
	/**
	 * 单个选项卡
	 * @param bg		背景
	 * @param child		子级内容
	 * @param label		标签
	 * @param icon		图标
	 * 
	 */	
	public function ItemTitle(child:DisplayObject, $btnStyle:String, label:String, icon:String)
	{
		Child = child;
		Title_btn = new MyButton(label);
		if($btnStyle && $btnStyle.length > 0){
			Title_btn.setStyle($btnStyle);
		}
		
		Title_btn.icon = icon;
		
		inits();
	}
	
	private function inits():void {
		title_sp.addChild(Title_btn);
		
		addChild(Child);
		addChild(title_sp);
		
		//Child.x = 10;
		Child.y = Title_btn.height;
	}
	/**
	 * 释放资源
	 */	
	override public function dispose():void{
		
		title_sp.removeChild(Title_btn);
		
		removeChild(Child);
		removeChild(title_sp);
		
		Title_btn.dispose();
		
		Title_btn = null;
		Child = null;
	}
	
	/** 设置内容的宽高	
	public function setChildSize(_width:Number, _height:Number):void {
		Child.width = _width
		Child.height= _height;
	} */
	/** 设置标题的宽度 
	public function setTitleWidth(_width:Number):void {
		Title_btn.width = _width;
	}*/	
	/** 获取标题按钮的高度
	public function get titleHeight():Number{
		return Title_btn.height;
	} */
	
	public function get contentChild():DisplayObject{
		return Child;
	}
}

import flash.display.DisplayObject;

class ChildCon{
	public var con:DisplayObject;
	public var title:String;
	
	public function ChildCon($con:DisplayObject, $title:String){
		con = $con;
		title = $title;
	}
}