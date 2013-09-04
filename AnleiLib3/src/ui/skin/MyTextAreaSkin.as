package ui.skin
{
	import anlei.util.PublicProperty;
	
	import ui.UIConfig;

	public class MyTextAreaSkin
	{
		
		public static function get(UI:Object):void{
			var TextArea_upSkin:Class = PublicProperty.GetSourceMCClass('TextArea_upSkin', UIConfig.UI_SKIN);
			var TextArea_disabledSkin:Class = PublicProperty.GetSourceMCClass('TextArea_disabledSkin', UIConfig.UI_SKIN);
			
			var _uiObj:Object = UI.getUI();
			_uiObj.putDefault("TextArea.defaultImage", TextArea_upSkin);
			_uiObj.putDefault("TextArea.disabledImage", TextArea_disabledSkin);
			_uiObj.putDefault("TextArea.uneditableImage", TextArea_upSkin);
			UI.setUI(_uiObj);
		}
		
	}
}