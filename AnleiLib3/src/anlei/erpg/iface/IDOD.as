package anlei.erpg.iface
{
	import flash.display.Sprite;

	public interface IDOD
	{
		/**渲染的宽*/
		function get W():Number;
		function set W(value:Number):void;
		
		/**渲染的高*/
		function get H():Number;
		function set H(value:Number):void;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		/**所在的层*/
		function get parentLayer():Sprite;
		function set parentLayer(value:Sprite):void;
		
		function setName(value:String, $color:Number = 0x00FF00):void;
		
	}
}