package  
{
	import com.facebook.commands.stream.AddComment;
	import com.facebook.commands.stream.PublishPost;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.commands.users.HasAppPermission;
	import com.facebook.data.auth.ExtendedPermissionValues;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.GetInfoFieldValues;
	import com.facebook.events.FacebookEvent;
	import com.facebook.Facebook;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookSessionUtil;
	import flash.events.MouseEvent;
	import IFace.iFace;
	/**
	 * ...
	 * @author Anlei
	 */
	public class pureAS extends iFace
	{
		private var API_KEY:String = 'd3ab1778daf9005779348cbccfaa8261';
		private var SECRET:String = '79665ba51f892aecdbe56370f8508169';
		
		private var session:FacebookSessionUtil;
		private var facebook:Facebook;
		private var userInfo:FacebookUser;
		
		public function pureAS() 
		{
			inits();
		}
		
		private function inits():void
		{
			session = new FacebookSessionUtil(API_KEY, SECRET, this.loaderInfo);
			facebook = session.facebook;
			addString('An : '+loaderInfo.parameters.fb_sig_added);
			var obj:Object = loaderInfo.parameters;
			for (var name:String in obj) {
				addString(name + ' : ' + obj[name]);
			}
			
			if (loaderInfo.parameters.fb_sig_added == true) {
				session.addEventListener(FacebookEvent.CONNECT, onConnect);
				session.addEventListener(FacebookEvent.ERROR, onError);
				session.verifySession();
			}else{
				session.login();
				addString('正在连接中!');
			}
			
			this.stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var call:HasAppPermission = new HasAppPermission(ExtendedPermissionValues.PUBLISH_STREAM, facebook.uid);
			call.addEventListener(FacebookEvent.COMPLETE, onPublish);
			facebook.post(call);
		}
		private function onPublish(e:FacebookEvent):void 
		{
			clearString();
			addString('正在开启弹窗!');
			var attach:Object = {
				name:'desc Name Anlei',
				href:'http://sns.lo.igg.com/images/0_1.jpg',
				description:'哇哈哈',
				media:[ { type:'image', src:'http://sns.lo.igg.com/images/0_1.jpg', href:'http://sns.lo.igg.com/images/0_1.jpg' } ]
			};
			var publish:PublishPost = new PublishPost('A11', attach);
			publish.addEventListener(FacebookEvent.COMPLETE, onFBPublish);
			var publish_call:FacebookCall = facebook.post(publish);
		}
		
		private function onFBPublish(e:FacebookEvent):void 
		{
			if(e.success){
				addString('弹窗开启成功!');
			}else {
				addString('弹窗开启失败!');
				facebook.grantExtendedPermission(ExtendedPermissionValues.PUBLISH_STREAM);
			}
		}
		
		private function onError(e:FacebookEvent):void 
		{
			addString('连接失败!');
		}
		
		private function onConnect(e:FacebookEvent):void 
		{
			if (e.success) {
				addString('连接成功!');
				var call:FacebookCall = facebook.post(new GetInfo([facebook.uid], [GetInfoFieldValues.ALL_VALUES]));
				call.addEventListener(FacebookEvent.COMPLETE, onGetInfo);				
			}
			else
			{
				addString("contact fail");
			}
		}
		
		private function onGetInfo(e:FacebookEvent):void 
		{
			if (e.success) {
				addString("getinfo succ");
				userInfo = (e.data as GetInfoData).userCollection.getItemAt(0) as FacebookUser; 
			}else {
				addString('getting Facebook Info Error!');
			}
		}
		
	}

}