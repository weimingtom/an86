package ui.component
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import anlei.util.PublicProperty;
	
	public class SingleShowNum extends Sprite
	{
		public function SingleShowNum(val:String, sourceKey:String, prefix:String)
		{
			if(!prefix)
				prefix="";
			var result:DisplayObject;
			_char=val;
			var key:String;
			if(!isNaN(Number(val)))
				key = "num_"+val;
			else if(val=="+")
				key = "positive";
			else if(val=="-")
				key = "negative";
			
			if(!key)
				throw new Error("非数字!!");
			
			result = PublicProperty.GetSourceMC(prefix+key,sourceKey);
			
			if(result) addChild(result);
		}
		
		private var _char:String;
		
		public function get char():String
		{
			return _char;
		}
	}
}