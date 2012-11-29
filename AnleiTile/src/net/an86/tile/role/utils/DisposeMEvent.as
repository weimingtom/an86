package net.an86.tile.role.utils
{
	import com.D5Power.mission.EventData;
	import com.greensock.TweenLite;
	
	import net.an86.tile.menu.ShopMenu;
	import net.an86.ui.alert.Alert;
	import net.an86.ui.menu.ATMenu;
	import net.an86.tile.menu.ATMenuConfig;

	public class DisposeMEvent
	{
		private static var eventData:EventData;
		private static var shopMenu:ShopMenu;
		
		public static function dispose(value:EventData):void {
			eventData = value;
			switch(eventData.type){
				case MEventConfig.SHOP:
					if(!shopMenu){
						shopMenu = new ShopMenu(ATMenuConfig[MEventConfig.SHOP + eventData.value]);
					}
					shopMenu.pop();
					break;
			}
		}
		
	}
}