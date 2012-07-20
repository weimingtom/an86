package  
{
	import com.facebook.commands.photos.UploadPhoto;
	import com.facebook.events.FacebookEvent;
	import com.facebook.Facebook;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.WebSession;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Anlei
	 */
	public class uploadPhoto extends Sprite
	{
		private var API_KEY:String = 'd3ab1778daf9005779348cbccfaa8261';
		private var SECRET:String = '79665ba51f892aecdbe56370f8508169';
		private var session_KEY:String = '';
		private var uid:String;
		private var facebook:Facebook;
		
		public function uploadPhoto(_sk:String, _uid:String)
		{
			session_KEY = _sk;
			uid = _uid;
			inits();
		}
		
		private function inits():void
		{
			var _sp:Sprite = CreateAlphaSP(true, 50, 50 , 50, 50, 0xFF0000, 1);
			addChild(_sp);
			
			sendCameraPic();
		}
		
		
		public function sendCameraPic():void{
			
			
			facebook = new Facebook();
			//根据js传来的交互参数 开始会话
			var webSession:WebSession=new WebSession(API_KEY, SECRET, session_KEY);
			facebook.startSession(webSession);
			
			webSession.addEventListener(FacebookEvent.CONNECT, onConnetToSendPic);
			webSession.verifySession();
			
		}
		
  		/**
  		 *发送截图连接FACEBOOK 
  		 * @param e
  		 * 
  		 */  		
  		private function onConnetToSendPic(e:FacebookEvent):void{
  			if (e.success)
			{
				var bitPicData:BitmapData = new BitmapData(100, 100);
				bitPicData.draw(CreateAlphaSP(false, 100, 100, 2, 2, 0xFF0000, 1));
				var upData:FacebookCall = new UploadPhoto(bitPicData,
															null,
															'我发送的图片!!``..!',
															uid); // 发送图片
				upData.addEventListener(FacebookEvent.COMPLETE, onSendCameraPicComplete);
				upData.addEventListener(FacebookEvent.ERROR, onSendPicError);
				facebook.post(upData);
			}
		}
		
		private function onSendPicError(e:FacebookEvent):void 
		{
			this.dispatchEvent(new Event('error'));
		}
		
		private function onSendCameraPicComplete(e:FacebookEvent):void 
		{
			this.dispatchEvent(new Event('success'));
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