package ui.component
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class MyCheckBox extends MyButton
	{
		public function MyCheckBox()
		{
			super.isDispose3 = false;
			iconTextContainer.VAlign = MyHVBox.V_TOP;
			iconTextContainer.HAlign = MyHVBox.H_RIGHT;
			label = 'MyCheckBox';
			isPopUp = true;
			setStyle('cbtn_0');
			iconTextContainer.addEventListener(MyHVBox.GAP_CHANGE_EVENT, onResize);
		}
		
		private function onResize(event:Event):void {
			pack();
		}
		
		override public function dispose():void{
			iconTextContainer.removeEventListener(MyHVBox.GAP_CHANGE_EVENT, onResize);
			super.dispose();
		}
		
		override public function set selected(value:Boolean):void{
			super.selected = value;
		}
		
		override public function setStyle(s:String):void{
			super.setStyle(s);
			pack();
		}
		
		override public function set label(value:String):void{
			super.label = value;
			pack();
		}
		override public function get width():Number{
			var _len:int = this.numChildren;
			var _t:Number = 0;
			for (var i:int = 0; i < _len; i++) {
				var _dod:DisplayObject = this.getChildAt(i);
				if(_dod.width > _t){
					_t = _dod.width;
				}
			}
			return _t;
		}
		override public function set width(value:Number):void{/* iconTextContainer.width = value; iconTextContainer.updateSize();*/}
		
		override public function get height():Number{
			var _len:int = this.numChildren;
			var _t:Number = 0;
			for (var i:int = 0; i < _len; i++) {
				var _dod:DisplayObject = this.getChildAt(i);
				if(_dod.height > _t){
					_t = _dod.height;
				}
			}
			return _t;
		}
		override public function set height(value:Number):void{/* iconTextContainer.height = value; iconTextContainer.updateSize();*/}
		
		public function pack():void{
			iconTextContainer.width = btnSkin.width + iconTextContainer.Gap + _textField.width;
			iconTextContainer.height = btnSkin.height > _textField.height ? btnSkin.height : _textField.height;
			iconTextContainer.updateSize();
		}

	}
}