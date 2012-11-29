package net.an86.ui.alert
{
	import flash.display.Bitmap;
	
	import net.an86.tile.ATGame;

	/**显示描述*/
	public class AlertDesction
	{
		private static var bitmap:Bitmap;
		private static var face:AlertFace;
		
		public static function show(text:String):void{
			if(!face){
				face = new AlertFace();
			}
			if(!bitmap){
				bitmap = new Bitmap();
			}
			if(bitmap.bitmapData){
				bitmap.bitmapData.dispose();
			}
			bitmap.bitmapData = face.setText(text);
			bitmap.x = 10;
			bitmap.y = 10;
			ATGame.root.addChild(bitmap);
		}
		
		public static function hide():void{
			if(ATGame.root.contains(bitmap)){
				ATGame.root.removeChild(bitmap);
			}
		}

	}
}