package view 
{
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.layer.util.ViewportLayerSortMode;
	import org.papervision3d.view.Viewport3D;
	/**
	 * ...
	 * @author Anlei
	 */
	public class BotDisplayObject extends DisplayObject3D
	{
		private var bot_obj3d_arr:Array;
		private var bot_material_arr:Array;
		
		public function BotDisplayObject() 
		{
			inits();
		}
		
		private function inits():void
		{
			bot_obj3d_arr = new Array();
			bot_material_arr = new Array();
			
			for (var i:int = 0 ; i < 6; i++) {
				for (var j:int = 0 ; j < 6; j++) {
					var _material:ColorMaterial = new ColorMaterial();
					_material.interactive = true;
					_material.doubleSided = true;
					_material.lineAlpha = 1;
					_material.lineColor = 0x00FF00;
					var _plane:Plane = new Plane(_material, 100, 100);
					_plane.x = (100+6) * j;
					_plane.y = (100+6) * i;
					//_plane.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, onTileOver);
					//_plane.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, onTileOut);
					//_plane.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, onTileClick);
					bot_material_arr.push(_material);
					bot_obj3d_arr.push(_plane);
					this.addChild(_plane);
				}
			}
		}
		public function get planeArr():Array {
			return bot_obj3d_arr;
		}
		
		public function get materialArr():Array {
			return bot_material_arr;
		}
		
	}

}