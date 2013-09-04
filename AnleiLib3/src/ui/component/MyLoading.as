package ui.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import anlei.util.PublicProperty;
	
	import ui.abs.AbstractComponent;
	
	/**
	 * ---------------------------------------------------------------------------------要资源
	 * @author Anlei
	 */
	public class MyLoading extends MySprite implements AbstractComponent
	{
		/**进度条资源*/
		public static const MAIN_LOADER_UI:String = 'main_loader_ui';
		public static var barSource:Sprite;
		
		private var loadbar_width:Number;
		
		
		private var loading_txt:TextField;
		
		public var loading_mc:MovieClip;
		
		private var mask_mc:Sprite;
		
		public function MyLoading()
		{
			inits();
		}
		private function inits():void{
			barSource = PublicProperty.GetSourceMC('Loading', MAIN_LOADER_UI) as Sprite;
			if(barSource == null) return;
			this.addChild(barSource);
			loading_txt = barSource.getChildByName('loading_txt') as TextField;
			loading_txt.filters = PublicProperty.TextFilter();
			loading_mc  = barSource.getChildByName('loading_mc') as MovieClip;
			
			loading_txt.defaultTextFormat.align = TextFieldAutoSize.CENTER;
			
			loadbar_width = loading_mc.width;
//			mask_mc = PublicProperty.CreateAlphaSP(true, Entrance.getInstance().Root.stage.stageWidth, Entrance.getInstance().Root.stage.stageHeight ,0,0,0x0);
//			addChild(mask_mc);
		}
		/**
		 * 获得初始宽度
		 */		
		public function get loadBarWidth():Number{
			return loadbar_width;
		}
		/**
		 * 显示加载的描述文字
		 */		
		public function set value(_value:String):void{
			loading_txt.text = _value;
		}
		public function get value():String{
			return loading_txt.text;
		}
		override public function dispose():void{
			this.removeChild(barSource);
			barSource = null;
			
			super.dispose();
		}
		/**设置大小*/
		public function setSize(_width:Number, _height:Number):void{
			
		}
		/**设置位置*/
		public function move(_x:Number, _y:Number):void{
			this.x = _x;
			this.y = _y;
		}
	}
}