package tool
{
    import flash.display.Sprite;

    public class GuideMask extends Sprite
    {
        private static const GAME_WIDTH:Number = 960;
        private static const GAME_HEIGHT:Number = 560;
        private var _posX:Number;//显示对象的坐标
        private var _posY:Number;
        private var _sprWidth:Number;//显示对象的宽高
        private var _sprHeight:Number;
        
        public function GuideMask(posX:Number, posY:Number, sprWidth:Number, sprHeight:Number){
            reset(posX, posY, sprWidth, sprHeight);
        }
		
		public function reset(posX:Number, posY:Number, sprWidth:Number, sprHeight:Number){
			graphics.clear();
            _posX = posX;
            _posY = posY;
            _sprWidth = sprWidth;
            _sprHeight = sprHeight;
            createSpr();
		}
        
        private function createSpr():void {
			newSpr("left");
            newSpr("right");
            newSpr("up");
            newSpr("down");
        }
        
        private function newSpr(position:String):void {
            var sprWidth:Number;
            var sprHeight:Number;
            var x:Number;
            var y:Number;
            switch(position)
            {
                case "left":
                    sprWidth = _posX;
                    sprHeight = GAME_HEIGHT;
                    x = 0;
                    y = 0;
                    break;
                case "right":
                    sprWidth = GAME_WIDTH - _posX - _sprWidth;
                    sprHeight = GAME_HEIGHT;
                    x = _posX + _sprWidth;
                    y = 0;
                    break;
                case "up":
                    sprWidth = _sprWidth;
                    sprHeight = _posY;
                    x = _posX;
                    y = 0;
                    break;
                case "down":
                    sprWidth = _sprWidth;
                    sprHeight = GAME_HEIGHT - _posY - _sprHeight;
                    x = _posX;
                    y = _posY + _sprHeight;
                    break;
                default:
                    break;
            }
            
            graphics.beginFill(0x0, 0.5);
            graphics.drawRect(x, y, sprWidth, sprHeight);
            graphics.endFill();
        }
		public function dispose():void{
			this.graphics.clear();
		}
    }
}