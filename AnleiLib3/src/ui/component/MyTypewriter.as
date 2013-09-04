package ui.component
{
	import anlei.util.EnterFrame;

	/**打字机效果*/
	public class MyTypewriter
	{
		private var _text:String = '';
		private var _currentText:String;
		/**每次循环打印显示字数的总数*/
		private var onDisplayCount:int;
		/**每次循环打印所执行的方法*/
		private var onExec:Function;
		/**每次循环打印显示字数*/
		public var spliceCount:int;
		/**是否在循环打印中*/
		public var isRun:Boolean = false;
		/**当循环打印完后所执行的方法*/
		private var onAutoStopExec:Function;
		
		public function MyTypewriter($text:String = '', $onExec:Function = null, $onAutoStopExec:Function = null, $spliceCount:int = 1) {
			text = $text;
			onExec = $onExec;
			onAutoStopExec = $onAutoStopExec;
			spliceCount = $spliceCount;
		}
		
		public function get text():String { return _text; }
		public function set text(value:String):void{ _text = value; }
		
		/**循环打印中字*/
		public function get currentText():String{ return _currentText; }
		
		/**开始打字*/
		public function start():void{
			if(isRun){//当前正在打印时，又执行了start()方法，则停止循环并直接显示所有文字
				stop();
			}else{
				EnterFrame.enterFrame = onEnter;
				isRun = true;
			}
		}
		
		public function stop():void{
			onDisplayCount = 0;
			EnterFrame.removeEnterFrame = onEnter;
			_currentText = text;
			isRun = false;
			text = '';
		}
		
		/**每次的显示方法*/
		private function onEnter():void {
			//每次累加长度，
			onDisplayCount += spliceCount;
			//显示当前长
			_currentText = text.substr(0, onDisplayCount);
			if(onExec!=null) onExec();
			
			if(onDisplayCount >= text.length){
				stop();
				if(onAutoStopExec != null) onAutoStopExec();
			}
		}
		
	}
}