package net.an86.tile.menu
{
	import net.an86.ui.alert.AlertDesction;
	import net.an86.ui.menu.ATMenu;
	
	public class ShopMenu extends ATMenu
	{
		public function ShopMenu($data:XML)
		{
			selecting = onSelecting;
			this.ITEM_CLASS = ShopMenuItemData;
			super($data);
		}
		
		private function onSelecting():void{
			var _s:String = this.selectedItem.data.desc;
			if(!_s) _s = 'null';
			AlertDesction.show(_s);
		}
		
		override public function A():void{
			
		}
		
		override public function B():void{
			super.B();
			AlertDesction.hide();
		}
		
	}
}