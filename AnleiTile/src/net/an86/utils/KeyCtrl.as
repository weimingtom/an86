package net.an86.utils
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
	import net.an86.tile.role.utils.IntaveEvent;
	import net.an86.ui.alert.Alert;
	import net.an86.ui.menu.IMenu;

	public class KeyCtrl
	{
		private var away_mc:MovieClip;
		private var a_btn:SimpleButton;
		private var b_btn:SimpleButton;
		private var stage:Stage;
		
		public var currentMenu:IMenu;
		
		
		private var bag_btn:SimpleButton;
		private var peo_btn:SimpleButton;
		private var sys_btn:SimpleButton;
		
		public function KeyCtrl($stage:Stage)
		{
			stage = $stage;
			away_mc = new Key_Away_mc();
			a_btn = new Key_A_btn();
			b_btn = new Key_B_btn();
			
			away_mc.x = 10;
			away_mc.y = stage.stageHeight - away_mc.height - 10;
			
			a_btn.x = stage.stageWidth - a_btn.width - 10;
			a_btn.y = stage.stageHeight - a_btn.height - 10;
			
			b_btn.x = a_btn.x;
			b_btn.y = a_btn.y - b_btn.height - 10;
			
			away_mc.addEventListener(MouseEvent.MOUSE_DOWN, onAwayKeydown);
			a_btn.addEventListener(MouseEvent.MOUSE_DOWN, onAClick);
			b_btn.addEventListener(MouseEvent.MOUSE_DOWN, onBClick);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onAwayKeyup);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeydown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyup);
			
			stage.addEventListener(MouseEvent.MOUSE_OVER, onAddKey);
			stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			
			//////////////////////顶部按钮，人物，背包，系统
			bag_btn = new Bag_btn();
			peo_btn = new Peo_btn();
			sys_btn = new Sys_btn();
			
			peo_btn.x = bag_btn.width + 10;
			sys_btn.x = peo_btn.width + 10;
			
			stage.addChild(bag_btn);
			stage.addChild(peo_btn);
			stage.addChild(sys_btn);
			
			bag_btn.addEventListener(MouseEvent.CLICK, onBag_click);
			peo_btn.addEventListener(MouseEvent.CLICK, onPeo_click);
			sys_btn.addEventListener(MouseEvent.CLICK, onSys_click);
		}
		private function onBag_click(event:MouseEvent):void {
			
		}
		private function onPeo_click(event:MouseEvent):void {
			
		}
		private function onSys_click(event:MouseEvent):void {
			
		}
		
		private function onAClick(event:MouseEvent):void {
			invateA();
		}
		
		private function onBClick(event:MouseEvent):void {
			invateB();
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
				/*case 'a_btn':
					ATGame.roleList[0].left_key=false;
					ATGame.roleList[0].right_key=false;
					ATGame.roleList[0].up_key=false;
					ATGame.roleList[0].down_key=false;
					break;*/
			}
		}
		
		private function onAddKey(event:MouseEvent):void {
			if(!stage.contains(away_mc)){
				stage.addChild(away_mc);
			}
			if(!stage.contains(a_btn)){
				stage.addChild(a_btn);
			}
			if(!stage.contains(b_btn)){
				stage.addChild(b_btn);
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
			if(stage.contains(b_btn)){
				stage.removeChild(b_btn);
			}
		}
		
		private function releaseUpKey(code:int):void{
			switch (code) {
				case Keyboard.LEFT :
					ATGame.roleList[0].left_key=false;
					break;
				case Keyboard.RIGHT :
					ATGame.roleList[0].right_key=false;
					break;
				case Keyboard.UP :
					ATGame.roleList[0].up_key=false;
					break;
				case Keyboard.DOWN :
					ATGame.roleList[0].down_key=false;
					break;
			}
		}
		
		private function pressDownKey(code:int):void{
			switch (code) {
				case Keyboard.LEFT :
					ATGame.roleList[0].left_key = true;
					if(currentMenu){
						currentMenu.left();
					}
					break;
				case Keyboard.RIGHT :
					ATGame.roleList[0].right_key=true;
					if(currentMenu){
						currentMenu.right();
					}
					break;
				case Keyboard.UP :
					ATGame.roleList[0].up_key=true;
					if(currentMenu){
						currentMenu.up();
					}
					break;
				case Keyboard.DOWN :
					ATGame.roleList[0].down_key=true;
					if(currentMenu){
						currentMenu.down();
					}
					break;
				case Keyboard.SPACE:
					invateA();
					if(currentMenu){
						currentMenu.A();
					}
					break;
				case Keyboard.CONTROL:
					invateB();
					if(currentMenu){
						currentMenu.B();
					}
					break;
			}
		}
		
		private function invateA():void{
			if(!Alert.isShow || currentMenu == null){
				IntaveEvent.invate(ATGame.roleList[0].cartoon.currPlayRow, ATGame.roleList[0].xtile, ATGame.roleList[0].ytile);
			}
			if(currentMenu){
				currentMenu.A();
			}
		}
		
		private function invateB():void{
			if(currentMenu){
				currentMenu.B();
			}
			if(!currentMenu && Alert.isShow){
				Alert.hide();
				ATGame.roleList[0].isCtrl = true;
			}
		}
		
		private function onKeyup(event:KeyboardEvent):void {
			releaseUpKey(event.keyCode);
		}
		private function onKeydown(event:KeyboardEvent):void {
			pressDownKey(event.keyCode);
		}
		
	}
}