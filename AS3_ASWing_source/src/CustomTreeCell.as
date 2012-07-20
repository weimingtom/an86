package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	import org.aswing.tree.DefaultMutableTreeNode;
	import org.aswing.tree.DefaultTreeCell;
	
	public class CustomTreeCell extends DefaultTreeCell
	{
		private var loader:Loader;
		private var url:String='';
		private var face:Sprite= null;
		
		public function CustomTreeCell()
		{
			super();
			loader = new Loader();
			addChild(loader);
		}
		override public function setCellValue(value:*):void{
			super.setCellValue(value);
			var _vo:DefaultMutableTreeNode = value as DefaultMutableTreeNode;
			if(_vo && _vo.getUserObject()){
				switch(_vo.getUserObject()['data']){
					case "1000":
						if(url==''){
							url = "images/de/A1.jpg"; 
							loader.load(new URLRequest(url));
						}
						break;
					case "2000":
						if(url==''){
							url = "images/de/B1.jpg";
							loader.load(new URLRequest(url));
						}
						break;
				}
			}
		}
	}
}