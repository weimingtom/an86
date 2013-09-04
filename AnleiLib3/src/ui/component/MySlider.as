package ui.component
{
	import fl.controls.Slider;
	
	import flash.display.DisplayObject;
	
	import ui.UIConfig;
	import ui.abs.AbstractComponent;

	/**
	 * 用法:
	  		var slider:MySlider = new MySlider();
			addChild(slider);
			slider.move(222, 222);
			slider.value = 50;
			slider.extent = 0;
			slider.minimum = 0;
			slider.maximum = 100;
			slider.showValueTip = true;
			slider.addEvent(function(e:Event):void{
				trace(slider.value);
			});
	 * 
	 */
	public class MySlider extends Slider implements AbstractComponent
	{
		
		public function MySlider()
		{
		}
		
		public function dispose():void {
			
		}
		
	}
}