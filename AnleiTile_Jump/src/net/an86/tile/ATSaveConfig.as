package net.an86.tile
{
	import net.an86.ui.menu.ATMenuItemData;

	public class ATSaveConfig
	{
		public static const BAG_LEN:int = 50;
		
		public static var glod:Number = 500000;
		public static var bagItemList:Vector.<ATMenuItemData> = new Vector.<ATMenuItemData>();
		//购物累加数
		public static var addID:int = 1;
		
		public static function indexOf_bag($id:int):int
		{
			for (var i:int = 0; i < bagItemList.length; i++) 
			{
				if(bagItemList[i].id == $id){
					return i;
				}
			}
			return -1;
		}
		
		
		public static function getAddID():int {
			return addID++;
		}
		
	}
}