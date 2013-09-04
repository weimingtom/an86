package ui.skin
{
	import anlei.util.PublicProperty;
	
	import fl.controls.ScrollBar;
	
	import ui.UIConfig;

	public class MyScrollBarSkin
	{
		private static function getScrollClass(value:String):Class{
			var _cls:Class = PublicProperty.GetSourceMCClass("Scroll_"+value, UIConfig.UI_SKIN);
			return _cls;
		}
		
		private static function setScrollSkin(UI:ScrollBar, name:String):void{
			var _cls:Class = getScrollClass(name);
			if(!_cls) return;
			UI.setStyle(name, _cls);
		}
		public static function set(UI:ScrollBar):void{
			setScrollSkin(UI, "downArrowDisabledSkin");
			setScrollSkin(UI, "downArrowDownSkin");
			setScrollSkin(UI, "downArrowOverSkin");
			setScrollSkin(UI, "downArrowUpSkin");
			
			setScrollSkin(UI, "thumbIcon");
			
			setScrollSkin(UI, "thumbDisabledSkin");
			setScrollSkin(UI, "thumbDownSkin");
			setScrollSkin(UI, "thumbOverSkin");
			setScrollSkin(UI, "thumbUpSkin");
			
			setScrollSkin(UI, "trackUpSkin");
			setScrollSkin(UI, "trackDisabledSkin");
			UI.setStyle("trackOverSkin", getScrollClass("trackUpSkin"));
			UI.setStyle("trackDownSkin", getScrollClass("trackUpSkin"));
			UI.setStyle("trackDisabledSkin", getScrollClass("trackUpSkin"));
			
			setScrollSkin(UI, "upArrowDisabledSkin");
			setScrollSkin(UI, "upArrowDownSkin");
			setScrollSkin(UI, "upArrowOverSkin");
			setScrollSkin(UI, "upArrowUpSkin");
		}
		
		
	}
}