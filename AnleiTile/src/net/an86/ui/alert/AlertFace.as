package net.an86.ui.alert
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import net.an86.tile.ATGame;
	
	import ui.component.MyTextField;

	public class AlertFace
	{
		private static const OFFX:int = 20;
		private static const OFFY:int = 20;
		private var bg:Sprite;
		private var txt:MyTextField;
		
		public function AlertFace()
		{
			inits();
		}
		
		private function inits():void
		{
			bg = new Sprite();
			txt = new MyTextField();
			txt.wordWrap = false;
			txt.x = OFFX;
			txt.y = OFFY;
			txt.format.leading = 4;
			txt.format.letterSpacing = 1;
			txt.format.size = 14;
			txt.format = txt.format;
			//txt.border = true;
			txt.isStroke = true;
			txt.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function getText():String {
			var _str:String = 'null';
			if(txt && txt.text){
				_str = txt.text;
			}
			return _str;
		}
		
		public function setText(value:String):BitmapData{
			txt.wordWrap = false;
			txt.htmlText = value;
			
			var _w:int = txt.width;
			var _h:int = txt.height;
			var _sw:int = ATGame.gameContainer.stage.stageWidth;
			var _sh:int = ATGame.gameContainer.stage.stageHeight;
			if(_w > _sw){
				_w = _sw - 2;
				txt.width = _w;
				txt.wordWrap = true;
			}
			if(_h > _sh){
				_h = _sh - 2;
				txt.height = _h;
				txt.wordWrap = true;
			}
			bg.graphics.clear();
			bg.graphics.beginFill(0x0, 0.5);
			bg.graphics.drawRect(0, 0, txt.width + OFFX*2, txt.height + OFFY);
			bg.graphics.endFill();
			
			txt.y = int((bg.height - txt.height)/2);
			bg.addChild(txt);
			var bd:BitmapData = new BitmapData(bg.width, bg.height, true, 0x0);
			bd.draw(bg);
			bg.removeChild(txt);
			return bd;
		}
	}
}