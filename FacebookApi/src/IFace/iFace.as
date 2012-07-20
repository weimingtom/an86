package IFace 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author Anlei
	 */
	public class iFace extends Sprite
	{
		private var trace_txt:TextField;
		
		public function iFace() 
		{
			trace_txt = new TextField();
			trace_txt.type = TextFieldType.INPUT;
			trace_txt.multiline = true;
			trace_txt.wordWrap = true;
			trace_txt.width = trace_txt.height = 300;
			trace_txt.border = true;
			trace_txt.x = 0;
			trace_txt.y = 0;
			addChild(trace_txt);
		}
		
		public function addString(value:*):void {
			trace_txt.appendText(String(value) + '\n');
		}
		public function clearString():void {
			trace_txt.text = '';
		}
		public function CreateAlphaSP(_mouseEnabled:Boolean,
											 _width:Number, _height:Number,
											 _x:Number = 0, _y:Number = 0,
											 _fillColor:Number = 0xFF0000,
											 _fillAlpha:Number = 0):Sprite{
			var mask_sp:Sprite = new Sprite();
			mask_sp.mouseEnabled = _mouseEnabled;
			mask_sp.graphics.beginFill(_fillColor);
			mask_sp.graphics.drawRect(_x, _y, _width, _height);
			mask_sp.graphics.endFill();
			mask_sp.alpha = _fillAlpha;
			return mask_sp;
		}
	}

}