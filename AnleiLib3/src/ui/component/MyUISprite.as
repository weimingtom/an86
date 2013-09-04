package ui.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MyUISprite extends Sprite
	{
		public var UI:Object;
		
		public function MyUISprite()
		{
			super();
		}
		
		override public function get width():Number{ return UI.getWidth();}
		override public function set width(value:Number):void{
			UI.setWidth(value);
			UI.validate();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number{ return UI.getHeight(); }
		override public function set height(value:Number):void{
			UI.setHeight(value);
			UI.validate();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
	}
}