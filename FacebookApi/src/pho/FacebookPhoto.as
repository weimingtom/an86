package pho
{
	import adobe.utils.CustomActions;
	import com.facebook.commands.fql.FqlQuery;
	import flash.external.ExternalInterface;
	import flash.display.BitmapData;

	
	import com.facebook.Facebook;
	import com.facebook.commands.users.HasAppPermission;
	import com.facebook.events.FacebookEvent;
	import com.facebook.commands.stream.PublishPost;
	import com.facebook.data.feed.ActionLinkData;
	import com.facebook.data.auth.ExtendedPermissionValues;
	import com.facebook.session.WebSession;
	import com.facebook.session.DesktopSession;
	import com.facebook.data.BooleanResultData;
	import com.facebook.commands.friends.GetAppUsers;
	import com.facebook.commands.fql.FqlQuery;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.data.events.FacebookEventData;
	import com.facebook.commands.photos.UploadPhoto;
	import com.facebook.data.friends.GetAppUserData;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.FacebookUserCollection;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.photos.FacebookPhoto;
	/**
	 * ...
	 * @author 
	 */
	public class FacebookPhoto
	{
		private var _instance:FacebookPhoto;
		
		public function FacebookPhoto() 
		{
			
		}
		public static function GetInstance():FacebookPhoto {
			if (_instance != null) _instance = new FacebookPhoto();
			return _instance;
		}
		
		//验证是否有上传图片的权限
		public static function HasUploadPhotoPermission(Callback:Function):void
		{
			GetInstance()._HasUploadPhotoPermission(Callback);
		}
		//上传图片权限检查完成的回调函数
		private function _HasUploadPhotoPermission(Callback:Function):void
		{
			OnHasUploadPhotoPermission = Callback;
			if (InitStatus != 0)
			{
				CallbackOnHasUploadPhotoPermission(false);
				return;
			}
			//检查是否有上传图片的权限
			var call:HasAppPermission = new HasAppPermission(ExtendedPermissionValues.PHOTO_UPLOAD, fbook.uid);
            call.addEventListener(FacebookEvent.COMPLETE, onPermissionCheck_PhotoUpload);
            fbook.post(call);
		}
		private function onPermissionCheck_PhotoUpload(e:FacebookEvent):void
		{
			if(e.success && (e.data as BooleanResultData).value)
			{
				//已经有上传图片权限
				CallbackOnHasUploadPhotoPermission(true);
			}
			else
			{
				setupCallBacks();
				//未授权，则调用JS方法弹出授权窗口。
				if (ExternalInterface.available) 
				{
					ExternalInterface.call("showPermissionDialog", ExtendedPermissionValues.PHOTO_UPLOAD);
				}
				else
				{
					CallbackOnHasUploadPhotoPermission(false);
				}
			}
		}
		
		private function CallbackOnHasUploadPhotoPermission(hasUploadPhotoPermission:Boolean):void
		{
			if (OnHasUploadPhotoPermission != null)
			{
				OnHasUploadPhotoPermission(hasUploadPhotoPermission);
			}
			OnHasUploadPhotoPermission = null;
		}
		
		/*
		 * 上传图片
		 * 参数说明:
		 * Picture:图片
		 * Callback:回调函数.回调函数的参数为String. 成功:返回上传图片的URL地址. 失败:返回空
		 * */
		public static function UploadPicture(Picture:BitmapData,caption:String, Callback:Function):void
		{
			GetInstance()._UploadPicture(Picture,caption,Callback);
		}
		private function _UploadPicture(Picture:BitmapData,caption:String, Callback:Function):void
		{
			OnUploadPicture = Callback;
			if (InitStatus != 0)
			{
				CallbackOnUploadPicture(null);
				return;
			}
			UploadPhotoPost(Picture,caption);
		}

		//上传图片操作
		private function UploadPhotoPost(Picture:BitmapData,caption:String=null ) : void
		{
			var call:UploadPhoto = new UploadPhoto(Picture,null,caption);
            call.addEventListener(FacebookEvent.COMPLETE, OnUploadPhotoPost);
			fbook.post(call);
		}
				
		private function OnUploadPhotoPost(e:FacebookEvent):void
		{
			if (e.success)
			{
				var PictureUrl:PhotoUrl = new PhotoUrl();
				var aPhotoData:FacebookPhoto = e.data as FacebookPhoto;
				PictureUrl.src = aPhotoData.src;
				PictureUrl.src_big = aPhotoData.src_big;
				PictureUrl.src_small = aPhotoData.src_small;
				PictureUrl.link = aPhotoData.link;
				CallbackOnUploadPicture(PictureUrl);
			}
			else
			{
				CallbackOnUploadPicture(null);
			}
			//e.data.rawResult
		}
		
		//调用上传图片的回调函数
		private function CallbackOnUploadPicture(PictureUrl:PhotoUrl) :void
		{
			if (OnUploadPicture != null)
			{
				OnUploadPicture(PictureUrl);
			}
			OnUploadPicture = null;
		}
		
	}

}