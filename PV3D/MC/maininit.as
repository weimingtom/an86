package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.special.MovieParticleMaterial;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.objects.special.ParticleField;
	import org.papervision3d.view.BasicView;
	
	/**
	 * ...
	 * @author Anlei
	 */
	public class maininit extends BasicView
	{
		private var _plane:Plane;
		private var partic:ParticleField;
		
		public function maininit() {
			super(800, 600, true, true);
			if (stage) initSet();
			else addEventListener(Event.ADDED_TO_STAGE, initSet);
		}
		
		private function initSet(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initSet);
			camera.zoom = 1;
			camera.focus = 1000;
			var _mc:MovieClip = new mc();
			var _mater:MovieMaterial = new MovieMaterial(_mc, true, true, true);
			_mater.smooth = true;
			//_mater.doubleSided = true;
			//_mater.interactive = true;
			//_mc.addEventListener(MouseEvent.CLICK, onClick);
			_plane = new Plane(_mater, _mc.width, _mc.height);
			//_plane.x = -10;
			//_plane.y = -10;
			
			var mc_mat:MovieParticleMaterial = new MovieParticleMaterial(new mc(), true, true);
			var particles:Particles = new Particles();
			var particle:Particle = new Particle(mc_mat,1);
			particles.addParticle(particle)
			
			scene.addChild(particles);
			
			
			scene.addChild(_plane);
			startRendering();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace(e);
		}
		
		override protected function onRenderTick(e:Event = null):void 
		{
			camera.y += 10;
			super.onRenderTick(e);
		}
	}
	
}