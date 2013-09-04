package ui.component
{
	import anlei.util.PublicProperty;
	
	import flash.display.Sprite;
	
	import ui.UIConfig;
	import ui.abs.AbsWin;

	/**
	 * 用法:
	 AbsWin.Window = this;
	 var _win:MyWin = new MyWin('anlei', 300, 300);
	 _win.pop();
	 _win.removePop();
	 _win.dispose();
	 * */
	public class MyWin extends AbsWin
	{
		public static var currentPopWin:AbsWin;
		
		private var style:int;
		private var configArr:Array;
		
		public function MyWin($title:String='', $w:int = 400, $h:int = 200, $winStyle:int = 0, $closeStyle:int = 0)
		{
			if(CloseBtn_class == null){
				CloseBtn_class = PublicProperty.GetSourceMCClass("closeBtn_" + $closeStyle, UIConfig.UI_SKIN);
			}
			
			super($title, $w, $h);
			
//			CloseBtn_OFF_X = -8;
//			CloseBtn_OFF_Y = 24;
			
			setStyle($winStyle);
			title_txt.isTextCenterY = true;
			title_txt.textField.format.bold = true;
			title_txt.textField.format.color = 0xFFFFFF;
			title_txt.textField.size = 16;
			title_txt.bg.parent.removeChild(title_txt.bg);
			//title_txt.y = -8;
		}
		
		public function get closeBtnOffx():Number{ return CloseBtn_OFF_X; }
		public function set closeBtnOffx(value:Number):void{
//			CloseBtn_OFF_X = value;
//			resetCloseBtnXY();
		}
		
		public function get closeBtnOffy():Number{ return CloseBtn_OFF_Y; }
		public function set closeBtnOffy(value:Number):void{
//			CloseBtn_OFF_Y = value;
//			resetCloseBtnXY();
		}
		
		public function getStyle():int{ return style; }
		public function setStyle(n:int):void{
			style = n;
			bg = PublicProperty.GetSourceMC(UIConfig.mcContent.winStyleCount[n], UIConfig.UI_SKIN) as Sprite;
			createConfig(n);
			/*if(style == 4){
				title_txt.y = 10;
			}*/
		}
		
		private function createConfig(n:int):void{
			var _obj:Object = UIConfig.mcContent;
			if(configArr == null) configArr = _obj.winStyleConfig;
			var _cfarr:Array = configArr[n].split(",");
			var _clsX:Number = _cfarr[0];
			var _clsY:Number = _cfarr[1];
			var _titleY:Number = _cfarr[2];
			
			CloseBtn_OFF_X = _clsX;
			CloseBtn_OFF_Y = _clsY;
			resetCloseBtnXY();
			title_txt.y = _titleY;
		}
		
		
		override public function pop($x:int = -1, $y:int = -1):void{
			currentPopWin = this;
			super.pop($x, $y);
		}
		
		override public function dispose():void{
			currentPopWin = null;
			super.dispose();
		}
	}
}
