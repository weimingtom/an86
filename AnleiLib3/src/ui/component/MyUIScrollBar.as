package ui.component
{
	import flash.text.TextField;
	
	import fl.controls.UIScrollBar;
	
	import ui.skin.MyScrollBarSkin;
	
	public class MyUIScrollBar extends UIScrollBar
	{
		
		public function MyUIScrollBar()
		{
			super();
			MyScrollBarSkin.set(this);
		}
		
		/**让滚动条滚到最低*/
		public function toBot():void{
			var textField:TextField = this.scrollTarget as TextField;
			if(textField){
				textField.scrollV = textField.maxScrollV;
				update();
			}
		}
		
	}
}