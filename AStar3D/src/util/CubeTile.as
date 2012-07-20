package util 
{
	
	import flash.display.Sprite;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	/**
	 * 砖块
	 */
	public class CubeTile extends Cube {
		
		public var onf:Boolean = true;
		
		public function CubeTile(_color:uint = 0xFF00FF, _w:Number = 54, _d:Number = 54, _h:Number = 54)
		{
			var _material:ColorMaterial = new ColorMaterial(_color);
			var materials:MaterialsList = new MaterialsList(
			{
				all:_material
				//,front:  new MovieAssetMaterial( "Front", true ),
				//back:   new MovieAssetMaterial( "Back", true ),
				//right:  new MovieAssetMaterial( "Right", true ),
				//left:   new MovieAssetMaterial( "Left", true ),
				//top:    new MovieAssetMaterial( "Top", true ),
				//bottom: new MovieAssetMaterial( "Bottom", true )
			} );

			_material.doubleSided = true;
			_material.interactive = true;
			super(materials, _w, _d, _h);
		}
	}

}