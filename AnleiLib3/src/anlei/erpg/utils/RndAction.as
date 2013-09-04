package anlei.erpg.utils
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import anlei.erpg.role.AbsERole;

	/**NPC随机动作*/
	public class RndAction
	{
		private var role:AbsERole;
		private var tween:TweenLite;
		//随机动画
		private var mc:MovieClip;
		
		public function RndAction($role:AbsERole)
		{
			role = $role;
		}
		
		/**初始化开始随机*/
		public function inits():void {
			mc = role.action_dict[Actions.cove(Actions.Stop1)];
			startRnd();
		}
		
		/**实时判断播放的帧数*/
		private function onPlayed(event:Event):void {
			if(mc.currentFrame == mc.totalFrames){//当这个动作播放完
				mc.gotoAndStop(1);//置为第一帧
				mc.removeEventListener(Event.ENTER_FRAME, onPlayed);
				role.action = Actions.Stop;
				startRnd();
			}
		}
		
		/**开始随机*/
		private function startRnd():void {
			var rnd:int = Math.random() * 6 + 10;//随机
			if(tween) tween.kill();
			tween = TweenLite.delayedCall(rnd, onPlayStop1);//延时
			mc.addEventListener(Event.ENTER_FRAME, onPlayed);
		}
		
		/**延时*/
		private function onPlayStop1():void {
			if(tween) tween.kill();
			tween = null;
			if(role)
				role.action = Actions.Stop1;
		}
		
		public function dispose():void{
			if(tween){
				tween.kill();
			}
			tween = null;
			
			if(mc){
				mc.stop();
				mc.removeEventListener(Event.ENTER_FRAME, onPlayed);
			}
			mc = null;
			
			role = null;
			
		}
	}
}