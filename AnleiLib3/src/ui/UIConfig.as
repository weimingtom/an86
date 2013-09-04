package ui
{
	import anlei.util.PublicProperty;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import ui.component.MyComboBox;
	import ui.component.MyList;
	import ui.component.MyScrollBar;
	import ui.component.MySlider;

	public class UIConfig
	{
		public static const UI_SKIN:String = 'ui_skin';

///////////////////////////////////////////////////////////////////////////////////
	
		private static var _mcContent:MovieClip;
		public static function get mcContent():MovieClip{
			if(_mcContent == null){
				_mcContent = PublicProperty.GetSourceContent(UI_SKIN) as MovieClip;
			}
			return _mcContent;
		}
		
///////////////////////////////////////////////////////////////////////////////////
		
		public static function initsUI(container:Sprite):void{
			var _slider:MySlider = new MySlider();
			_slider.x = _slider.y = -200;
			container.addChildAt(_slider, 0);
			
			var _list:MyList = new MyList();
			_list.x = _list.y = -200;
			container.addChildAt(_list, 0);
			
			var _cbb:MyComboBox = new MyComboBox();
			_cbb.x = _cbb.y = -200;
			container.addChildAt(_cbb, 0);
			
			var _sb:MyScrollBar = new MyScrollBar();
			_sb.x = _sb.y = -200;
			container.addChildAt(_sb, 0);
		}
	}
}