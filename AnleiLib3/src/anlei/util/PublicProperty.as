package anlei.util
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	public class PublicProperty
	{
		/**  assets/config.xml 配置文档  */
		public static var CONFIG_XML:XML;
		
		/** 编译的版本号 */		
		public static var BUILDER_VERSION:String;
		
		/**  assets/keyfilter 聊天关键字过滤文档  */		
		public static var KEY_FILTER:String;
		
		/**资源加载**/
		public static var source:LoaderSource;
		
		
		/****-----------以上是属性，以下是方法-------------***/
		
		/** 返回一个SWF
		 * @param key	Bulk名的Key */
		public static function GetSourceContent(key:String):*{
			return PublicProperty.source.Bulk.getContent(key);
		}
		
		/**返回一个剪辑**/
		public static function GetSourceMC(_class:String, _swfkey:String = 'ui'):*{
			
			if(source == null){
				try{
					var o:Object = getDefinitionByName(_class);
					if(o){
						var ClassReference:Class = o as Class;
						return new ClassReference;
					}
				}catch(e:Event){
					trace(e);
				}
			}
			
			var reSwfKey:LoadingItem = source.Bulk.get(_swfkey);
			if(reSwfKey == null) return null;
			return reSwfKey.getDefinition(_class);
		}
		/**
		 * 返回一个SWF库类
		 * @param _class	类名
		 * @param _swfkey	Bulk名的Key
		 * @return 类名
		 */
		public static function GetSourceMCClass(_class:String, _swfkey:String):Class {
			if(!source || !source.Bulk) return null;
			var _obj:Object = source.Bulk.get(_swfkey);
			if(!_obj) return null;
			var reSwfKey:ImageItem = _obj as ImageItem;
			if(reSwfKey == null) return null;
			return reSwfKey.getDefinitionByName(_class) as Class;
		}
		
		/** 获取MC中的Bitmap */
		public static function getBitmap(_class:String, _swfkey:String):Bitmap {
			var obj :Class = GetSourceMCClass(_class, _swfkey);
			if(obj == null) return null;
			var aa:* = new obj(0,0);
			var bitmap :Bitmap = new Bitmap(aa);
			
			return bitmap;
		}
		
		/** 获取MC中的BitmapData */
		public static function getBitmapData(_class:String, _swfkey:String):BitmapData {
			var obj :Class = GetSourceMCClass(_class, _swfkey);
			if(obj == null) return null;
			var bd:BitmapData = new obj(0, 0) as BitmapData;
			return bd;
		}
		
		/**返回一个Loader**/
		public static function GetLoader(_key:String):Loader{
			return source.Bulk.getDisplayObjectLoader(_key);
		}
		/**返回一个XML**/
		public static function GetSourceXML(_xmlkey:String):XML{
			return source.Bulk.getXML(_xmlkey);
		}
		/**返回一个声音**/
		public static function GetSound(_key:String, clearMemory:Boolean=false):Sound{
			return source.Bulk.getSound(_key, clearMemory);
		}
		
		/** 获取一个文本文件内容 */		
		public static function GetSourceString(_key:String):String{
			return source.Bulk.getText(_key);
		}
		public static function removeSource(_key:String, onf:Boolean = false):void{
			source.Bulk.remove(_key, onf);
		}
		
		/**移除所有子级**/
		public static function removeChildAll(_sp:Sprite):void {
			var _len:int = _sp.numChildren;
			for (var i:int = 0; i < _len; i ++) {
				_sp.removeChildAt(0);
			}
		}
		/**文字描边*/
		public static function TextFilter(_color:uint = 0x000000, _alpha:Number = 1):Array
		{
			return [new GlowFilter(_color,_alpha,2,2,10,1)];
		}
		/**创建一个色块 Sprite **/
		public static function CreateAlphaSP(_mouseEnabled:Boolean,
											 _width:Number, _height:Number,
											 _x:Number = 0, _y:Number = 0,
											 _fillColor:Number = 0xFF0000,
											 _fillAlpha:Number = 0):Sprite{
			var mask_sp:Sprite = new Sprite();
			mask_sp.mouseEnabled = _mouseEnabled;
			mask_sp.graphics.beginFill(_fillColor);
			mask_sp.graphics.drawRect(_x, _y, _width, _height);
			mask_sp.graphics.endFill();
			mask_sp.alpha = _fillAlpha;
			return mask_sp;
		}
		
		/**创建一条线 **/
		public static function createLine(graphics:Graphics, fromX:Number, fromY:Number, toX:Number, toY:Number, color:Number = 0xFF0000, thickness:Number = 1, alpha:Number = 1):void{
			graphics.lineStyle(thickness, color, alpha);
			graphics.moveTo(fromX, fromY);
			graphics.lineTo(toX, toY);
		}
		
		/**获得不重复的随机数*/
		public static function RandomArray(n:int):Array {
		    var my_array:Array=new Array();
		    var i:int=0;
		    for (i=0; i<n; i++) {
		        my_array.push(i);
		    }
		    for (i=0; i<n; i++) {
		        var tmp1:int=Math.random()*n;
		        var tmp2:int=my_array[i];
		        my_array[i]=my_array[tmp1];
		        my_array[tmp1]=tmp2;
		    }
		    return my_array
		}
		/**释放数组内容*/
		public static function disposeArray($arr:Array):void{
			if($arr == null) return;
			for(var i:int = 0 ; i < $arr.length; i++){
				$arr[i] = null;
			}
			$arr = null;
		}
		
		/**
		 * 克隆对象
		 * @param inputArray	输入一个要克隆的对象，返回一个被克隆的对象
		 */
		public static function cloneObject(_obj:Object):Object{
			if(_obj == null) return null;
			var byte:ByteArray = new ByteArray();
			byte.writeObject(_obj);
			byte.position = 0;
			var o:Object = byte.readObject();
			return o;
		}
		
		/**
		 * 循环父级容器是否有parentObject类
		 * @param targetObject	当前子级容器
		 * @param parentObject	匹配的类
		 * @return 匹配的类的实例
		 */
		public static function getParentsObject(targetObject:Object, parentObject:Class):Object{
			var _obj:Object;
			if(targetObject != null){
				if(		targetObject.parent != null
					&&  targetObject.parent.parent != null
					&&  targetObject.parent.parent is parentObject){
					
					_obj = targetObject.parent.parent;
				}else{
					_obj = getParentsObject(targetObject.parent, parentObject);
				}
			}
			return _obj;
		}
		
		/**对象连接**/
		public static function ObjectConcat(_obj1:Object, _obj2:Object):Object{
			var parent_obj:Object = {};
			for(var item1:String in _obj1){
				parent_obj[item1] = _obj1[item1];
			}
			for(var item2:String in _obj2){
				parent_obj[item2] = _obj2[item2];
			}
			return parent_obj;
		}
		
		/**
		 * 返回一个滤镜
		 * @param color		色彩
		 * @param inner		是否要内发光
		 */
		public static function OEffect(color:uint = 0xFF0000, inner:Boolean = false):GlowFilter{
		    var glow:GlowFilter = new GlowFilter();
			glow.color = color;
			glow.alpha = 0.8;
			glow.blurX = 12;
			glow.blurY = 12;
			glow.inner = inner;
			glow.quality = BitmapFilterQuality.MEDIUM;
			return glow;
		}
		/**鼠标滤镜**/
		public static function mouseEffect(obj:Object, $filter:GlowFilter = null, color:uint=0xFF0000, inner:Boolean=false):void{
			if(!obj) return;
			if($filter != null){
				obj.filters = [$filter];
			}else{
				obj.filters = [OEffect(color, inner)];
			}
		}
		public static function removeMouseEffect(obj:Object):void{
			if(!obj) return;
			if(obj.filters != null){
				obj.filters = null;
			}
		}
		/**
		 * 阵列
		 
		 	var arr:Array = [];
			for(var arr_i:int = 0 ; arr_i < 50; arr_i++){
				arr.push(new MyButton("btn_"+arr_i));
			}
			PublicProperty.lineupAll(this, 6, arr, 90, 40);
		
		 * @param _cust	容器
		 * @param rlen	每行多少个
		 * @param _arr	所有要排列的元素都存在数组里
		 * @param _inx	行间隔
		 * @param _iny	列间隔
		 * @param offx	从容器里的x坐标开始偏移
		 * @param offy	从容器里的y坐标开始偏移
		 */		
		public static function lineupAll(_cust:Sprite = null, rlen:uint = 6, _arr:* = null, _rolgap:Number = 32, _cowgap:Number = 32, offx:Number = 0, offy:Number = 0):void{
			var _len:int = _arr.length;
			var nx:Number = 0;
			var ny:Number = 0;
			for (var n:int = 0; n < _len; n ++) {
				if (n % rlen == 0 && n != 0) {
					ny += _cowgap;
					nx = 0;
				}
				var sp:Sprite = _arr[n];
				sp.x = nx + offx;
				sp.y = ny + offy;
				nx += _rolgap;
				_cust.addChild(sp);
			}
		}
		
		public static function obj2ClsName(obj:Object):String{
			var _index:int = String(obj).lastIndexOf(" ");
			return String(obj).substring(_index + 1, String(obj).length - 1);
		}
		
		/** 过滤掉Html */		
		public static function ReplaceHtml(str:String):String{
			return str.replace(/<[^\<]*\>/ig,"").replace(/<[\s]*?a[^>]*?>[\s\S]*?<[\s]*?\/[\s]*?a[\s]*?>/ig,"");
		}
		/**
		 * 聊天关键字过滤方法
		 * @param value		需要过滤的字符串
		 * @return 			过滤后的字符串
		 * 
		 */
		private static var key_arr:Array;
		public static function ToFilter(value:String):String{
			if(key_arr == null) key_arr = KEY_FILTER.split("@");
			var rekey:String = "*";
			for(var i:int = 0 ; i < key_arr.length; i++){
				value = StringUtil.replace(value, key_arr[i], rekey);
			}
			return value;
		}
		/**
		 * 返回一个文本的CSS样式（仅有a链接的属性，返回后可再添加其它属性）
		 */		
		public static function createCSS():StyleSheet{
			var style:StyleSheet = new StyleSheet();
			style.setStyle("a:link", {color : "#FF9900",textDecoration:"none"});
			style.setStyle("a:visited", {color : "#66FF00",textDecoration:"none"});
			style.setStyle("a:active", {color : "#00CCFF",textDecoration:"none"});
			style.setStyle("a:hover", {color : "#00FF66",textDecoration:"underline"});
			return style;
		}
		
		/**将对象转为二进制字符串*/
		public static function obj2str(obj:Object):String{
			for(var itemName:String in obj){
				obj[itemName] = String(obj[itemName]);
			}
			var byte:ByteArray = new ByteArray();
			byte.writeObject(obj);
			return byte.toString();
		}
		
		/**将二进制字符串转为对象*/
		public static function str2obj(str:String):Object{
			var pb:ByteArray = new ByteArray();
			pb.writeUTFBytes(str);
			
			pb.position = 0;
			return pb.readObject();
		}

		/**右到左取第index位(一个字符)*/
		public static function getFlagFrom($flag:String, index:uint):String {
			var $len:int = $flag.length;
			var _arr:Array = [];
			for (var i:int = 0; i < $len; i++) {
				_arr.push( $flag.substr(i,1) );
			}
			return _arr[$len - index];
		}
	}
}