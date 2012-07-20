package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	/**
	 * 处理选取和单击事件
	 * @author Anlei
	 */
	public class SelectDispose
	{
		private var seleSolderData:Array = [];//被选中的兵种列表
		private var Root:MovieClip;
		private var draw_sp:Sprite;
		private var selectDrawing:SelectDrawing;
		
		public function SelectDispose($Root:MovieClip) 
		{
			Root = $Root;
			if (draw_sp == null)
			{
				draw_sp = Root.getChildByName('ANLEI_draw_sp') as Sprite;
			}
		}
		/**
		 * 清理被选中的兵
		 */
		private function clearSelectedSolder():void{
			for(var i:int = 0 ; i < seleSolderData.length; i++){
				seleSolderData[i].select(false);
			}
			seleSolderData = [];
		}
		/**
		 * 返回是否已经有存在选中自己的兵列表
		 */
		private function isSelectedThisSolder():Boolean {
			var _onf:Boolean = false;
			if (seleSolderData.length > 0) {
				_onf = seleSolderData[0].IsFriend;
			}
			return _onf;
		}
		/**
		 * 返回是否有选中兵
		 * @return
		 */
		private function isSelectedSoldier():Boolean {
			var _len:int = Root.numChildren; 
			var _abs:AbstractSoldier;
			var _onf:Boolean = false;
			for (var i:int = 0 ; i < _len; i++) {
				_abs = Root.getChildAt(i) as AbstractSoldier;
				if (_abs != null && draw_sp.hitTestObject(_abs.backgroundMC)
				//&& _abs.IsFriend
				) {
					_onf = true;
					break;
				}
			}
			return _onf;
		}
		/**
		 * 选取--选中或不选中我方兵(返回是否有选中兵)
		 * @param	$selectOne		是否只选中一个兵(点选)
		 */
		private function setSelectedAllSoldiers($selectOne:Boolean = false):void {
			var _len:int = Root.numChildren; 
			var _abs:AbstractSoldier;
			clearSelectedSolder();
			//选自己的兵
			for (var i:int = 0 ; i < _len; i++) {
				_abs = Root.getChildAt(_len-i-1) as AbstractSoldier;
				if (_abs != null && draw_sp.hitTestObject(_abs.backgroundMC)) {
					if (_abs.IsFriend) {//多选中自己的兵
						_abs.select(true);
						seleSolderData.push(_abs);
						selectDrawing.appearAttackICON(true);
						if ($selectOne) {//只选中一个
							break;
						}
					}
				}
			}
			
			
			//return;
			
			
			//如果没有选中自己的兵，那就清理
			if (!isSelectedThisSolder()) {
				clearSelectedSolder();
			}
			//选敌兵，只选中一个
			for (i = 0 ; i < _len; i++) {
				_abs = Root.getChildAt(_len-i-1) as AbstractSoldier;
				if (_abs != null && draw_sp.hitTestObject(_abs.backgroundMC)) {
					if (!_abs.IsFriend) {//单选敌兵
						if (!isSelectedThisSolder()) {//如果之前未选中自己的兵
							_abs.select(true);
							seleSolderData.push(_abs);
							selectDrawing.appearAttackICON(false);
							break;
						}
					}
					
				}
			}
		}
		public function onSelectWalk(e:DataEvent):void 
		{
			selectDrawing =  e.currentTarget as SelectDrawing;
			if (isSelectedSoldier()){
				if (e.data == SelectDrawing.TAG_WALK) {
					setSelectedAllSoldiers(true);
				}else if (e.data == SelectDrawing.TAG_SELECT) {
					setSelectedAllSoldiers(false);
				}
				
				/*if (seleSolderData.length > 0 && seleSolderData[0].IsFriend) {
					if (_sd != null) {
						_sd.appearAttackICON(true);
					}
				}*/
				
				return;
			}
			if (e.data == SelectDrawing.TAG_WALK) {
				for (var i:int = 0 ; i < seleSolderData.length; i++) {
					if(seleSolderData[i].IsFriend){
						seleSolderData[i].walking(Root.stage.mouseX, Root.stage.mouseY);
					}
				}
			}else if (e.data == SelectDrawing.TAG_SELECT) {
				clearSelectedSolder();
				//_sd.appearAttackICON(false);
			}
		}
	}

}