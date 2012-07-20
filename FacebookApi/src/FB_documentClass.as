package {
	//需要import以下類別  
	//因為我是用document class，所以多import了MovieClip  
	import com.facebook.commands.friends.GetFriends;
	import com.facebook.net.FacebookCall;
	import flash.display.MovieClip;
	import com.facebook.Facebook;
	import com.facebook.utils.FacebookSessionUtil;
	import com.facebook.events.FacebookEvent;
	import flash.text.TextField;

	public class FB_documentClass extends MovieClip {
		private var _sessionUtil:FacebookSessionUtil;
		private var _facebook:Facebook;
		private	var trace_txt:TextField = new TextField();
		public function FB_documentClass() {
			trace_txt.multiline = true;
			trace_txt.wordWrap = true;
			trace_txt.width = trace_txt.height = 200;
			trace_txt.border = true;
			trace_txt.x = stage.stageWidth / 2;
			trace_txt.y = stage.stageHeight / 2;
			addChild(trace_txt);
			
			
			//取得api_key  
			var _apiKey:String=this.loaderInfo.parameters.api_key;
			var _secret:String = this.loaderInfo.parameters.secret;
			//addString('Api:'+_apiKey);
			//addString('Sec:'+_secret);
			
			//初始化FacebookSessionUtil  
			//基於api secret的值不曝光，因此第二個值帶null  
			_sessionUtil=new FacebookSessionUtil(_apiKey, _secret, this.loaderInfo);
			//監聽FacebookSession跟Facebook之間連線的事件  
			_sessionUtil.addEventListener(FacebookEvent.CONNECT,fbConnectHandler);
			//如果使用FacebookSessionUtil的話  
			//Facebook物件實體是由FacebookSessionUtil給的  
			_facebook=_sessionUtil.facebook;
			
			//如果fb_sig_session_key這個值有值的話  
			//直接請FacebookSessionUtil跟Facebook取得連線就可  
			if (this.loaderInfo.parameters.fb_sig_session_key) {
				_sessionUtil.verifySession();
			} else {
				_sessionUtil.login(true);
			}
			
		}
		//理論上都正常的話是連線成功的  
		//使用FacebookSessionUtil的話可以直接取得uid  
		private function fbConnectHandler(e:FacebookEvent):void {
			addString("uid = " + _facebook.uid);
			
			//var call:FacebookCall = new GetFriends();
			//call.addEventListener(FacebookEvent.COMPLETE, onGetFriend);
			//_facebook.post(call);
		}
		
		private function onGetFriend(e:FacebookEvent):void 
		{
			if (e.data) {
				addString(e.data.rawResult + '\n');
				addString(e.data + '\n');
			}else {
				addString(e.error.errorMsg + '\n');
			}
		}
		
		private function addString(value:*):void {
			trace_txt.appendText(String(value) + '\n');
		}
	}
}