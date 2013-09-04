package anlei.util
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class ScaleBitmap
	{
		//--------------------------------------
		//  PUBLIC
		//--------------------------------------
		
		/**
		 * @param bitmapData BitmapData source
		 * @param graphics Graphics to draw
		 * @param width Draw width
		 * @param height Draw height
		 * @param inner Inner rectangle (relative to 0,0)
		 * @param outer Outer rectangle (relative to 0,0)
		 * @param smooth If <code>false</code>, upscaled bitmap images are rendered by using a nearest-neighbor 
		 * algorithm and look pixelated. If <code>true</code>, upscaled bitmap images are rendered by using a 
		 * bilinear algorithm. Rendering by using the nearest neighbor algorithm is usually faster.
		 */
		public static function draw(bitmapData:BitmapData,
									graphics:Graphics,
									width:int,
									height:int,
									inner:Rectangle,
									outer:Rectangle = null,
									smooth:Boolean = false):void
		{
			// some useful local vars
			var x:int, y:int;
			var ox:int = 0, oy:int;
			var dx:int = 0, dy:int;
			var wid:int, hei:int;
			var dwid:int, dhei:int;
			var sw:int = bitmapData.width;
			var sh:int = bitmapData.height;
			
			var mat:Matrix = new Matrix();
			
			var widths:Array = [inner.left + 1,
				inner.width - 2,
				sw - inner.right + 1];
			
			var heights:Array = [inner.top + 1,
				inner.height - 2,
				sh - inner.bottom + 1];
			
			var rx:int = width - widths[0] - widths[2];
			var ry:int = height - heights[0] - heights[2];
			var ol:int = (outer != null) ? -outer.left : 0;
			var ot:int = (outer != null) ? -outer.top : 0;
			
			// let's draw
			for (x; x < 3 ;x++)
			{
				// original width
				wid = widths[x];
				// draw width						
				dwid = x==1 ? rx : wid;
				// original & draw offset
				dy = oy = 0;
				mat.a = dwid / wid;
				
				for (y = 0; y < 3; y++)
				{
					// original height
					hei = heights[y];
					// draw height
					dhei = y==1 ? ry : hei;
					
					if (dwid > 0 && dhei > 0)
					{
						// some matrix computation
						mat.d = dhei / hei;
						mat.tx = -ox * mat.a + dx;
						mat.ty = -oy * mat.d + dy;
						mat.translate(ol, ot);
						
						// draw the cell
						graphics.beginBitmapFill(bitmapData, mat, false, smooth);
						graphics.drawRect(dx + ol, dy + ot, dwid, dhei);
					}
					
					// offset incrementation
					oy += hei;
					dy += dhei;
				}
				
				// offset incrementation
				ox += wid;
				dx += dwid;
			}
			
			graphics.endFill();
		}
	}
}