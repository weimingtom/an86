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
	public class view3d extends BasicView
	{
		public function view3d() 
		{
			super(200, 200, false, true, CameraType.FREE);
			if (stage) initSet();
			else addEventListener(Event.ADDED_TO_STAGE, initSet);
		}
		
		private function initSet(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initSet);
			//
			var _material:ColorMaterial = new ColorMaterial(0x00FFFF);
			var _plane:Plane = new Plane(_material, 200, 100);
			scene.addChild(_plane);
			startRendering();
		}
		
	}

}