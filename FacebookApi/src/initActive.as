package  
{
	import com.facebook.commands.friends.GetFriends;
	import com.facebook.events.FacebookEvent;
	import com.facebook.Facebook;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookSessionUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Anlei
	 */
	public class initActive extends Sprite
	{
		private var trace_txt:TextField;
		
		private var API_KEY:String = 'd3ab1778daf9005779348cbccfaa8261';
		private var SECRET:String = '79665ba51f892aecdbe56370f8508169';
		private var fb_util:FacebookSessionUtil;
		private var fb:Facebook;
		
		private var up:uploadPhoto;
		
		public function initActive()
		{
			inits();
		}
		
		private function inits():void
		{
			
			trace_txt = new TextField();
			trace_txt.type = TextFieldType.INPUT;
			trace_txt.multiline = true;
			trace_txt.wordWrap = true;
			trace_txt.width = trace_txt.height = 300;
			trace_txt.border = true;
			trace_txt.x = 111;
			trace_txt.y = 111;
			addChild(trace_txt);
			var _sp:Sprite = CreateAlphaSP(true, 50, 50 , 50, 50, 0xFF0000, 1);
			addChild(_sp);
			_sp.addEventListener(MouseEvent.CLICK, onShow);
			_sp.doubleClickEnabled = true;
			_sp.addEventListener(MouseEvent.DOUBLE_CLICK, onDClick);
			
			addString('正在连接 Facebook!');
			
			fb_util = new FacebookSessionUtil(API_KEY, SECRET, this.loaderInfo);
			fb_util.addEventListener(FacebookEvent.CONNECT, onConnect);
			fb = fb_util.facebook;
			
		}
		
		private function onDClick(e:MouseEvent):void 
		{
			up = new uploadPhoto(fb.session_key, fb.uid);
			up.addEventListener('success', function(e:Event):void { addString('添加相册成功了!'); } );
			up.addEventListener('error', function(e:Event):void { addString('添加相册失败了!'); } );
			addChild(up);
		}
		
		private function onShow(e:MouseEvent):void 
		{
			fb_util.validateLogin();
		}
		private function onConnect(e:FacebookEvent):void 
		{
			addString('fb.uid:'+fb.uid);
			if (e.success) {
				addString('Facebook 连接成功!');
				//var call:FacebookCall = new GetFriends(null, fb.uid);
				//call.addEventListener(FacebookEvent.COMPLETE, onGetFriend);
				//fb.post(call);
			}else{
				fb_util.login();
				addString('Facebook 连接失败!');
			}
		}
		
		private function onGetFriend(e:FacebookEvent):void 
		{
			if (e.data) {
				addString('secret:'+fb.secret);
				addString(e.data.rawResult);
				addString(e.data);
			}else {
				addString(e.error.errorMsg);
			}
		}
		
		private function addString(value:*):void {
			trace_txt.appendText(String(value) + '\n');
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