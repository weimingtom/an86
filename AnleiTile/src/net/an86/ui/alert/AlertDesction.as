package net.an86.ui.alert
{
	import flash.display.Bitmap;
	
	import net.an86.tile.ATGame;

	/**显示描述*/
	public class AlertDesction
	{
		private static var bitmap:Bitmap;
		private static var face:AlertFace;
		
		public static function show(text:String, x:int = -1, y:int = -1):void{
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
			bitmap.x = x == -1 ? 10 : x;
			bitmap.y = y == -1 ? 10 : y;
			ATGame.root.addChild(bitmap);
		}
		
		public static function hide():void{
			if(ATGame.root.contains(bitmap)){
				ATGame.root.removeChild(bitmap);
			}
		}

	}
}