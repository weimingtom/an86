package  
{
	import com.facebook.commands.friends.GetFriends;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.DesktopSession;
	import flash.display.MovieClip;  
	 import flash.events.Event;  
	 import flash.events.MouseEvent;  
	 import flash.external.ExternalInterface;  
	 import com.facebook.Facebook;  
	 import com.facebook.session.WebSession;  
	 import com.facebook.events.FacebookEvent; 
	 import flash.text.TextField;
	/**
	 * ...
	 * @author Anlei
	 */
	public class FBStep2 extends MovieClip
	{
		private var _facebook:Facebook;  
		private var _websession:WebSession;  
		private var _uid:String;  
		public var connect_mc:MovieClip = new MovieClip(); //這是登入鈕 
		
		private	var trace_txt:TextField = new TextField();
		public function FBStep2() 
		{
			
			trace_txt = new TextField();
			trace_txt.multiline = true;
			trace_txt.wordWrap = true;
			trace_txt.width = trace_txt.height = 300;
			trace_txt.border = true;
			trace_txt.x = stage.stageWidth / 2;
			trace_txt.y = stage.stageHeight/ 2;
			addChild(trace_txt);
			//呼叫javascript進行FB.ini，  
			//並且註冊一個讓javascript callback的function  
			ExternalInterface.call("initFB");  
			ExternalInterface.addCallback("fbConnected", fbConnected);  
			
			//給予登入鈕Click事件 
			addChild(connect_mc);
			connect_mc.stage.addEventListener(MouseEvent.CLICK, connectClickHandler); 
		}
		private function fbConnected(pUid:String, pSecret:String, pSessionKey:String):void {  
			addString('Uid=' + pUid);
			addString('Secret=' + pSecret);
			addString('SessionKey=' + pSessionKey);
			//隱藏登入鈕  
			connect_mc.visible = false;   

			_uid = pUid; //儲存uid  
			//取得api_key  
			var _apiKey:String = loaderInfo.parameters.api_key;  
			//產生一個WebSession的instance  
			//並且將api_key、secret及session_key帶入  
			_websession = new WebSession(_apiKey, pSecret, pSessionKey);  
			//監聽WebSession連線成功後的事件  
			_websession.addEventListener(FacebookEvent.CONNECT, connectHandler);  
			//產生一個Facebook instance並且指定使用的session  
			_facebook = new Facebook();  
			_facebook.startSession(_websession);  

			//與Facebook進行session的驗證  
			_websession.verifySession();
		}  

			//登入鈕按下之後，呼叫javascript跳出登入視窗  
		private function connectClickHandler(e:MouseEvent):void {  
			ExternalInterface.call("FB.Connect.requireSession",null,true);  
		}  

		private function connectHandler(e:FacebookEvent):void {  
			addString(e);  
			if (e.success) {  
				addString("驗證成功");
				var call:FacebookCall = new GetFriends();
				call.addEventListener(FacebookEvent.COMPLETE, onGetFriend);
				_facebook.post(call);
			}  
		}
		
		private function onGetFriend(e:FacebookEvent):void 
		{
			if (e.data) {
				addString(e.data.rawResult);
				addString(e.data);
			}else {
				addString(e.error.errorMsg);
			}
		}
		
		private function addString(value:*):void {
			trace_txt.appendText(String(value) + '\n');
		}
	}

}