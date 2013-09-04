package anlei.util
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**@author Anlei*/
	public class CoorAway
	{
		
		public static const up:String = 'up';
		public static const left:String = 'left';
		public static const down:String = 'down';
		public static const right:String = 'right';
		
		public static const upLeft:String = 'upleft';
		public static const upRight:String = 'upright';
		public static const downLeft:String = 'downleft';
		public static const downRight:String = 'downright';
		
		/**
		 * 以角色坐标和下一点的坐标来计算出角色的方向
		 * @param currPoint
		 * @param nextPoint
		 * @return 
		 * 
		 */		
		public static function isAwayString(currPoint:Point , nextPoint:Point):String{
			var _a1:String = '';
			var _a2:String = '';
			if(nextPoint.x > currPoint.x){
				_a1 = right;
			}
			if(nextPoint.x < currPoint.x){
				_a1 = left;
			}
			if(nextPoint.y > currPoint.y){
				_a2 = down;
			}
			if(nextPoint.y < currPoint.y){
				_a2 = up;
			}
			return _a2 + _a1;
			
		}
		/**
		 * 返回旋转度
		 */
		public static function getRotation(targetPoint:Point, currentPoint:Point):Number {
			return getAngle(targetPoint,currentPoint)*(180/Math.PI)+90;
		}
		/**
		 * 返回两点间的距离
		 */
		public static function getAngle(targetPoint:Point, currentPoint:Point):Number {
			var dx:Number=targetPoint.x - currentPoint.x;
			var dy:Number=targetPoint.y - currentPoint.y;
			return Math.atan2(dy,dx);
		}
		
		/**
		 * 获取当前位置到目标点的距离
		 */
		public static function getToTargetDistance(_nextPoint:Point, _currPoint:Point):Number {
			var dx:Number = _nextPoint.x - _currPoint.x;
			var dy:Number = _nextPoint.y - _currPoint.y;
			var distance:Number=Math.sqrt(dx * dx + dy * dy);
			return distance;
		}
		/**
		 * 角色走向目标
		 * @param speed			速度
		 * @param _nextPoint	目地坐标
		 * @param _curr			角色
		 * @return 				是否到目的地, false(已到目的地)  true(未到目的地)
		 * 
		 */		
		public static function moveCoor(speed:Number, _nextPoint:Point, _curr:Object):Boolean
		{
			//如果到目的地时
			if(_nextPoint.x == _curr.x && _nextPoint.y == _curr.y) return false;
			var _point:Point = new Point(_curr.x, _curr.y);
			var _angle:Number = getAngle(_nextPoint, _point);
			_curr.x += Math.cos(_angle) * speed;
			_curr.y += Math.sin(_angle) * speed;
			_point.x = _curr.x;
			_point.y = _curr.y;
			//大约到达目的地时
			var _dist:Number = getToTargetDistance(_nextPoint, _point);
			if (_dist <= speed*2/3) return false;
			return true;
		}
	}

}
