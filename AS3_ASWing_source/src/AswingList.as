package {
	import componetset.IconListCell;
	import componetset.Tree;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import org.aswing.AsWingManager;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.Insets;
	import org.aswing.JFrame;
	import org.aswing.JList;
	import org.aswing.JScrollPane;
	import org.aswing.JTabbedPane;
	import org.aswing.VectorListModel;
	import org.aswing.border.EmptyBorder;

	public class AswingList extends Sprite
	{
		public static var WINDOW:JFrame;
		private var tabpane:JTabbedPane=new JTabbedPane;
		private var tabList:JList;
		public function AswingList()
		{
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			
			AsWingManager.setRoot(this);
			
			var arr:Array = new Array();
	        var str:String = "A long String with many many many many A long String with many many many many many chars!!!";
	        for(var i:int=0; i<40; i++){
	            var startI:Number = Math.floor(Math.random()*40);
	            var length:Number =  Math.floor(Math.random()*(str.length - startI));
	            arr.push(i + " " + str.substr(startI, length));
	        }
	        
	        var listData:VectorListModel = new VectorListModel(arr);
			var list:JList=new JList(listData,new GeneralListCellFactory(IconListCell,true,true));
			
			tabpane.append(new JScrollPane(list));
			tabpane.append(new Tree());
			
			WINDOW=new JFrame(this);			
		
			WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
			WINDOW.setContentPane(tabpane);
			WINDOW.setSizeWH(300, 500);
			WINDOW.show();
		}
	}
}
