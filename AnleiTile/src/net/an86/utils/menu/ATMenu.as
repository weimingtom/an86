package net.an86.utils.menu
{
	import anlei.util.NBPage;
	import anlei.util.PublicProperty;
	
	import flash.display.Sprite;
	
	import net.an86.tile.ATGame;
	
	import ui.abs.MenuItem;

	public class ATMenu extends Sprite implements IMenu
	{
		private static var LEN:int = 6;
		
		private var selectedIndex:int = 0;
		private var selectedItem:ATMenuItem;
		
		private var nbpage:NBPage;
		public var currPage:int = 1;
		
		private var list:Vector.<ATMenuItem> = new Vector.<ATMenuItem>();
		private var _data:XML;
		private var selectedFilter:Array;
		
		public function ATMenu($data:XML)
		{
			nbpage = new NBPage();
			selectedFilter = [PublicProperty.OEffect(0xFF0000, true)];
			data = $data;
		}

		public function get data():XML { return _data; }
		public function set data(value:XML):void {
			_data = value;
			if(data){
				var _len:int = data.children().length();
				if(_len < LEN){
					LEN = _len;
				}
				nbpage.totalPage = Math.ceil(_len/LEN);
				if(nbpage.totalPage == 0) nbpage.totalPage = 1;
				for (var i:int = 0; i < _len; i++) 
				{
					var _tile:ATMenuItem = new ATMenuItem();
					var _vo:ItemData = new ItemData();
					_vo.id = data.children()[i].@id;
					_vo.label = data.children()[i].@label;
					if(data.children()[i].hasOwnProperty('@data') && data.children()[i].@data){
						_vo.data = data.children()[i].data;
					}
					_tile.data = _vo;
					list.push(_tile);
				}
				fill();
			}else{
				clear();
				list.splice(0, list.length);
			}
		}
		
		private function clear():void{
			if(list.length <= 0) return;
			for(var i:int = 0 ; i < list.length; i++){
				if(this.contains(list[i])){
					this.removeChild(list[i]);
				}
			}
		}

		private function fill():void{
			clear();
			if(list.length <= 0) return;
			selectedIndex = (nbpage.currPage - 1) * LEN;
			for(var i:int = selectedIndex, j:int = 0 ; i < nbpage.currPage * LEN + 1, j < LEN; i++, j++){
				if(i < list.length){
					this.addChild(list[i]);
					list[i].y = j * list[i].height;
				}
			}
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
			if(selectedIndex < LEN*currPage-LEN){
				selectedIndex = LEN*currPage-1;
			}
			if(selectedIndex > list.length){
				selectedIndex = list.length - 1;
			}
			setSelected();
		}
		public function down():void{
			selectedIndex++;
			if(selectedIndex >= LEN*currPage){
				selectedIndex = LEN*currPage-LEN;
			}
			if(selectedIndex >= list.length){
				selectedIndex = LEN*currPage-LEN;
			}
			setSelected();
		}
		
		public function A():void{
			
		}
		
		public function B():void{
			
		}
		
		public function pop():void{
			ATGame.root.addChild(this);
			x = (ATGame.root.stage.stageWidth - width)/2;
			y = (ATGame.root.stage.stageHeight- height)/2;
			ATGame.keyCtrl.currentMenu = this;
		}
		public function removePop():void{
			if(ATGame.root.contains(this)){
				ATGame.root.addChild(this);
			}
			ATGame.keyCtrl.currentMenu = null;
		}

	}
}