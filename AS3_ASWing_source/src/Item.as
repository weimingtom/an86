package
{
	import flash.text.TextField;
	
	import org.aswing.Component;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.ListCell;
	
	public class Item implements ListCell
	{
		private var panel:Component;
		private var data:Object;
		private var lab:TextField;
		private var btn:JButton;
		
		public function Item()
		{
			super();
			panel = new Component();
			
			lab = new TextField();
			lab.width = 55;
			lab.height = 22;
			panel.addChild(lab);
			
			btn = new JButton("OK");
			btn.setSizeWH(55, 22);
			btn.setLocationXY(56, 0);
			btn.addActionListener(function(e:*):void{
				trace(data.label, data.data);
			});
			panel.addChild(btn);
		}
		
		public function setListCellStatus(list:JList, isSelected:Boolean, index:int):void
		{
		}
		
		public function setCellValue(value:*):void
		{
			data = value;
			lab.text = String(value.label + ',' + value.data);
		}
		
		public function getCellValue():*
		{
			return data;
		}
		
		public function getCellComponent():Component
		{
			return panel;
		}
	}
}