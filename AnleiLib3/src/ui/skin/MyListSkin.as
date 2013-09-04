package ui.skin
{
	import anlei.util.PublicProperty;
	
	import fl.controls.List;
	
	import flash.display.Sprite;
	
	import ui.UIConfig;

	public class MyListSkin
	{
		private static function getScrollClass(value:String):Class{
			var _cls:Class = PublicProperty.GetSourceMCClass("cellRenderer_"+value, UIConfig.UI_SKIN);
			return _cls;
		}
		
		private static function setScrollSkin(UI:List, name:String):void{
			var _cls:Class = getScrollClass(name);
			if(!_cls) return;
			UI.setRendererStyle(name, _cls);
		}
		
		public static function set(UI:List):void{
			setScrollSkin(UI, "disabledSkin");
			setScrollSkin(UI, "downSkin");
			setScrollSkin(UI, "overSkin");
			setScrollSkin(UI, "upSkin");
			
			setScrollSkin(UI, "selectedDisabledSkin");
			setScrollSkin(UI, "selectedDownSkin");
			setScrollSkin(UI, "selectedOverSkin");
			setScrollSkin(UI, "selectedUpSkin");
			
			MyScrollBarSkin.set(UI.verticalScrollBar);
			
			var _newSkin:Class = PublicProperty.GetSourceMCClass('NullContaine', UIConfig.UI_SKIN);
			UI.setStyle('skin', _newSkin);
//			var _newSkin:Sprite = PublicProperty.GetSourceMCClass('NullContaine', UIConfig.UI_SKIN) as Sprite;
//			UI.setRendererStyle('skin', _newSkin);
//			
//			
//			
//			var _newSkin:Sprite = PublicProperty.GetSourceMCClass('NullContaine', UIConfig.UI_SKIN) as Sprite;
//			UI.verticalScrollBar.setStyle('upSkin', _newSkin);
			
			
		}
		
	}
}