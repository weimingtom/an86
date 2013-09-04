package ui.component
{
	import com.greensock.TweenLite;
	
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import ui.UIConfig;
	import ui.abs.AbstractComponent;
	import ui.skin.MyComboBoxSkin;
	import ui.skin.MyListSkin;
	import ui.skin.MyScrollBarSkin;
	
	/**用法
	*/
	public class MyComboBox extends ComboBox implements AbstractComponent
	{
		private var _rowHeight:Number = -1;
		
		public function MyComboBox(){
			//this.rowCount = 3;
			this.dropdown.verticalScrollBar.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			MyComboBoxSkin.set(this);
		}
		
		private function onAddToStage(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			TweenLite.delayedCall(0.1, setSkin);
		}
		
		private function setSkin():void{
			MyListSkin.set(dropdown);
			if(_rowHeight > 0){
				dropdown.rowHeight = rowHeight;
			}
		}
		
		public function get rowHeight():Number{ return _rowHeight;}
		public function set rowHeight(value:Number):void{ _rowHeight = value; }
		
		public function get data():Array {
			return dataProvider.toArray();
		}
		
		public function set data(value:Array):void{
			if(value){
				if(!dataProvider){
					dataProvider = new DataProvider(value);
				}else{
					clearData();
					dataProvider.merge(value);
				}
			}else{
				clearData();
			}
		}
		
		override public function set width(arg0:Number):void{ super.width = arg0; MyComboBoxSkin.setInputFormat(this); }
		override public function set height(arg0:Number):void{ super.height = arg0; MyComboBoxSkin.setInputFormat(this); }
		
		override public function get selectedIndex():int { return super.selectedIndex; }
		
		public function clearData():void{
			dataProvider.removeAll();
		}
		
		////////////////////////////
		public function dispose():void {
			
		}
		
	}
}