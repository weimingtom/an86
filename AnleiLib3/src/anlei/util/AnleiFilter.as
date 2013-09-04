package anlei.util
{
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	
	public class AnleiFilter
	{
		public function AnleiFilter()
		{
		}
		static public function setBaoRedColor(_sp:*):void {
			var mat:Array = [1.3086,1.6094,0.182,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,1,0.5,0,1,0,1,0];
			var colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
			_sp.filters = [colorMat, new GlowFilter(0xFF0000,1,2,2,10,2)];
		}
		static public function setNotColor(_sp:*):void{
			var mat:Array = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
			var colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
			_sp.filters = [colorMat];
		}
		static public function setRgbColor(_sp:*):void{
			_sp.filters = null;
		}
		static public function drawRect(_x:Number = 0, 			_y:Number = 0,
										_w:Number = 100,		_h:Number = 100,
										_isBg:Boolean = true,	_bgColor:Number = 0x00FF00):Sprite{
		
			var _sp:Sprite = new Sprite();
			var bgalpha:Number = _isBg ? 1 : 0;
			_sp.graphics.beginFill(_bgColor, bgalpha);
			_sp.graphics.drawRect(_x,_y,_w,_h);
			_sp.graphics.endFill();
			return _sp;
		}
		/**画只有边框的矩形**/
		static public function drawRectLine(_x:Number, _y:Number, _w:Number, _h:Number, _color:Number = 0xE5B04C):Sprite {
			var sp:Sprite = new Sprite();
			sp.graphics.lineStyle(1, _color, 1);
			sp.graphics.drawRect(_x, _y, _w, _h);
			return sp;
		}
		
	}
}