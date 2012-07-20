package util 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Anlei
	 */
	public class coorAway
	{
		
		public static var away_obj:Object = {
			up:"up", left:"left", down:"down", right:"right",
			upLeft:"upleft", upRight:"upright",
			downLeft:"downleft", downRight:"downright"
		}
		public function coorAway() {}
		public static function isAwayString(currPoint:Point , nextPoint:Point):String{
			var _a1:String = '';
			var _a2:String = '';
			if(nextPoint.x > currPoint.x){
				_a1 = away_obj.right;
			}
			if(nextPoint.x < currPoint.x){
				_a1 = away_obj.left;
			}
			if(nextPoint.y > currPoint.y){
				_a2 = away_obj.down;
			}
			if(nextPoint.y < currPoint.y){
				_a2 = away_obj.up;
			}
			return _a2 + _a1;
			
		}
		public static function gotoPlay(_Away:String, _object:DisplayObjectContainer, _Speed:Number):void{
			switch(_Away){
				case away_obj.up:
					_object.y -= _Speed;
					break;
				case away_obj.left:
					_object.x -= _Speed;
					break;
				case away_obj.down:
					_object.y += _Speed;
					break;
				case away_obj.right:
					_object.x += _Speed;
					break;
				case away_obj.upLeft:
					_object.y -= _Speed;
					_object.x -= _Speed;
					break;
				case away_obj.upRight:
					_object.y -= _Speed;
					_object.x += _Speed;
					break;
				case away_obj.downLeft:
					_object.y += _Speed;
					_object.x -= _Speed;
					break;
				case away_obj.downRight:
					_object.y += _Speed;
					_object.x += _Speed;
					break;
			}
		}
		
		//返回弧度
		public static function getAngle(targetPoint:Point, currentPoint:Point):Number {
			var dx:Number=targetPoint.x - currentPoint.x;
			var dy:Number=targetPoint.y - currentPoint.y;
			return Math.atan2(dy,dx);
		}
		
		/*
		 * 获取当前位置到目标点的距离
		 */
		public static function getToTargetDistance(_nextPoint:Point, _curr:DisplayObjectContainer):Number {
			var dx:Number = _nextPoint.x - _curr.x;
			var dy:Number = _nextPoint.y - _curr.y;
			var distance:Number=Math.sqrt(dx * dx + dy * dy);
			return distance;
		}
		public static function moveCoor(_nextPoint:Point, _curr:DisplayObjectContainer):Boolean
		{
			var _angle:Number = getAngle(new Point(_nextPoint.x, _nextPoint.y), new Point(_curr.x, _curr.y));
			_curr.x += Math.cos(_angle) * 2;
			_curr.y += Math.sin(_angle) * 2;
			if (getToTargetDistance(_nextPoint, _curr) <= Math.max(3, 2)) {
				return false;
			}
			return true;
		}
	}

}