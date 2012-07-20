package {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.StageDisplayState;

	public class FMain extends MovieClip {

		private var flag:String;
		private var lock_arr:Array;
		private var lock_index:int = 0;
		private var lock_arr2:Array;
		private var lock_index2:int = 0;
		private var old_arr:Array = [];
		private var n1:int;
		private var n2:int;



		public function FMain() {
			var loader:URLLoader = new URLLoader(new URLRequest("d.xml"));
			loader.addEventListener(Event.COMPLETE, inits);
			stage.displayState=StageDisplayState.FULL_SCREEN;
		}
		private function inits(e:*):void {
			var xml:XML = XML(e.target.data);
			lock_arr = xml.@lock.split(",");
			lock_arr2 = xml.@lock2.split(",");
			p.ArrayJoin(old_arr, lock_arr);
			p.ArrayJoin(old_arr, lock_arr2);
			n1 = xml.@random.split("-")[0];
			n2 = xml.@random.split("-")[1];

			start_btn.visible = false;
			start_btn.addEventListener(MouseEvent.CLICK, onStart);

			stop_btn.visible = false;
			stop_btn.addEventListener(MouseEvent.CLICK, onStop);

			jc_mc.addEventListener(MouseEvent.CLICK, onTab);

			rnd_mc.visible = false;

		}
		private function onTab(e:*):void {
			flag = e.target.name;
			jc_mc.gotoAndStop(flag);

			if (flag == 'a' || flag == 'b' || flag == 'c' || flag == 'd') {
				rnd_mc.visible = false;
				stop_btn.visible = false;
				start_btn.visible = true;
				fu_mc.visible = true;
				hjmd_txt.text = '';
			}
		}
		private function onStart(e:*):void {
			if (flag != null) {
				hjmd_txt.text = '';
				fu_mc.visible = false;
				rnd_mc.visible = true;
				rnd_mc.play();

				stop_btn.visible = true;
				start_btn.visible = false;
			}
		}
		private function onStop(e:*):void {
			rnd_mc.visible = false;
			stop_btn.visible = false;
			start_btn.visible = true;
			var _end:Array;
			switch (flag) {
				case 'a' :
					if (lock_index >= lock_arr.length) {
						rendererText(p.RandomArray(n1, n2, 1, old_arr));
					} else {
						rendererText(lock_arr[lock_index++]);
					}
					break;
				case 'b' :
					if (lock_index2 >= lock_arr2.length) {
						rendererText(p.RandomArray(n1, n2, 1, old_arr));
					} else {
						rendererText(lock_arr2[lock_index2++]);
					}
					break;
				case 'c' :
					_end = p.RandomArray(n1, n2, 5, old_arr);
					p.ArrayJoin(old_arr, _end);
					rendererText(_end);
					break;
				case 'd' :
					_end = p.RandomArray(n1, n2, 10, old_arr);
					p.ArrayJoin(old_arr, _end);
					rendererText(_end);
					break;
			}
		}
		private function rendererText($obj:Object):void {
			if ($obj is Array) {
				for (var i:int = 0; i < $obj.length; i++) {
					var _s:String = $obj[i];
					if (_s.length == 2) {
						_s = '0' + _s;
					}
					if (_s.length == 1) {
						_s = '00' + _s;
					}
					$obj[i] = _s;
				}
			} else if ($obj is String) {
				if ($obj.length == 2) {
					$obj = '0' + $obj;
				}
				if ($obj.length == 1) {
					$obj = '00' + $obj;
				}
			}
			var _d:String = $obj.toString();
			if(_d.length > 20){
				var _r:String = _d.substring(0, 19) + '\n' + _d.substring(20, _d.length);
				_d = _r;
			}
			hjmd_txt.text = _d;
		}
	}
}