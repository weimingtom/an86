package ui.abs
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RemoveThis
	{
		private var findName:String;
		/**
		 * 是否找到该类的顶部(用于在舞台上移除自己本身)
		 */		
		private var isParent:Boolean = false;
		private var active:Function;
		private var opearObject:Sprite;
		/**
		 * 用于在舞台上移除对象
		 * @param _object		要移除的对象
		 * @param _dispose		当点击到别处时释放资源
		 * 
		 */		
		public function RemoveThis(_object:Object, _dispose:Function)
		{
			opearObject = Sprite(_object);
			findName = String(_object);
			active = _dispose;
			if(opearObject.stage) inits();
			else opearObject.addEventListener(Event.ADDED_TO_STAGE, inits);
		}
		
		private function inits(e:Event = null):void{
			if(e!=null){
				opearObject.removeEventListener(Event.ADDED_TO_STAGE, inits);
				opearObject.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick, true);
			}
		}
		public function dispose():void{
			Entrance.getInstance().Root.addChild(opearObject);
			opearObject.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onClick, true);
			Entrance.getInstance().Root.removeChild(opearObject);
			opearObject = null;
			active = null;
		}
		/**
		 * 在舞台上移除自己
		 */		
		private function onClick(e:MouseEvent):void{
			isParent = false;
			isMIG(e.target as DisplayObject);
			if(!isParent){
				active.apply();
			}
		}
		/**
		 * 递归找该类的顶部
		 * @param dod
		 * 
		 */		
		private function isMIG(dod:DisplayObject):void{
			//如果找到
			if(String(dod.parent).indexOf(findName) != -1){
				isParent = true;
				return;
			}
			//如果没找到
			if(dod.parent == null){
				isParent = false;
				return;
			}
			isMIG(dod.parent);
		}
	}
}