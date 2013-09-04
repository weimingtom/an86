package ui.component
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import Events.GlobalEvent;
	
	import ui.abs.AbstractComponent;
	import ui.abs.MenuItem;
	import ui.abs.MenuItemGroup;
	import ui.abs.RemoveThis;

	/**
	 * 竖型菜单类
	 * 
	 *  var xml:XML = 
				<menu>
					<item label="AA" data="0" />
					<item label="BB" data="1" />
				</menu>
		var menu:MyDropMenu = new MyDropMenu(xml);
		menu.addEventListener(MyDropMenu.DROPMENU_CLICK, function(e:*):void{
			trace(e.OBJECT.label,e.OBJECT.data);
		});
		menu.move(200,200);
		addChild(menu);
		menu.pop();
		
		//释放资源
		if(menu != null){
			removeChild(menu);
			menu.dispose();
			menu = null;
		}
	
	 * 
	 * 
	 * 
	 * @author Anlei
	 * 
	 */	
	public class MyDropMenu extends MySprite implements AbstractComponent
	{
		/**
		 * 单击时发出的事件
		 */		
		public static const DROPMENU_CLICK:String = "drop_menu_click";
		/**
		 * 移除菜单时发出的事件
		 */		
		public static const DROPMENU_EMPTY_CLICK:String = "drop_menu_empty_click";
		
		private var data:XML;
		/**
		 * 默认一个主菜单组合类
		 */		
		private var mig:MenuItemGroup;
		
		/**
		 * 是否找到该类的顶部(用于在舞台上移除自己本身)
		 */
		private var removeThis:RemoveThis;
		
		/**
		 * 按钮样式
		 */		
		private var btnStyle:String = '';
		private var selected_obj:Object;
		
		/** 鼠标与菜单的X轴方向距离  */		
		public var mouseOffsetX:int = 4;
		/** 鼠标与菜单的Y轴方向距离  */	
		public var mouseOffsetY:int = 4;
		
		/**
		 * 竖型菜单类
		 * @param xml			xml数据
		 * @param _btnStyle		按钮样式
		 * @param backgroup		背景类，每层菜单都会创建相同的背景
		 * 
		 */		
		public function MyDropMenu(xml:XML,  $style:String = '', backgroup:Class = null, $width:Number = 100, $height:Number = 24)
		{
			data = xml;
			mig = new MenuItemGroup(data, $style, backgroup, $width, $height);
			
			mig.addEventListener(MouseEvent.CLICK, onDrop);
			
			removeThis = new RemoveThis(mig, function():void{
				mig.allClose();
				addChild(mig);
				removeChild(mig);
				dispatchEvent(new Event(MyDropMenu.DROPMENU_EMPTY_CLICK));
			});
			
		}
		/**
		 * 找到MenuItem类，并把该类里的数据发送事件给自己，便于外部对象侦听
		 * @param e
		 * 
		 */		
		private function onDrop(e:MouseEvent):void{
			
			var obj:MenuItem = e.target.parent as MenuItem;
			
			if(obj != null && obj.Node == null){
				
				this.dispatchEvent(new GlobalEvent(MyDropMenu.DROPMENU_CLICK, {label:obj.Label, data:obj.Data, target:selected_obj} ));
				
				mig.allClose();
				
			}
		}
		
		/**
		 * 递归去找每个节点与data相同的MenuItem
		 * @param _group	菜单组
		 * @param data		XML里定义的数据
		 * @return 			MenuItem
		 * 
		 */		
		private function loopGetItem(_group:MenuItemGroup, data:String):MenuItem{
			var len:int = _group.getButtonArray().length;
			var _item:MenuItem;
			for(var i:int = 0 ; i < len; i++){
				_item = _group.getButtonArray()[i] as MenuItem;
				if(_item.Data == data){
					return _item;
				}
				if(_item.Node!=null){
					return loopGetItem(_item.nextGroup, data);
				}
			}
			return null;
		}
		/**
		 * 递归去找每个节点与的按钮，并设置可用性
		 * @param _group	菜单组
		 * @param value		Boolean(true/false)
		 * 
		 */		
		private function loopSetItemEnabled(_group:MenuItemGroup, value:Boolean):void{
			var len:int = _group.getButtonArray().length;
			for(var i:int = 0 ; i <len; i++){
				var _item:MenuItem = _group.getButtonArray()[i] as MenuItem;
				_item.isUse = value;
				if(_item.Node != null){
					loopSetItemEnabled(_item.nextGroup, value);
				}
			}
		}
		/**
		 * 设置全部菜单按钮的可用性
		 * @param value		true/false
		 * 
		 */		
		public function setAllItemEnabled(value:Boolean):void{
			loopSetItemEnabled(mig, value);
		}
		/**
		 * 弹出菜单
		 */		
		public function pop($selected:Object = null):void{
			selected_obj = $selected;
			addChild(mig);
			if(x < 0){
				x = 0;
			}
		}	
		public function removePop():void{
			addChild(mig);
			removeChild(mig);
		}
		public function getItem(data:String = "0"):MenuItem{
			return loopGetItem(mig, data);
		}
		
		override public function dispose():void
		{
			removeThis.dispose();
			removeThis = null;
			mig.removeEventListener(MouseEvent.CLICK, onDrop);
			mig.dispose();
		}
		
		public function setSize(_width:Number, _height:Number):void
		{
		}
		
		public function move(_x:Number, _y:Number):void
		{
			this.x = _x;
			this.y = _y;
			var stage:Stage = Layers.Root.stage;
			var bound:Rectangle = getBounds(stage);
			
			if (bound.right > stage.stageWidth - 10)
				this.x -= bound.right - stage.stageWidth + 10;
			
			if (bound.bottom > stage.stageHeight - 10)
				this.y -= bound.bottom - stage.stageHeight + 10;
		}
	}
}
