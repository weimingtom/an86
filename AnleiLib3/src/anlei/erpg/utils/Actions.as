package anlei.erpg.utils {
	public class Actions {
		/** 待机 */
		public static var Stop:int 	= 100;
		/** 待机随机动作 */
		public static var Stop1:int 	= 1001;
		/** 战斗待机 */
		public static var BattleStop:int 	= 101; 
		/** 坐骑待机 */
		public static var ZJ_Stop:int 	= 30; 
		/** 等待（备战） */ 
		//public static var Wait:int		= 8;
		/** 跑动 */
		public static var Run:int		=1;
		/** 坐骑跑动 */
		public static var ZJ_Run:int	=31;
		
		/**技能/技能前摇*/
		public static var SKIATK:int = 12;
		/**技能释放中*/
		public static var SKIATK_SUMMONING:int = 13;
		/**技能后摇*/
		public static var SKIATK_STOP:int = 14;
		/** Attack1 物理攻击 */
		public static var Attack1:int=2;
		/** Attack2 物理攻击 */
		public static var Attack2:int=22;
		/** Attack3 物理攻击 */
		public static var Attack3:int=23;
//		/** 弓箭攻击 */
//		public static var BowAtk:int=3;
		/** 死亡 */ 
		public static var Die:int = 5;
		/** 被攻击 */
		public static var BeAtk:uint = 7;
		
		/** 若无特殊情况，只播放一次的动作 */ 
		public static var OnePlay:Array = [2,5,7,12,14,22,23];
		/** 播放一次的动作结束后，自动切换入等待动作的 */ 
		public static var StopToWait:Array = [2,7,12,14,22,23];
		
		
		public static var STAND:String = 'stand';
		
		public static function cove(val:int):String{
			var str:String;
			switch(val){
				case Stop:
					str = STAND;
					break;
				case Stop1:
					str = STAND+"1";
					break;
				case ZJ_Stop:
					str = 'zj_stand';
					break;
				case BattleStop:
					str = 'battle_stand';
					break;
				case Run:
					str = 'run';
					break;
				case ZJ_Run:
					str = 'zj_run';
					break;
				////////
				case SKIATK:
					str = 'skiatk';
					break;
				case SKIATK_SUMMONING:
					str = 'skiatk_summoning';
					break;
				case SKIATK_STOP:
					str = 'skiatk_stop';
					break;
				case Attack1:
					str = 'attack1';
					break;
				case Attack2:
					str = 'attack2';
					break;
				case Attack3:
					str = 'attack3';
					break;
//				case BowAtk:
//					str = 'bowatk';
//					break;
				case Die:
				case BeAtk:
					str = 'hit';
					break;
				case BeAtk:
					str = 'beatk';
					break;
			}
			return str;
		}
	}
}