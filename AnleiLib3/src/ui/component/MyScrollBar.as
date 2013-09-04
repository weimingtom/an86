package ui.component
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	
	import ui.abs.AbstractComponent;
	import ui.skin.MyScrollBarSkin;
	
	/****
	 *
	 * var _sb:MyScrollBar = new MyScrollBar();
			_sb.move(200, 200);
			_sb.source = _txt.UI;//PublicProperty.CreateAlphaSP(false, 200, 200, 0, 0, 0xff0000, 0.5);
			addChild(_sb);
	 *  ****/
	public class MyScrollBar extends ScrollPane implements AbstractComponent
	{
		/**是否让滚动条滚到最低*/
		public var isToBot:Boolean = false;
		
		public var isChangeSkin:Boolean = false;
		
		public function MyScrollBar() {
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			setStyle("upSkin", Sprite);
			_verticalScrollBar.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			TweenLite.delayedCall(0.1, setSkin);
			vToBot();
			isChangeSkin = true;
		}
		
		/**是否让滚动条滚到最低*/
		public function vToBot():void{
			if(isToBot){
				_verticalScrollBar.scrollPosition = _verticalScrollBar.maxScrollPosition;
			}
		}
		
		public function setSkin():void{
			MyScrollBarSkin.set(_verticalScrollBar);
		}
		override public function update():void{
			//if(source && content && contentClip.numChildren > 0){
				TweenLite.delayedCall(1, onComplete);
			//}
			//if(source) super.update();
		}
		
		override public function set source(arg0:Object):void{
			if(arg0){
				arg0.addEventListener(Event.RESIZE, onComplete);
			}else{
				if(source) source.removeEventListener(Event.RESIZE, onComplete);
			}
			super.source = arg0;
		}
		
		private function onComplete(e:Event = null):void{
			if(source){
				if(e == null) super.update();
				else update();
			}
		}
		
		public function dispose():void{
			
		}
		
	}
}