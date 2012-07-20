package 
{
	import core.AStarPathFinder;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import core.AStar;
	import core.MapTileModel;
	import util.coorAway;
	/**
	 * ...
	 * @author Anlei
	 */
	public class astartest1 extends Sprite
	{
		
		private var map01:Array = [
									[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 0, 1, 1, 0, 1, 1, 0],
									[0, 1, 1, 1, 0, 0, 1, 0, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 0, 1, 1, 1, 1, 0],
									[0, 1, 0, 0, 0, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 0, 1, 0],
									[0, 1, 1, 1, 1, 1, 0, 0, 1, 0],
									[0, 1, 0, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 0, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 0, 1, 1, 1, 1, 0],
									[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
								 ];
		private	var tileW:Number = 30;
		private	var tileH:Number = 30;
		private var content:Sprite;
		private var rote_sp:Tile;
		private var m_mapX:Number;
		private var m_mapY:Number;
		private var _away:String;
		private var _setp:Number = 0;
		private var _setpadd:int = 0;
		
		/**加入AStar**/
		
		private var astarModel:MapTileModel;
		private var astar:AStar;
		private var path:Array;
		private var _curr:int = 1;
		
		
		public function astartest1()
		{
			if (stage) inits();
			else addEventListener(Event.ADDED_TO_STAGE, inits);
		}
		
		private function inits(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, inits);
			
			content = new Sprite();
			//content.x = tileW;
			//content.y = tileH;
			addChild(content);
			
			_setp = stage.frameRate;
			
			drawMap(map01, content);
			addRote();
			
			this.astarModel = new MapTileModel();
			this.astar = new AStar(this.astarModel);
			this.astarModel.map = map01;
			
		}
		/**
		 * 绘值地图
		 * */
		private function drawMap(_map:Array, _content:Sprite):void
		{
			var _color:uint;
			for (var i:int = 0 ; i < _map.length; i++) {
				for (var j:int = 0 ; j < _map[0].length; j++) {
					if (_map[i][j] == 0) {
						_color = 0x000000;
					}else if (_map[i][j] == 1) {
						_color = 0xFFFFFF;
					}
					var _tile:Tile = new Tile(_color, tileW, tileH);
					_tile.name = 'tile_' + String(i) + '_' + String(j);
					_tile.x = j * tileW;
					_tile.y = i * tileH;
					if (_map[i][j] == 1) {
						//_tile.addEventListener(MouseEvent.MOUSE_OVER, onTileOver);
						//_tile.addEventListener(MouseEvent.MOUSE_OUT, onTileOut);
						_tile.addEventListener(MouseEvent.CLICK, onTileClick);
					}
					_content.addChild(_tile);
				}
			}
		}
		private function addRote():void {
			rote_sp = new Tile(0xFF0000, 16, 16);
			rote_sp.x = tileW * 2 + rote_sp.width / 2;
			rote_sp.y = tileH * 2 + rote_sp.height/ 2;
			addChild(rote_sp);
		}
		
		private function onTileClick(e:MouseEvent):void {
			var rotePoint:Point = getPoint(rote_sp.x, rote_sp.y);
			var findPoint:Point = getPoint(this.content.mouseX, this.content.mouseY);
			path = null;
			path = this.astar.find(rotePoint.x, rotePoint.y, findPoint.x, findPoint.y);
			_curr = 1;
			_setp += _setp - _setpadd;
			if (this.hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, onEnter);
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		private function onEnter(e:Event):void {
			_setpadd++;
			if (_setpadd >= _setp) {
				
				var sp_x:Number = path[_curr][0] * tileW + rote_sp.width / 2;
				var sp_y:Number = path[_curr][1] * tileH + rote_sp.height / 2;
				rote_sp.x = sp_x;
				rote_sp.y = sp_y;
				
				_setp = stage.frameRate;
			trace(_setp);
				_setpadd = 0;
				_curr++;
			}
			if (_curr >= path.length) {
				path = null;
				_curr = 1;
				this.removeEventListener(Event.ENTER_FRAME, onEnter);
				return;
			}
			if(_setpadd < _setp){
				_away = coorAway.isAwayString(new Point(path[_curr - 1][0], path[_curr - 1][1]), new Point(path[_curr][0], path[_curr][1]));
				coorAway.gotoPlay(_away, rote_sp, (tileW / stage.frameRate));
			}
		}
		private function getPoint(p_x : Number, p_y : Number) : Point
        {
            p_x = Math.floor((p_x) / tileW);
            p_y = Math.floor((p_y) / tileH);
            return new Point(p_x, p_y);
        }
        

	}

}

import flash.display.Sprite;
/**
 * 砖块
 */
class Tile extends Sprite {
	
	public var onf:Boolean = true;
	
	public function Tile(_color:uint = 0xFF00FF, _w:Number = 54, _h:Number = 54)
	{
		var _sp:Sprite = drawRect(_color, _w, _h);
		this.mouseChildren = false;
		addChild(_sp);
	}
	private function drawRect(_color:uint = 0xFF00FF, _w:Number = 54, _h:Number = 54):Sprite {
		var _sp:Sprite = new Sprite();
		_sp.graphics.lineStyle(1, 0x000000, 1);
		_sp.graphics.beginFill(_color);
		_sp.graphics.drawRect(0, 0, _w, _h);
		_sp.graphics.endFill();
		return _sp;
	}
}