package ui.abs
{
	import flash.display.Sprite;
	
	import anlei.util.AnleiFilter;
	
	import ui.component.MyButton;
	
	/**
	 * 单个菜单按钮
	 * @author Anlei
	 * 
	 */
	public class MenuItem extends Sprite
	{
		/**
		 * 子菜单组
		 */	
		public var nextGroup:MenuItemGroup;
		/**
		 * 子菜单XML节点
		 */	
		private var _node:XML;
		
		public var ID:uint = 0;
		/**
		 * 弹出菜单
		 */	
		public var isPop:Boolean = false;
		/**
		 * XML里的label
		 */	
		private var $label:String;
		/**
		 * XML里的data
		 */	
		public var Data:String;
		/**
		 * 初始宽度
		 */	
		private var init_width:Number;
		
		private var btn:MyButton;
		
		public function MenuItem(label:String='', data:String = '', $style:String = '', $width:Number = -1, $height:Number = -1){
			btn = new MyButton(label);
			if($style) btn.setStyle($style);
			if($width > 0) btn.width = $width;
			if($height> 0) btn.height= $height;
			addChild(btn);
			init_width = this.width;
			Label = label;
			Data = data;
			btn.textField.format.bold = false;
			btn.fontSize = 12;
		}
		public function set isUse(onf:Boolean):void{
			btn.mouseEnabled = onf;
			if(onf){
				AnleiFilter.setRgbColor(btn);
			}else{
				AnleiFilter.setNotColor(btn);
			}
		}
		public function get isUse():Boolean{
			return btn.mouseEnabled;
		}
		public function set Label(value:String):void{
			$label = value;
			btn.label = value;
		}
		public function get Label():String{
			return $label;
		}
		/**
		 * 子菜单节点数据
		 * @param value
		 * 
		 */	
		public function set Node(value:XML):void{
			_node = value;
		}
		public function get Node():XML{
			return _node;
		}
		
		/**
		 * 当有子节点数据时，可显示子菜单
		 */	
		public function displayGroup():void{
			if(nextGroup != null){
				nextGroup.x = init_width;
				addChild(nextGroup);
				isPop = true;
			}
		}
		/**
		 * 隐藏子菜单
		 */	
		public function removeGroup():void{
			if(nextGroup != null){
				addChild(nextGroup);
				removeChild(nextGroup);
				nextGroup.allClose();
				isPop = false;
			}
		}
		
		public function dispose():void{
			removeChild(btn);
			btn.dispose();
			Node = null;
			if(nextGroup!=null) nextGroup.dispose();
		}
	}
}
