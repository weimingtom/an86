package ui.component
{
	import anlei.util.AnleiFilter;
	import anlei.util.PublicProperty;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.UIConfig;

	public class MyBorder extends MySprite
	{
		public var MC:Sprite;
		
		private var _style:String = 'border_0';
		private var _enabled:Boolean;
		
		public function MyBorder($mc:Sprite = null, $style:String = 'border_0')
		{
			if($mc == null){
				if(!$style) $style = 'border_0';
				MC = GetButtonStyleSource($style);
			}else{
				MC = $mc;
			}
			if(MC){
				MovieClip(MC).stop();
			}
			addChild(MC);
			MC.mouseEnabled=false;
			//this.mouseChildren = false;
		}
		
		protected function GetButtonStyleSource(s:String):Sprite {
			return PublicProperty.GetSourceMC(s, UIConfig.UI_SKIN) as Sprite;
		}
		
		public function getStyle():String{ return _style; }
		public function setStyle(value:String):void{
			if(_style == value) return;
			_style = value;
			var _t:Sprite = MC;
			
			MC = GetButtonStyleSource(_style);
			if(MC){
				MovieClip(MC).stop();
			}
			//MC.width = _t.width;
			//MC.height= _t.height;
			addChildAt(MC, 0);
			MC.mouseEnabled=false;
			
			if(_t){
				if(this.contains(_t)){
					removeChild(_t);
				}
			}
		}
		
		override public function get enabled():Boolean { return _enabled; }
		override public function set enabled(value:Boolean):void{
			_enabled = value;
			if(_enabled){
				AnleiFilter.setRgbColor(this.MC);
			}else{
				AnleiFilter.setNotColor(this.MC);
			}
		}
		
		
		override public function get width():Number{ return MC.width;}
		override public function set width(value:Number):void{
			MC.width = value;
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number{ return MC.height; }
		override public function set height(value:Number):void{
			MC.height = value;
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function dispose():void{
			if(MC!=null){
				removeChild(MC);
				MC = null;
			}
			super.dispose();
		}
	}
}