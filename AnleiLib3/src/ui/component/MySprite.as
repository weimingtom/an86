package ui.component
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.abs.ToolTip;

	public class MySprite extends Sprite
	{
		protected var _dataCustom:Object = {};
		
		private var _tip:ToolTip;
		private var listeners:Array;
		
		private var _drag:MyDrag;
		
		private var _isDrag:Boolean;
		private var _isAccept:Boolean;
		
		public function MySprite() {
			
		}
		
		/**自定义变量*/
		public function get dataCustom():Object { return _dataCustom; }
		public function set dataCustom(value:Object):void { _dataCustom = value; }

		public function get enabled():Boolean{
			if(!mouseChildren && !mouseEnabled) return false;
			return true;
		}
		public function set enabled(value:Boolean):void{
			mouseChildren = value;
			mouseEnabled = value;
		}
		
		public function get isAccept():Boolean{ return _isAccept; }
		public function set isAccept(value:Boolean):void {
			_isAccept = value;
			/*if(isAccept){
				addEventListener(MyDragEvent.DRAG_COMPLETE, onAccept);
			}*/
		}
		
		/*protected function onAccept(event:MyDragEvent):void {
			trace('accept:', this, 'sender', event.sender);
		}*/
		

		public function get isDrag():Boolean { return _isDrag; }
		public function set isDrag(value:Boolean):void {
			_isDrag = value;
			if(isDrag){
				_drag = new MyDrag(this);
			}else{
				if(_drag){
					_drag.dispose();
					_drag = null;
				}
			}
		}
		
		public function setAcceptType(type:String):void
		{
			_drag._targetType = type;
		}
		
		public function setDragIcon(dod:DisplayObject):void{
			if(_drag)
				_drag.setDragIcon(dod);
		}

		public function dispose():void{
			dataCustom = null;
			clearListeners();
			removeAllChild();
		}
		
		
		/**
		 * String 或 DisplayObject 
		 * @param _obj
		 */		
		public function set toolTip(_obj:*):void {
			if(_obj != null && _obj != ''){
				if(_tip == null){
					_tip = ToolTip.getInstance();
					Entrance.getInstance().Root.addChild(_tip);
				}
				_tip.dispose();
				_tip.setTip(0xE8E8E8,0xFFFFFF, _obj);
			}else{
				if(_tip != null){
					_tip.dispose();
				}
			}
			
		}
		
		/**清除所有侦听事件*/
        public function clearListeners():void {
			if(listeners){
				for (var i:int = 0 ; i < this.listeners.length ; i++) {
					this.removeEventListener(this.listeners[i]["Type"], this.listeners[i]["Listener"]);
				}
			}
			listeners = null;
			toolTip = null;
        }
        
        public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakPeference:Boolean = false):void {
			if(!listeners) listeners = [];
			listeners.push({Type:type, Listener:listener});
			super.addEventListener(type, listener, useCapture, priority, useWeakPeference);
        }
		
        /** 移除所有子级 */
		public function removeAllChild(isDispose:Boolean = false):void {
			var _len:int = this.numChildren;
			for (var i:int = 0; i < _len; i ++) {
				var _dod:DisplayObject = removeChildAt(0);
				if(_dod && isDispose && _dod.hasOwnProperty("dispose")) _dod["dispose"]();
			}
			toolTip = null;
		}
		
		
		override public function get width():Number{ return super.width}
		override public function set width(value:Number):void{
			super.width = value;
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number{ return super.height; }
		override public function set height(value:Number):void{
			super.height = value;
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
	}
}
