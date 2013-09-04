package anlei.util
{
	import flash.geom.Vector3D;

	public class IsoUtils
	{
		/**一个更精确的版本是 1.2247**/
		public static const Y_CORRECT:Number=Math.cos(-Math.PI / 6) * Math.SQRT2;

		/**
		 * 3D世界坐标变2D屏幕坐标
		 * @param 三维坐标
		 * @return 屏幕坐标点point
		 * @author 黑蜥 原始论坛 http://www.yuanshi0.cn
		 * */
		public static function isoToScreen(pos:Vector3D):Vector3D
		{
			var screenX:Number=pos.x - pos.z;
			var screenY:Number=pos.y * Y_CORRECT + (pos.x + pos.z) * .5;
			return new Vector3D(screenX, screenY, 0);
		}

		/**
		 * 2D屏幕坐标到3D世界坐标
		 * @param 2D屏幕坐标
		 * @return 三维坐标point3D
		 * @author 黑蜥 原始论坛 http://www.yuanshi0.cn
		 * */
		public static function screenToIso(point:Vector3D):Vector3D
		{
			var xpos:Number=point.y + point.x * .5;
			var ypos:Number=0;
			var zpos:Number=point.y - point.x * .5;
			return new Vector3D(xpos, ypos, zpos);
		}
	}
}