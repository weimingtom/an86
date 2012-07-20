package util 
{
	
	import flash.display.Sprite;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.Plane;
	/**
	 * 砖块
	 */
	public class Tile extends Plane {
		
		public var onf:Boolean = true;
		
		public function Tile(_color:uint = 0xFF00FF, _w:Number = 54, _h:Number = 54)
		{
			var _material:ColorMaterial = new ColorMaterial(_color);
			_material.interactive = true;
			_material.doubleSided = true;
			_material.lineAlpha = 1;
			_material.lineColor = 0x00FF00;
			super(_material, _w, _h);
		}
	}

}