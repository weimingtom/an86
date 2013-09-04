package anlei.erpg.utils
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;

	/**坐骑变色*/
	public class ColorTransformUtils
	{
		/**恢复色差*/
		public static const Reply:int = 1;
		/**紫*/
		public static const Purple:int = 2;
		/**黄*/
		public static const Yellow:int = 3;
		/**绿*/
		public static const Green:int = 4;
		/**蓝*/
		public static const Blue:int = 5;
		/////////////////////////////////////////
		/**红*/
		public static const Red:int = 6;
		/**湛蓝*/
		public static const ZBlue:int = 7;
		////////////////////////////////////
		
		private static var matrix:ColorMatrixFilter = new ColorMatrixFilter();
		private static const filter:Array = [matrix];
		
		
		/**恢复色差*/
		public static function setReply(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);//恢复
			dod.filters = null;
		}
		/**红*/
		public static function setRed(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(1,1,1,1,255,0,0,0);//红
			dod.filters = null;
		}
		/**湛蓝*/
		public static function setZBlue(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(0,1,1,1,0,0,50,0);//占蓝
			dod.filters = null;
		}
		/**紫*/
		public static function setPurple(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(1,0.5,1,1,0,0,50,0);//紫
			matrix.matrix = [0.23697009682655334,1.887271523475647,-0.9442417621612549,0,-11.429999351501465,0.15841537714004517,0.5922026634216309,0.4293818771839142,0,-11.430000305175781,1.2133039236068726,0.2652386426925659,-0.29854267835617065,0,-11.430000305175781,0,0,0,1,0];
			dod.filters = null;
			dod.filters = filter;
		}
		/**黄*/
		public static function setYellow(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(1,1,0,1,0,0,50,0);//黄
			matrix.matrix = [1.18125319480896,0.5348843336105347,-0.5361374616622925,0,-11.430000305175781,-0.050696827471256256,1.0523443222045898,0.1783524751663208,0,-11.430001258850098,0.49800315499305725,-0.3088156282901764,0.9908123016357422,0,-11.429999351501465,0,0,0,1,0];
			dod.filters = null;
			dod.filters = filter;
		}
		/**绿*/
		public static function setGreen(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(0,1,0,1,0,0,50,0);//绿
			matrix.matrix = [0.9646761417388916,-0.2910739779472351,0.5063977837562561,0,-11.430000305175781,0.10400077700614929,1.2183446884155273,-0.14234550297260284,0,-11.430000305175781,-0.3942083716392517,0.47498953342437744,1.099218726158142,0,-11.429999351501465,0,0,0,1,0];
			dod.filters = null;
			dod.filters = filter;
		}
		/**蓝*/
		public static function setBlue(dod:DisplayObject):void{
			//dod.transform.colorTransform = new ColorTransform(0,1,1,1,-250,-100,100,0);//蓝
			matrix.matrix = [-0.525566577911377,1.9337166547775269,-0.22815020382404327,0,-11.429999351501465,0.4255151152610779,0.47053441405296326,0.2839503586292267,0,-11.429999351501465,0.8187880516052246,1.3290066719055176,-0.9677948355674744,0,-11.429999351501465,0,0,0,1,0];
			dod.filters = null;
			dod.filters = filter;
		}
	}
}