package net.an86.tile.peo
{
	import anlei.util.NBPage;
	import anlei.util.PublicProperty;
	
	import net.an86.tile.ATGame;
	import net.an86.ui.menu.ATMenuItem;
	import net.an86.ui.menu.IMenu;

	public class PeoManager implements IMenu
	{
		private static var _instance:PeoManager;
		public function PeoManager(signle:Signle) { inits(); }
		
		public static function getInstance():PeoManager {
			if (_instance == null)
				_instance = new PeoManager(new Signle());
			return _instance;
		}
		
		private var item:PeoItem;
		
		/**一页显示几条*/
		public static var LEN:int = 1;
		public static var ITEM_LEN:int = 3;
		
		/**选中item所要的发光滤镜*/
		private static var selectedFilter:Array;
		/**当前选中的Item的索引*/
		private var selectedIndex:int = 0;
		/**当前选中的Item*/
		private var selectedItem:ATMenuItem;
		private var nbpage:NBPage;
		private var currPage:int = 1;
		private var list:Vector.<ATMenuItem> = new Vector.<ATMenuItem>();
		
		private function inits():void {
			selectedFilter = [PublicProperty.OEffect(0xFF0000, true)];
			nbpage = new NBPage();
		}
		
		public function pop():void{
			if(item == null){
				item = new PeoItem(ATGame.roleList[0]);
				item.x = ATGame.centerx - item.width / 2;
				item.y = ATGame.centery - item.height/ 2;
			}
			
			if(!ATGame.root.contains(item)){
				ATGame.root.addChild(item);
				item.role = ATGame.roleList[0];
				ATGame.keyCtrl.currentMenu = this;
				ATGame.roleList[0].isCtrl = false;
			}else{
				removePop();
				return;
			}
			
			var _len:int = ATGame.roleList.length;
			nbpage.totalPage = Math.ceil(_len/LEN);
			if(nbpage.totalPage == 0) nbpage.totalPage = 1;
			
			fill();
		}
		
		public function removePop():void{
			if(ATGame.root.contains(item)){
				ATGame.root.removeChild(item);
				ATGame.keyCtrl.currentMenu = null;
			}
			ATGame.roleList[0].isCtrl = true;
		}
		
		private function fill():void{
			item.clear();
			list.splice(0, list.length - 1);
			selectedIndex = 0;
			list.push(item.at_bit);
			list.push(item.dp_bit);
			list.push(item.ahp_bit);
			item.role = ATGame.roleList[nbpage.currPage-1];
			setSelected();
		}
		
		private function nextPage(e:* = null):void{
			if(currPage == nbpage.totalPage) return;
			nbpage.onNext();
			fill();
			currPage = nbpage.currPage;
		}
		
		private function backPage(e:* = null):void{
			if(currPage == 1) return;
			nbpage.onBack();
			fill();
			currPage = nbpage.currPage;
		}
		
		private function setSelected():void{
			if(selectedItem != null){
				selectedItem.filters = null;
			}
			selectedItem = list[selectedIndex];
			selectedItem.filters = selectedFilter;
		}
		
		public function left():void{
			backPage();
		}
		public function right():void{
			nextPage();
		}
		public function up():void{
			selectedIndex--;
			if(selectedIndex < 0){
				selectedIndex = ITEM_LEN-1;
			}
			
			setSelected();
		}
		public function down():void{
			selectedIndex++;
			if(selectedIndex >= ITEM_LEN){
				selectedIndex = 0;
			}
			setSelected();
		}
		
		public function A():void{
			
		}
		
		public function B():void{
			removePop();
		}
		
		
		
		
	}
}
class Signle{}
