package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import createbattle.CreateBattle;
	import createbattle.RoundGroup;
	
	public class DQbattle extends Sprite
	{
		public function DQbattle()
		{
			if(!stage) stage.addEventListener(Event.ADDED_TO_STAGE, onStage);
			else onStage();
		}
		
		private function onStage(event:Event = null):void {
			stage.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void {
			
			var cb:CreateBattle = new CreateBattle();
			var bossBattle:RoundGroup = cb.bossBattle;
		}
	}
}