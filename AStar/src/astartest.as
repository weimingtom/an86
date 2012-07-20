package 
{
	import core.AStarPathFinder;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import core.AStar;
	import core.MapTileModel;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import util.coorAway;
	/**
	 * ...
	 * @author Anlei
	 */
	public class astartest extends Sprite
	{
		public static var rote_mc:MovieClip = new MovieClip();
		private var map01:Array = [
									[0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 0, 1, 1, 0, 1, 1,1, 1, 0, 1, 1, 0, 1, 1,1, 1, 0, 1, 1, 0, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1, 0],
									[0, 1, 0, 0, 0, 1, 1, 1, 1,1, 0, 0, 0, 1, 1, 1, 1,1, 0, 0, 0, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 0, 1,1, 1, 1, 1, 1, 1, 0, 1,1, 1, 1, 1, 1, 1, 0, 1, 0],
									[0, 1, 1, 1, 1, 1, 0, 0, 1,1, 1, 1, 1, 1, 0, 0, 1,1, 1, 1, 1, 1, 0, 0, 1, 0],
									[0, 1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 0, 1, 1, 0, 1, 1,1, 1, 0, 1, 1, 0, 1, 1,1, 1, 0, 1, 1, 0, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1, 0],
									[0, 1, 0, 0, 0, 1, 1, 1, 1,1, 0, 0, 0, 1, 1, 1, 1,1, 0, 0, 0, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 1, 1, 1, 0, 1,1, 1, 1, 1, 1, 1, 0, 1,1, 1, 1, 1, 1, 1, 0, 1, 0],
									[0, 1, 1, 1, 1, 1, 0, 0, 1,1, 1, 1, 1, 1, 0, 0, 1,1, 1, 1, 1, 1, 0, 0, 1, 0],
									[0, 1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1,1, 0, 1, 1, 1, 1, 1, 1, 0],
									[0, 1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1,1, 1, 1, 0, 1, 1, 1, 1, 0],
									[0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0]
								 ];
		private	var tileW:Number = 30;
		private	var tileH:Number = 30;
		private var content:Sprite;
		private var rote_sp:Rote;
		private var m_mapX:Number;
		private var m_mapY:Number;
		private var _time:Timer = new Timer(40);
		private var _away:String;
		
		/**加入AStar**/
		
		private var astarModel:MapTileModel;
		private var astar:AStar;
		private var path:Array;
		private var _curr:int;
		
		
		public function astartest() 
		{
			if (stage) inits();
			else addEventListener(Event.ADDED_TO_STAGE, inits);
		}
		
		private function inits(e:Event = null):void
		{
			content = new Sprite();
			//content.x = tileW;
			//content.y = tileH;
			addChild(content);
			
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
			rote_sp = new Rote();
			rote_sp.x = tileW * 2 + tileW / 2;
			rote_sp.y = tileH * 2 + tileH / 2;
			rote_sp.addChild(rote_mc);
			rote_sp.MC = rote_mc;
			rote_sp.MC.mouseEnabled = false;
			rote_sp.MC.gotoAndStop(1);
			addChild(rote_sp);
		}
		
		private var onTileClick_onf:Boolean = false;
		private function onTileClick(e:MouseEvent):void {
			var _num:Number = getTimer();
			
			var rotePoint:Point = getPoint(rote_sp.x, rote_sp.y);
			var findPoint:Point = getPoint(this.content.mouseX, this.content.mouseY);
			path = null;
			path = this.astar.find(rotePoint.x, rotePoint.y, findPoint.x, findPoint.y);
			_num = getTimer() - _num;
			trace(_num);
			//this.addEventListener(Event.ENTER_FRAME, onEnter);
			
			if (_time.hasEventListener(TimerEvent.TIMER)) {
				_time.removeEventListener(TimerEvent.TIMER, onTimer);
			}
			_curr = 0;
			onTileClick_onf = false;
			_time.addEventListener(TimerEvent.TIMER, onTimer);
			_time.start();
		}
		private function onTimer(e:TimerEvent):void 
		{
			if (this.path == null || this.path.length <= 0) {
				_time.stop();
				rote_sp.MC.gotoAndStop(1);
				return;
			}
			
			var sp_x:Number = path[0][0] * tileW + tileW / 2;
			var sp_y:Number = path[0][1] * tileH + tileH / 2;
			if(onTileClick_onf == false){
				onTileClick_onf = true;
				sp_x = rote_sp.x;
				sp_y = rote_sp.y;
			}
			var _onf:Boolean = coorAway.moveCoor(new Point(sp_x, sp_y), rote_sp);
			
			if (!_onf) {
				if(this.path.length > 1){
					_away = coorAway.isAwayString(new Point(path[0][0], path[0][1]), new Point(path[1][0], path[1][1]));
					switch(_away){
						case coorAway.away_obj.up:
							rote_sp.MC.gotoAndPlay('up');
							break;
						case coorAway.away_obj.left:
							rote_sp.MC.gotoAndPlay('left');
							break;
						case coorAway.away_obj.down:
							rote_sp.MC.gotoAndPlay('down');
							break;
						case coorAway.away_obj.right:
							rote_sp.MC.gotoAndPlay('right');
							break;
						case coorAway.away_obj.upLeft:
							rote_sp.MC.gotoAndPlay('leftUp');
							break;
						case coorAway.away_obj.upRight:
							rote_sp.MC.gotoAndPlay('rightUp');
							break;
						case coorAway.away_obj.downLeft:
							rote_sp.MC.gotoAndPlay('leftDown');
							break;
						case coorAway.away_obj.downRight:
							rote_sp.MC.gotoAndPlay('rightDown');
							break;
					}
				}
				this.path.shift();
			}
		}
		
		private function onEnter(e:Event):void {
			//var sp_x:Number = path[0][0] * tileW + rote_sp.width / 2;
			//var sp_y:Number = path[0][1] * tileH + rote_sp.height / 2;
            //rote_sp.x -= (rote_sp.x - sp_x)/6;
            //rote_sp.y -= (rote_sp.y - sp_y)/6;
			///coorAway.gotoPlay(_away, rote_sp, tileW / stage.frameRate);
		}
		/**private function onTimer(e:TimerEvent):void {
			_curr++;
			if (_curr >= path.length) {
				_away = '';
				_time.stop();
                //this.removeEventListener(Event.ENTER_FRAME, onEnter);
				_time.removeEventListener(TimerEvent.TIMER, onTimer);
				return;
			}
			_away = coorAway.isAwayString(new Point(path[_curr - 1][0], path[_curr - 1][1]), new Point(path[_curr][0], path[_curr][1]));
			
			var sp_x:Number = path[_curr-1][0] * tileW + rote_sp.width / 2;
			var sp_y:Number = path[_curr-1][1] * tileH + rote_sp.height / 2;
            rote_sp.x = (sp_x);
            rote_sp.y = (sp_y);
		}*/
		private function getPoint(p_x : Number, p_y : Number) : Point
        {
            p_x = Math.floor((p_x) / tileW);
            p_y = Math.floor((p_y) / tileH);
            return new Point(p_x, p_y);
        }
        
	}

}

import flash.display.Sprite;
import flash.display.MovieClip;

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

class Rote extends Sprite {
	public var MC:MovieClip;
}