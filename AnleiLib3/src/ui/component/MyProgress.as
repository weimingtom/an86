package ui.component
{
	import flash.display.Sprite;

	public class MyProgress
	{
		private var _max:Number = 0;
		private var _curr:Number = 0;
		private var _min:Number = 0;
		private var _mc:Sprite;

		public function MyProgress($mc:Sprite, $max:Number, $curr:Number, $min:Number) {
			mc = $mc;
			max = $max;
			min = $min;
			curr= $curr;
		}
		
		public function get max():Number{ return _max; }
		public function set max(value:Number):void{
			_max = value;
			setMcScaleX();
		}
		
		public function get curr():Number{ return _curr; }
		public function set curr(value:Number):void{
			_curr = value;
			setMcScaleX();
		}
		
		public function get min():Number{ return _min; }
		public function set min(value:Number):void{
			_min = value;
			setMcScaleX();
		}
		
		public function get mc():Sprite { return _mc; }
		public function set mc(value:Sprite):void{
			_mc = value;
		}
		
		public function setMcScaleX():void{
			mc.scaleX = curr / max + min / max;
		}
	}
}