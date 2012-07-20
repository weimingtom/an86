package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import core.AStar;
	import core.MapTileModel;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.layer.ViewportBaseLayer;
	import org.papervision3d.objects.DisplayObject3D;
	import util.CubeTile;
	import util.MouseControl;
	
	import util.Tile;
	import util.MapData;
	/**
	 * ...
	 * @author Anlei
	 */
	public class astartest extends BasicView
	{
		
		private var map:Array;
		private	var tileW:Number = 30;
		private	var tileD:Number = 14;
		private	var tileH:Number = 30;
		private var rote_sp:CubeTile;
		
		private var rotaContent:DisplayObject3D;
		private var content:DisplayObject3D;
		
		/**加入AStar**/
		
		private var astarModel:MapTileModel;
		private var astar:AStar;
		private var path:Array;
		
		
		public function astartest() 
		{
			super(800, 600, true, true, CameraType.FREE);
			if (stage) inits();
			else addEventListener(Event.ADDED_TO_STAGE, inits);
		}
		
		private function inits(e:Event = null):void
		{
			content = new DisplayObject3D();
			rotaContent = new DisplayObject3D();
			//rotaContent.rotationY = 40;
			rotaContent.rotationX = 45;
			
			scene.addChild(rotaContent);
			rotaContent.addChild(content);
			
			map = MapData.map01;
			drawMap(map, content);
			addRote();
			this.astarModel = new MapTileModel();
			this.astar = new AStar(this.astarModel);
			this.astarModel.map = map;
			
			//camera.y = -1200;
			//camera.x = -400;
			//camera.zoom = 100;
			//camera.zoom = rotaContent.z + Math.abs(camera.z);
			//camera.focus = rotaContent.z + Math.abs(camera.z);
			camera.moveForward(650);
			
			startRendering();
			content.x = -(tileW * map[0].length) / 2;
			content.y = (tileH * map.length) / 2;
			new MouseControl(rotaContent, this, true);
		}
		/**
		 * 绘值地图
		 * */
		private function drawMap(_map:Array, _content:DisplayObject3D):void
		{
			var _color:uint;
			var _tile:DisplayObject3D;
			for (var i:int = 0 ; i < _map.length; i++) {
				for (var j:int = 0 ; j < _map[0].length; j++) {
					if (_map[i][j] == 0) {
						_color = 0x000000;
						_tile = new CubeTile(_color, tileW, tileD, tileH);
						_tile.material.interactive = false;
						//_tile.material.fillAlpha = .3;
						_tile.z = -tileD / 2;
					}else if (_map[i][j] == 1) {
						_color = 0xFFFFFF;
						_tile = new Tile(_color, tileW, tileH);
					}
					_tile.name = 'tile_' + String(i) + '_' + String(j);
					_tile.x = j * tileW;
					_tile.y = -i * tileH;
					if (_map[i][j] == 1) {
						_tile.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, onTileOver);
						_tile.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, onTileOut);
						_tile.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, onTileClick);
					}
					_content.addChild(_tile);
				}
			}
		}
		private function addRote():void {
			rote_sp = new CubeTile(0xFF0000, tileW, tileD*2, tileH);
			rote_sp.name = 'anleifff';
			rote_sp.x = tileW * 2;
			rote_sp.y = -tileH;
			rote_sp.z = -tileH / 2;
			rote_sp.material.interactive = false;
			content.addChild(rote_sp);
		}
		
		private function onTileClick(e:InteractiveScene3DEvent):void {
			//var ray:Number3D = camera.unproject(viewport.containerSprite.mouseX, viewport.containerSprite.mouseY);
			//ray = Number3D.add(ray, new Number3D(camera.x, camera.y, camera.z));
			var rotePoint:Point = getPoint(rote_sp.x, -rote_sp.y);
			var findPoint:Point = getPoint(e.target.x, -e.target.y);
			path = this.astar.find(rotePoint.x, rotePoint.y, findPoint.x, findPoint.y);
			this.addEventListener(Event.ENTER_FRAME, onEnter);
			
			
		}
		private function onTileOver(e:InteractiveScene3DEvent):void {
			e.target.material.fillAlpha = .5;
		}
		private function onTileOut(e:InteractiveScene3DEvent):void {
			e.target.material.fillAlpha = 1;
		}
		
		private function onEnter(e:Event):void {
			if (this.path == null || this.path.length == 0)
            {
                this.removeEventListener(Event.ENTER_FRAME, onEnter);
                return;
            }

			var note : Array = this.path.shift() as Array;
			this.rote_sp.x = note[0] * tileW;
			this.rote_sp.y = -(note[1] * tileH);
		}
		
		private function getPoint(p_x : Number, p_y : Number) : Point
        {
            p_x = Math.floor((p_x) / tileW);
            p_y = Math.floor((p_y) / tileH);
            return new Point(p_x, p_y);
        }
        
		override protected function onRenderTick(e:Event = null):void 
		{
			//var pan:Number = camera.rotationY - 210 * viewport.mouseX/(stage.stageWidth/2);
			//pan = Math.max( -100, Math.min( pan, 100 ) ); // Max speed
			//camera.rotationY -= pan / 12;
			//var tilt:Number = 90 * viewport.mouseY/300;
			//camera.rotationX -= (camera.rotationX + tilt) / 12;
			//trace(viewport.mouseX,viewport.mouseY);
			
			super.onRenderTick(e);
		}
	}

}
