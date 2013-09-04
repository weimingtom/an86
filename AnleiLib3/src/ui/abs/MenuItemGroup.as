package ui.abs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.component.MyHVBox;

	/**
	* 菜单组合类
	* @author Anlei
	*/
	public class MenuItemGroup extends Sprite{
		
		private var hvbox:MyHVBox;
		
		private var btn_arr:Array = [];
		
		private var bg:Sprite; 
		
		/**
		 * XML数据
		 * @param xml
		 */
		public function MenuItemGroup(xml:XML, $style:String = '', bgroup:Class = null, $width:Number = 100, $height:Number = -1){
			
			hvbox = new MyHVBox();
			hvbox.Gap = 0;
			
			
			for(var i:int = 0 ; i <xml.item.length(); i++){
				
				var label:String = xml.item[i].@label;
				var data:String = xml.item[i].@data;
				
				var nextItemLength:int = xml.item[i].item.length();
				
				if(nextItemLength>0){
					label += " ->";
				}
				
				var item:MenuItem = new MenuItem(label, data, $style, $width, $height);
				item.ID = i;
				
				/**
				 * 如果xml有子子点，那么设定Node为子节点，并创建菜单组合类
				 */ 
				if(nextItemLength>0){
					item.Node = xml.item[i];
					item.nextGroup = new MenuItemGroup(item.Node, $style, bgroup);
				}
				
				btn_arr.push(item);
				
				hvbox.addChild(item);
				
				
				item.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				
			}
			
			
			if(bgroup != null){
				bg = new bgroup() as Sprite;
				addChild(bg);
				bg.width = item.width+10;
				bg.height= hvbox.containe.height+10;
			}
			
			hvbox.x = hvbox.y = 5;
			addChild(hvbox);
		}
		private function onOver(e:MouseEvent):void{
			var item:MenuItem = e.currentTarget as MenuItem;
			if(item != null && item.isUse){
				//item.mouseEnabled = false;
				closeItem(item.ID);
				item.displayGroup();
			}
		}
		/**
		 * 关闭所有，其中被over的自己不被关闭
		 * @param id
		 */	
		private function closeItem(id:int):void{
			for(var i:int = 0 ; i < btn_arr.length; i ++){
				var item:MenuItem = btn_arr[i] as MenuItem;
				if(i == id) continue;
				item.removeGroup();
			}
		}
		/**
		 * 关闭所有
		 */	
		public function allClose():void{
			if(btn_arr != null){
				for(var i:int = 0 ; i < btn_arr.length; i ++){
					var item:MenuItem = btn_arr[i] as MenuItem;
					item.removeGroup();
				}
			}
		}
		/**
		 * 释放资源
		 */	
		public function dispose():void{
			removeChild(hvbox);
			hvbox.dispose();
			for(var i:int = 0 ; i < btn_arr.length; i++){
				var _item:MenuItem = MenuItem(btn_arr[i]);
				_item.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				_item.dispose();
			}
			btn_arr = null;
			if(bg != null){
				addChild(bg);
				removeChild(bg);
			}
		}
		public function getButtonArray():Array{
			return btn_arr;
		}
	}
}