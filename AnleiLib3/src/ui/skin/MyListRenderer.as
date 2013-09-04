package ui.skin
{
	import fl.controls.listClasses.CellRenderer;
	
	public class MyListRenderer extends CellRenderer
	{
		public function MyListRenderer()
		{
			super();
			MyComboBoxSkin.setTextStyle(textField);
		}
	}
}