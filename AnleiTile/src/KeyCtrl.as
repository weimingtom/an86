package
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.role.DisposeEvent;

	public class KeyCtrl
	{
		private var away_mc:MovieClip;
		private var a_btn:SimpleButton;
		private var stage:Stage;
		public function KeyCtrl($stage:Stage)
		{
			stage = $stage;
			away_mc = new Key_Away_mc();
			a_btn = new Key_A_btn();
			away_mc.x = 10;
			away_mc.y = stage.stageHeight - away_mc.height - 10;
			
			a_btn.x = stage.stageWidth - a_btn.width - 10;
			a_btn.y = stage.stageHeight - a_btn.height - 10;
			
			away_mc.addEventListener(MouseEvent.MOUSE_DOWN, onAwayKeydown);
			a_btn.addEventListener(MouseEvent.MOUSE_DOWN, onAClick);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onAwayKeyup);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyup);
			
			stage.addEventListener(MouseEvent.MOUSE_OVER, onAddKey);
			stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
		}
		
		private function onAClick(event:MouseEvent):void {
			invateA();
		}
		
		private function onAwayKeydown(event:MouseEvent):void {
			switch(event.target.name){
				case 'up_btn':
					pressDownKey(Keyboard.UP);
					break;
				case 'down_btn':
					pressDownKey(Keyboard.DOWN);
					break;
				case 'left_btn':
					pressDownKey(Keyboard.LEFT);
					break;
				case 'right_btn':
					pressDownKey(Keyboard.RIGHT);
					break;
			}
		}
		
		private function onAwayKeyup(event:MouseEvent):void {
			switch(event.target.name){
				case 'up_btn':
					releaseUpKey(Keyboard.UP);
					break;
				case 'down_btn':
					releaseUpKey(Keyboard.DOWN);
					break;
				case 'left_btn':
					releaseUpKey(Keyboard.LEFT);
					break;
				case 'right_btn':
					releaseUpKey(Keyboard.RIGHT);
					break;
				default:
					trace("B");
					ATGame.role.left_key=false;
					ATGame.role.right_key=false;
					ATGame.role.up_key=false;
					ATGame.role.down_key=false;
					break;
			}
		}
		
		private function onAddKey(event:MouseEvent):void {
			if(!stage.contains(away_mc)){
				stage.addChild(away_mc);
			}
			if(!stage.contains(a_btn)){
				stage.addChild(a_btn);
			}
		}
		
		private function onMouseLeave(event:Event):void {
			stage.focus = stage;
			if(stage.contains(away_mc)){
				stage.removeChild(away_mc);
			}
			if(stage.contains(a_btn)){
				stage.removeChild(a_btn);
			}
		}
		
		private function releaseUpKey(code:int):void{
			switch (code) {
				case Keyboard.LEFT :
					ATGame.role.left_key=false;
					break;
				case Keyboard.RIGHT :
					ATGame.role.right_key=false;
					break;
				case Keyboard.UP :
					ATGame.role.up_key=false;
					break;
				case Keyboard.DOWN :
					ATGame.role.down_key=false;
					break;
			}
		}
		
		private function pressDownKey(code:int):void{
			switch (code) {
				case Keyboard.LEFT :
					ATGame.role.left_key = true;
					break;
				case Keyboard.RIGHT :
					ATGame.role.right_key=true;
					break;
				case Keyboard.UP :
					ATGame.role.up_key=true;
					break;
				case Keyboard.DOWN :
					ATGame.role.down_key=true;
					break;
				case Keyboard.SPACE:
					invateA();
					break;
			}
		}
		
		private function invateA():void{
			DisposeEvent.invate(ATGame.role.cartoon.currPlayRow, ATGame.role.xtile, ATGame.role.ytile);
		}
		
		private function onKeyup(event:KeyboardEvent):void {
			releaseUpKey(event.keyCode);
		}
		private function onKeydown(event:KeyboardEvent):void {
			pressDownKey(event.keyCode);
		}
		
	}
}