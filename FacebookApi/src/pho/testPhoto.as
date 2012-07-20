package pho
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import pho.FacebookPhoto;
	/**
	 * ...
	 * @author 
	 */
	public class testPhoto extends Sprite
	{
		
		public function testPhoto() 
		{
			if (stage) inits();
			else addEventListener(Event.ADDED_TO_STAGE, inits);
		}
		
		private function inits(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, inits);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			
			var bitPicData:BitmapData = new BitmapData(100, 100);
			bitPicData.draw(CreateAlphaSP(false, 100, 100, 2, 2, 0xFF0000, 1));
				
			FacebookPhoto.UploadPicture(bitPicData , "" , OnUploadPhoto) ;
			
		}
		
		
		private function OnUploadPhoto(url:PhotoUrl) :void
		{
			if (url != null)
			{
				//discribe.text = 'Upload Ok : ' + url.src;
			}
			else
			{
				//discribe.text = 'Upload failed ';
			}
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