package ui.skin
{
	import anlei.util.PublicProperty;
	
	import fl.controls.ComboBox;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import ui.UIConfig;
	import ui.component.MyTextFormat;

	public class MyComboBoxSkin
	{

		private static function getScrollClass(value:String):Class{
			var _cls:Class = PublicProperty.GetSourceMCClass("comboBox_"+value, UIConfig.UI_SKIN);
			return _cls;
		}
		
		private static function setScrollSkin(UI:ComboBox, name:String):void{
			var _cls:Class = getScrollClass(name);
			if(!_cls) return;
			UI.setStyle(name, _cls);
		}
		
		public static function set(UI:ComboBox):void{
			setTextStyle(UI.textField.textField);
			UI.textField.setStyle("textFormat", _textFormat);
			UI.dropdown.setRendererStyle("textFormat", _textFormat);
			UI.dropdown.setStyle("cellRenderer", MyListRenderer);
			
			
			setScrollSkin(UI, "disabledSkin");
			setScrollSkin(UI, "downSkin");
			setScrollSkin(UI, "overSkin");
			setScrollSkin(UI, "upSkin");
			
		}
		
		public static function setInputFormat(UI:ComboBox):void{
			UI.textField.setStyle("textFormat", _textFormat);
		}
		
		private static var _textFormat:MyTextFormat;
		public static function setTextStyle(textField:TextField):void {
			if(!_textFormat) _textFormat = new MyTextFormat();
			_textFormat.color = 0xFFFFFF;
			_textFormat.align = TextFieldAutoSize.CENTER;
			textField.defaultTextFormat = _textFormat;
			textField.setTextFormat(_textFormat);
			textField.filters = PublicProperty.TextFilter(0x0);
		}
		
	}
}