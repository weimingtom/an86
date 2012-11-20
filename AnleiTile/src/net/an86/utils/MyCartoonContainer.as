package net.an86.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	

	/**2D位图动画播放
	 * @author Anlei*/	
	public class MyCartoonContainer extends Bitmap
	{
		private var bitData:BitmapData;
		//把当前行的图分割成格子存在数组里
		private var orderArr:Array;
		//单格宽
		public var tileWidth:int;
		//单格高
		public var tileHeight:int;
		
		private var timer:Timer;
		public var currPlayRow:int = -1;//当前外观状态:行走，攻击，被击，死，飞行
		//当前播放的第几帧
		private var currPlayCol:int = 0;
		
		/**完整播放完这段动画后执行*/
		private var onEnd:Function;
		/**一开始播放完这段动画时执行*/
		private var onPlay:Function;
		
		public function MyCartoonContainer(_tileWidth:int, _tileHeight:int)
		{
			tileWidth = _tileWidth;
			tileHeight = _tileHeight;
			inits();
		}
		private function inits():void{
			orderArr = [];
			timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		private function onTimer(e:* = null):void{
			if(currPlayRow != -1 && currPlayRow < orderArr.length){
				this.bitmapData = orderArr[currPlayRow][currPlayCol];
				currPlayCol++;
				if(currPlayCol >= orderArr[currPlayRow].length){
					if(onEnd!=null)onEnd();
					currPlayCol = 0;
				}
			}
		}
		public function delBitmapData():void{
			stopRow(1,1);
			bitData && bitData.dispose();
			bitData = null;
			orderArr = [];
			this.bitmapData.dispose();
		}
		public function setBitmapData($bitData:BitmapData):void{
			bitData && bitData.dispose();
			bitData = null;
			bitData = $bitData;
			orderArr = [];
			
			for(var j:int = 0 ; j < bitData.height/tileHeight; j++){
				var _arr:Vector.<BitmapData> = new Vector.<BitmapData>;
				for(var i:int = 0 ; i < bitData.width/tileWidth; i++){
					var _bd:BitmapData = new BitmapData(tileWidth, tileHeight,true,0x0);
					_bd.copyPixels(bitData, new Rectangle(i*tileWidth, j*tileHeight, tileWidth, tileHeight),new Point(0,0));
					_arr.push(_bd);
				}
				orderArr.push(_arr);
			}
			onTimer();
			stopRow(0, 1);
		}
		/**添加个完整播放完这段动画后执行的方法*/
		public function addListenerEnd($onFN:Function):void{
			onEnd = $onFN;
		}/**添加个完整播放完这段动画后执行的方法*/
		public function addListenerStart($onFN:Function):void{
			onPlay = $onFN;
		}
		public function dispose():void{
			bitData.dispose();
			bitData = null;
			
			orderArr = null;
			
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer = null;
			
			onPlay = null;
		}
		/**播放间隔时间*/
		public function setGapTime($num:Number):void{
			timer.delay = $num;
		}
		/**播放第几行的动图*/		
		public function playRow(_uint:int):void{
			//if(currPlayRow != -1 && currPlayRow == _uint) return;
			currPlayRow = _uint;
			timer.stop();
			timer.reset();
			timer.start();
			onTimer();
			if(onPlay!=null)onPlay();
		}
		/**停止第几行的动图*/		
		public function stopRow(_uint:int, _frame:int = 2):void{
			timer.stop();
			this.bitmapData = orderArr[_uint][_frame];
		}
		/**暂停*/		
		public function pauseGame():void{
			timer.stop();
		}
		public function move(_x:Number, _y:Number):void{
			this.x = _x;
			this.y = _y;
		}
	}
}