package net.an86.ui.alert
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	
	import net.an86.tile.ATGame;

	/**对话框*/
	public class Alert
	{
		private static var bitmap:Bitmap;
		private static var face:AlertFace;
		public static var reText:String;
		private static var tween:TweenLite;
		
		public static function show($text:String, isTween:Boolean = false):void{
			if(!isTween){
				reText = $text;
			}
			if(!face){
				face = new AlertFace();
			}
			if(!bitmap){
				bitmap = new Bitmap();
			}
			if(bitmap.bitmapData){
				bitmap.bitmapData.dispose();
			}
			bitmap.bitmapData = face.setText($text);
			bitmap.x = ATGame.centerx-bitmap.width/2;
			bitmap.y = ATGame.root.stage.stageHeight-bitmap.height - 2;
			ATGame.root.addChild(bitmap);
			
			if(isTween && reText){
				if(tween) tween.kill();
				tween = TweenLite.delayedCall(3, onTweenShow);
			}
		}
		
		public static function hide():void{
			if(ATGame.root.contains(bitmap)){
				ATGame.root.removeChild(bitmap);
			}
			reText = '';
		}
		
		private static function onTweenShow():void {
			if(isShow){
				show(reText);
			}
		}
		
		/**获取对话框是否显示*/
		public static function get isShow():Boolean {
			var _isShow:Boolean = false;
			if(bitmap && ATGame.root.contains(bitmap)){
				_isShow = true;
			}
			return _isShow;
		}

	}
}