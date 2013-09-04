package ui.component
{
	import Events.GlobalEvent;
	
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 *		var _pu:MyPopUpButton = new MyPopUpButton();
			_pu.addItem(b1);
			_pu.addItem(b2);
			_pu.addItem(b3);
			_pu.addItem(b4);
			_pu.setPop(b4); 
	 * 
	 */	
	public class MyPopUpButton
	{
		/**
		 * 是否有选中按钮
		 */		
		public static const SELECTED:String = 'selected';
		
		private var _isPop:Boolean = false;
		private var data_obj:Object;//对象暂存
		private var sele_obj:InteractiveObject;//
		private var curr_str:String;
		/**选中的效果*/
		private var Filter:GlowFilter;
		
		/**是否要在取消选中时把该对象释放。*/
		public var DisposeOnf:Boolean = false;
		
		public function MyPopUpButton(_ispop:Boolean = false, _filter:GlowFilter = null)
		{
			isPop = _ispop;
			Filter = _filter;
			data_obj = {};
		}
		private function onClick(e:MouseEvent):void{
			var _currbtn:InteractiveObject = InteractiveObject(e.target);
			if(isPop){
				//弹起
				if(_currbtn == sele_obj){
					reset(true);
					sele_obj = null;
					return;
				}
			}
			setPop(_currbtn);
		}
		/****-----------公有属性--------------****/
		/**
		 * 添加参与单选的按钮或剪辑
		 * **/
		public function addItem(_btn:InteractiveObject):void{
			/**
			 * 可能没有使用到setpop方法，因为 curr_str 没有初始值（为"")
			 * 所以每次都要将该属性赋值。
			 * **/
			curr_str = _btn.name;
			data_obj[_btn.name] = _btn;
			_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		public function removeItem(_btn:InteractiveObject):void{
			reset(true);
			data_obj[_btn.name].removeEventListener(MouseEvent.CLICK, onClick);
			data_obj[_btn.name] = null;
		}
		public function get CurrItem():InteractiveObject{
			return data_obj[curr_str];
		}
		public function get CurrName():String{
			return curr_str;
		}
		public function set CurrName(_str:String):void{
			curr_str = _str;
		}
		/**
		 * 当前选中的状态被外部，reset(true) 后，会残留可弹起的当前选中的对象，
		 * 所以在reset(true)，也就是重置为不选中状态后，调用该方法。
		 */		
		public function removeCurrSelected():void{
			sele_obj = null;
		}
		/**
		 * 设置初始被选中的按钮
		 * */
		public function setPop(_btn:InteractiveObject):void{
			
			sele_obj = _btn;
			
			/**将之前选中的恢复可点击状态，*/
			reset(true);
			
			curr_str = _btn.name;
			
			/**最后一次点击的状态改变。*/
			reset(false);
		}
		/**
		 * 将之前选中的恢复可点击状态，
		 * 并把最后一次点击的状态改变。
		 * setpop(onf)
		 * */
		public function reset(_onf:Boolean):void{
			var _do:InteractiveObject = InteractiveObject(data_obj[curr_str]);
			if(_do == null) return;
			if(_onf){
				_do.alpha = 1;
				_do.mouseEnabled = true;
				_do.filters = null;
				_do.dispatchEvent(new GlobalEvent(SELECTED, false));
				if(DisposeOnf){
					var _dispose:Function = _do['dispose'];
					if(_dispose != null){
						_dispose();
					}
				}
			}else{
				if(Filter==null){
					_do.alpha = 0.8;
				}
//				_do.mouseEnabled = isPop;
				if(Filter==null){
					_do.filters = null;
				}else{
					_do.filters = [Filter];
				}
				_do.dispatchEvent(new GlobalEvent(SELECTED, true));
			}
		}
		/**
		 * 释放
		 **/
		public function dispose():void{
			reset(true);
			for(var obj:* in data_obj){
				InteractiveObject(data_obj[obj]).removeEventListener(MouseEvent.CLICK, onClick);
			}
			obj = null;
			data_obj = {};
			curr_str = '';
		}
		/****---------------------****/
		/**再次点击是否可弹起*/
		public function set isPop(_onf:Boolean):void{
			_isPop = _onf;
		}
		public function get isPop():Boolean{
			return _isPop;
		}
		/**选中的效果**/
		public function set Func(_fn:Function):void{
			Filter = _fn();
		}
	}
}