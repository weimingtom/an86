package tool
{

    /**
     * 新手引导遮罩管理类
     * 用法:
		GuideMaskManager.instance.data = {x:60, y:123, width:90, height:32};
		addChild(GuideMaskManager.instance.mask);
		GuideMaskManager.instance.data = {x:60, y:123, width:190, height:32};
     */
    public class GuideMaskManager
    {

        public function GuideMaskManager(singeton:Singeton) { }
        private static var s_instance:GuideMaskManager;
		public static function get instance():GuideMaskManager {
            if (s_instance == null) s_instance = new GuideMaskManager(new Singeton);
            return s_instance;
        }
		
        private var guideMask:GuideMask;
		
        public function set data(object:Object):void{
            if(!guideMask){
                guideMask = new GuideMask(object.x, object.y, object.width, object.height);
            }else{
				guideMask.reset(object.x, object.y, object.width, object.height);
			}
        }

        public function get mask():GuideMask{ return guideMask; }
    }
}

class Singeton{}