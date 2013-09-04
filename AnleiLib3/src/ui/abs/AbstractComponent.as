package ui.abs
{
	public interface AbstractComponent
	{
		/**
		 * 释放资源
		 */
		function dispose():void;
		
		/** 改变组件尺寸
		 * @param _width	宽
		 * @param _height	高
		 */
		function setSize(_width:Number, _height:Number):void;
		
		/** 改变组件的坐标
		 * @param _x	横轴
		 * @param _y	纵轴
		 */
		function move(_x:Number, _y:Number):void;
		
	}
	
}