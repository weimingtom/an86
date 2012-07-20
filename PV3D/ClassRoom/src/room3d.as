package  
{
	import flash.events.Event;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	/**
	 * ...
	 * @author Anlei
	 */
	public class room3d extends BasicView
	{
		public function room3d() 
		{
			super(100, 100, false, true);
			if (stage) initSet();
			else addEventListener(Event.ADDED_TO_STAGE, initSet);
		}
		
		private function initSet(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initSet);
			//
			//camera.zoom = 1;
			//camera.focus = 1000;
			var _material:ColorMaterial = new ColorMaterial();
			var _plane:Plane = new Plane(_material, 4000, 50);
			scene.addChild(_plane);
			startRendering();
		}
		
	}

}