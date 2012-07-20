package  
{
	import flash.display.MovieClip;
	
	/**
	 * @author Anlei
	 */
	public class SelectSoldierMain
	{
		private var Root:MovieClip;
		private var selectDrawing:SelectDrawing;
		private var selectDispose:SelectDispose;
		
		public function SelectSoldierMain($Root:MovieClip) 
		{
			Root = $Root;
			inits();
		}
		
		private function inits():void
		{
			setAllSoldiers();
			
			selectDrawing = new SelectDrawing(Root);
			selectDispose = new SelectDispose(Root);
			selectDrawing.addEventListener(SelectDrawing.EVENT_SELECT_WALK, selectDispose.onSelectWalk);
		}
		/**
		 * 设定后三个兵种为敌方
		 */
		private function setAllSoldiers():void {
			var _len:int = Root.numChildren;
			var _abs:AbstractSoldier;
			for (var i:int = 0 ; i < _len; i++) {
				if(i > 2){
					_abs = Root.getChildAt(i) as AbstractSoldier;
					if(_abs != null){
						_abs.IsFriend = false;
					}
				}
			}
		}
	}

}