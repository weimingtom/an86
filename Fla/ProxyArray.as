package
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	dynamic class ProxyArray extends Proxy {
		private var _item:Array;

		public function ProxyArray() {
			_item = new Array();
		}

		override flash_proxy function callProperty(methodName:*, ... args):* {
			trace("callProperty:", methodName, args);
			var res:*;
			switch (methodName.toString()) {
				case 'clear' :
					_item = new Array();
					break;
				case 'sum' :
					var sum:Number = 0;
					for each (var i:* in _item) {
						// ignore non-numeric values
						if (!isNaN(i)) {
							sum += i;
						}
					}

					res = sum;
					break;
				default :
					res = _item[methodName].apply(_item, args);
					break;
			}
			return res;
		}

		override flash_proxy function getProperty(name:*):* {
			trace("get:", name);
			return _item[name];
		}

		override flash_proxy function setProperty(name:*, value:*):void {
			trace("set:", name);
			_item[name] = value;
		}
	}
}