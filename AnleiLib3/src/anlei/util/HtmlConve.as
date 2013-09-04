package anlei.util
{
	import com.adobe.utils.StringUtil;

	public class HtmlConve
	{
		/**将value转成<font color="#FF3300">这里是有色文字</font>
		 * @param value	<#FF3300>这里是有色文字</#>
		 */
		public static function color(value:String):String{
			value = StringUtil.replace(value, "</#>", '</font>');
			var _arr:Array = value.split("<#");
			var _len:int = _arr.length;
			for (var i:int = 0; i < _len; i++) {
				var fir:Number = String(_arr[i]).indexOf(">");
				var end:Number = String(_arr[i]).indexOf("</font>");
				if(fir>0){
					var color_str:String = String(_arr[i]).substr(0, fir);
					if(Number("0x" + color_str) > 0){
						var cont_str:String = String(_arr[i]).substr(fir+1, end);
						var end_str:String = String(_arr[i]).substr(end+7);
						color_str = '<font color="#' + color_str + '">' + cont_str + end_str;
						_arr[i] = color_str;
					}
				}
			}
			value = String(_arr);
			value = StringUtil.replace(value, ",", '');
			return value;
		}
		
		/**将value转成<b>这里是有加粗的文字</b>
		 * @param value	{b}这里是有色文字{/b}
		 
		public static function b(value:String):String{
			value = StringUtil.replace(value, "{b}", '<b>');
			value = StringUtil.replace(value, "{/b}", '</b>');
			return value;
		}*/
		
	}
}