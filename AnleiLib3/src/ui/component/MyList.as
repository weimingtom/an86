package ui.component
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import fl.controls.List;
	import fl.data.DataProvider;
	
	import ui.abs.AbstractComponent;
	import ui.skin.MyListSkin;
	
	
	public class MyList extends List implements AbstractComponent
	{
		public function MyList()
		{
			setStyle("skin", Sprite);
			_verticalScrollBar.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			TweenLite.delayedCall(0.1, setSkin);
		}
		public function setSkin():void{
			try{
				MyListSkin.set(this);
			}catch(e:*){
				trace("MyListSkin.set(this);");
			}
		}
		
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
			onAddToStage();
		}
		
		public function clearData():void{
			dataProvider.removeAll();
		}
		
		////////////////////////////
		public function dispose():void {
			
		}
	}
}