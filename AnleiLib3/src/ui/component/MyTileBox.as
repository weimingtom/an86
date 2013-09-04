package ui.component
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;

	public class MyTileBox extends MySprite
	{
		private var dodArr:Array = [];
		
		private var _rowCount:uint;
		private var _rowGap:Number;
		private var _colGap:Number;
		private var _offx:Number;
		private var _offy:Number;
		private var tween:TweenLite;
		
		/**是否要绘制背景（便于滚动条自适应）*/
		public var isDrawBG:Boolean = false;
		
		/**
		 * 阵列
		 * @param $rowCount		每行多少个
		 * @param $rowGap		行间隔
		 * @param $colGap		列间隔
		 * @param $offx			从容器里的x坐标开始偏移
		 * @param $offy			从容器里的y坐标开始偏移
		 */
		public function MyTileBox($rowCount:uint = 6, $rowGap:Number = 32, $colGap:Number = 32, $offx:Number = 0, $offy:Number = 0)
		{
			rowCount = $rowCount;
			rowGap = $rowGap;
			colGap = $colGap;
			offx = $offx;
			offy = $offy;
		}
		
		private function flush():void{
			lineupAll(super.addChild, rowCount, dodArr, rowGap, colGap, offx, offy);
			tween = null;
			if(dodArr.length > 0 && isDrawBG){
				redraw();
			}
		}
		
		private function redraw():void{
			this.graphics.clear();
			this.graphics.beginFill(0, 0.1);
			this.graphics.drawRect(0,0,width+offx,height);
			this.graphics.endFill();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{
			if(child != null){
				super.addChildAt(child, 0);
				var _index:int = dodArr.indexOf(child);
				if(_index == -1){
					dodArr.push(child);
				}
				if(tween){
					tween.kill();
				}
				tween = TweenLite.delayedCall(0.5, flush);
			}
			return child;
		}
		
		override public function get numChildren():int{
			return dodArr.length;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject{
			if(child != null){
				var _index:int = dodArr.indexOf(child);
				if(_index != -1){
					var _dod:DisplayObject = dodArr[_index] as DisplayObject;
					if(_dod){
						super.removeChild(_dod);
					}
					dodArr.splice(_index, 1);
					flush();
				}
			}
			return child;
		}
		
		override public function removeAllChild(isDispose:Boolean = false):void{
			for (var i:int = 0; i < dodArr.length; i++) 
			{
				var _dod:DisplayObject = dodArr[i] as DisplayObject;
				if(_dod){
					if(super.contains(_dod)){
						super.removeChild(_dod);
					}
				}
			}
			dodArr = [];
			flush();
		}
		
		/**
		 * 阵列
			 var arr:Array = [];
			 for(var arr_i:int = 0 ; arr_i < 50; arr_i++){
			 	arr.push(new MyButton("btn_"+arr_i));
			 }
			 MyTileBox.lineupAll(this, 6, arr, 90, 40);
		
		 * @param $container_addChild	容器的addChild方法
		 * @param $rowCount				每行多少个
		 * @param $contentArr			所有要排列的元素都存在数组里
		 * @param $rowGap				行间隔
		 * @param $colGap				列间隔
		 * @param $offx					从容器里的x坐标开始偏移
		 * @param $offy					从容器里的y坐标开始偏移
		 */
		public static function lineupAll($container_addChild:Function = null, $rowCount:uint = 6, $contentArr:Array = null, $rowGap:Number = 32, $colGap:Number = 32, $offx:Number = 0, $offy:Number = 0):void{
			var _len:int = $contentArr.length;
			var nx:Number = 0;
			var ny:Number = 0;
			for (var n:int = 0; n < _len; n ++) {
				if (n % $rowCount == 0 && n != 0) {
					ny += $colGap;
					nx = 0;
				}
				var sp:Object = $contentArr[n];
				sp.x = nx + $offx;
				sp.y = ny + $offy;
				nx += $rowGap;
				if($container_addChild != null) $container_addChild(sp);
				$container_addChild = null;
			}
		}
		/*
		public static function getCurrCoor(n:int, $rowCount:uint, $rowGap:Number, $colGap:Number, $offx:Number, $offy:Number):Point{
			var nx:Number = 0;
			var ny:Number = 0;
			if (n % $rowCount == 0 && n != 0) {
				ny += $colGap;
				nx = 0;
			}
			nx += $rowGap;
			
			return new Point(nx + $offx, ny + $offy);
		}
*/
		/**每行多少个*/
		public function get rowCount():uint { return _rowCount; }
		public function set rowCount(value:uint):void {
			_rowCount = value;
			flush();
		}

		/**行间隔*/
		public function get rowGap():Number { return _rowGap; }
		public function set rowGap(value:Number):void {
			_rowGap = value;
			flush();
		}

		/**列间隔*/
		public function get colGap():Number { return _colGap; }
		public function set colGap(value:Number):void {
			_colGap = value;
			flush();
		}

		/**从容器里的x坐标开始偏移*/
		public function get offx():Number { return _offx; }
		public function set offx(value:Number):void {
			_offx = value;
			flush();
		}

		/**从容器里的y坐标开始偏移*/
		public function get offy():Number { return _offy; }
		public function set offy(value:Number):void {
			_offy = value;
			flush();
		}

		
	}
}