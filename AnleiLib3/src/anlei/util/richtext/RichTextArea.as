/**
*
* 6dn RichTextArea 

*----------------------------------------------------------------
* @notice 6dn RichTextArea
* @author 6dn
* @as version1.1
* @date 2010-4-7
*
* AUTHOR ******************************************************************************
* 
* authorName : 黎新苑 - www.6dn.cn
* QQ :160379558(6dnの星)
* MSN :xdngo@hotmail.com
* email :6dn@6dn.cn, xdngo@163.com
* webpage : http://www.6dn.cn
* 
* LICENSE ******************************************************************************
* 
* ① RichTextArea类基于FP9,as3.0的轻量级富文本类!(聊天类型,只支持单行图文混排);
* ② 支持外部图片,可使用jpg,png静态图片,也可以使用gif动态图片,当然,也可以使用有linkage库链接的MovieClip；
* ③ 轻量级,使用简便,使用xml配置,通用的字符表情,输入后马上显示;
* ④ 可使用htmlText,可扩展加入超链接,文字粗细,下划线等textFormat(注:由于styleSheet 和 textFormat冲突,所以这里不能使用styleSheet);
* ⑤ 可自由复制，粘贴任何文本以及图像;
* ⑥ 通过richText属性set 和 get,方便易用;(richText值取到的字符串被Player自动加入了一些html标签,但不影响正常使用);
* ⑦ 此类作为开源使用，但请重视作者劳动成果，请使用此类的朋友保留作者信息。
* Please, keep this header and the list of all authors
* 
* ******************************************************************************
*   构造方法:
		RichTextArea($w:int, $h:int) //创建一个宽为$w,高为$h的RichTextArea

	公共方法:
		-appendRichText($str:Stirng):void     //追加$str到RichTextArea;
		-insertRichText($str:String, $beginIndex:int=-1, $endIndex:int = -1):void    //在$beginIndex和$endIndex之间插入字符，默认位置为文本caretIndex即，当前光标位置
		-clear():void                         //清空RichTextArea并回到初始状态
		-resizeTo($w:int, $h:int):void  	  //重新设定RichTextArea的width,height
		-autoAdjust():void  				  //当外部动态设定了textField的x,y或width,height, 可以使用该方法自动校正使RichTextArea显示正常


	公共属性:
		-textField:TextField  [read-only]   //取得RichTextArea中的文本对象
		-richText:String   [read-write]  //设置和读取富文本的值
		-configXML:XML  [read-write]   //富文本对应的XML配置,请参照示例中的格式
			//iconUrl:String 可以是外部链接，也可以是有linkage的库链接
			//iconType:String [movieClip | jpg | gif] 三种格式对应
			//iconStr:String 配置替换的字符串
			
		-defaultTextFormat:TextFormat [read-write]  //设置和读取富文本的defaultTextFormat; (当RichTextArea已经ADDED_TO_STAGE在舞台显示列表中时,如要动态改变textField的defaultTextFormat请用该属性)

	用法示例 usage：
		var _richTextArea:RichTextArea = new RichTextArea(200,300);
		_richTextArea.configXML = <root>
									<icon iconUrl='myMC' iconType ="movieClip" iconStr=":]"/>
									<icon iconUrl='img/1.jpg' iconType ="jpg" iconStr=":o"/>
									<icon iconUrl='img/2.gif' iconType ="jpg" iconStr=":)"/>
								</root>;
		_richTextArea.x = 0;
		_richTextArea.y = 0;
		_richTextArea.textField.wordWrap=true;
		_richTextArea.textField.multiline=true;
		_richTextArea.textField.border = true;
		_richTextArea.textField.type = TextFieldType.INPUT;
		
		_richTextArea.richText = "Hi!:] welcome to <b><font color='#0033FF' size='13'><a href=\"http://www.6dn.cn/blog\" >6DN Blog</a></font></b>! :) ";
		
		addChild(_richTextArea);
		
		trace(_richTextArea.richText);

* 
* 
*/

package anlei.util.richtext
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.utils.getDefinitionByName;
	
	public class RichTextArea extends Sprite
	{
		private var _textField:TextField;
		private var _cacheTextField:TextField;
		private var _txtInfo:Object;
		private var _configXML:XML;
		private var _richTxt:String;	
		private var _defaultFormat:TextFormat;
		
		private var _spriteMap:Array;
		private var _spriteContainer:Sprite;
		private var _spriteMask:Sprite;
		private var _this:Sprite;
		private var _gifPlayer:GifPlayer;
		
		private const PLACEHOLDER:String = "　";
		private const SEPARATOR:String = "[@6dn@]";
		private const TYPE_MOVIECLIP:String = "movieClip";
		private const TYPE_JPG:String = "jpg";
		private const TYPE_GIF:String = "gif";
		private const STATUS_INIT:String = "init";
		private const STATUS_LOADED:String = "loaded";
		private const STATUS_NORMAL:String = "normal";
		private const STATUS_CHANGE:String = "change";
		private const STATUS_CONVERT:String = "convert";
		private const STATUS_SCROLL:String = "scroll";
		private const STATUS_INPUT:String = "input";
		
		public function RichTextArea($w:int, $h:int) 
		{
			_this = this;
			
			_spriteMap = new Array();
			_configXML = new XML();
			
			_txtInfo = {
				cursorIndex:null,
				firstPartLength:null,
				lastPartLength:null
			}
			
			//
			_gifPlayer = new GifPlayer();
			
			_cacheTextField = new TextField();
			_cacheTextField.multiline = true;
			
			_textField = new TextField();
			_textField.textColor = 0xFFFFFF;
			_textField.width = $w;
			_textField.height = $h;
			_textField.useRichTextClipboard = true;
			
			_defaultFormat = new TextFormat();
			_defaultFormat.size = 12;
			_defaultFormat.letterSpacing = 0;
			
			_spriteMask = new Sprite();
			drawRectGraphics(_spriteMask,$w,$h, true);
			
			_spriteContainer = new Sprite();
			_spriteContainer.mask = _spriteMask;
			_spriteContainer.mouseChildren = false;
			_spriteContainer.mouseEnabled = false;
			
			_this.addChild(_textField);
			_this.addChild(_spriteContainer);
			_this.addChild(_spriteMask);
			
			//
			_this.addEventListener(Event.ADDED_TO_STAGE, initHandler);
			_this.addEventListener(Event.UNLOAD, unloadHandler);
			_this.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			
			_textField.addEventListener(MouseEvent.CLICK, clickHandler);
			_textField.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			
			_textField.addEventListener(Event.CHANGE , changeHandler);
			_textField.addEventListener(Event.SCROLL , scrollHandler);
			
		}
		
		private function onFocusIn(event:FocusEvent):void {
			if(stage!=null) stage.focus = _textField;
		}
		
		public function appendRichText($str:String):void
		{
			var $_htmlText:String = _textField.htmlText;
			$_htmlText += $str;
			_textField.htmlText = $_htmlText;
			convert();
		}
		
		public function insertRichText($str:String, $beginIndex:int=-1, $endIndex:int = -1):void
		{
			$beginIndex = $beginIndex != -1 ? $beginIndex : _textField.selectionBeginIndex;
			$endIndex = $endIndex != -1 ? $endIndex : _textField.selectionEndIndex;
			
			_textField.replaceText($beginIndex, $endIndex, $str);
			_textField.setTextFormat(_defaultFormat, $beginIndex, $beginIndex+$str.length);
			refreshArr($beginIndex, $str.length- ($endIndex - $beginIndex), false);
			
			//setTextInfo();
			
			controlManager(STATUS_CHANGE);
			stage.focus = _textField;
		}
		public function resizeTo($w:int, $h:int):void
		{
			_textField.width = $w;
			_textField.height = $h;
			_spriteContainer.x = _textField.x;
			_spriteContainer.y = _textField.y;
			drawRectGraphics(_spriteMask, $w, $h, true);
			refresh();
		}
		
		public function autoAdjust():void
		{
			_spriteContainer.x = _textField.x;
			_spriteContainer.y = _textField.y;
			drawRectGraphics(_spriteMask, _textField.width, _textField.height, true);
			refresh();
		}
		
		public function clear():void
		{
			_spriteMap = [];
			
			_txtInfo = {
				cursorIndex:null,
				firstPartLength:null,
				lastPartLength:null
			}
			
			while (_spriteContainer.numChildren) {
				_spriteContainer.removeChildAt(0);
			}
			_textField.htmlText = "";
		}
		//============================================================================
		// Event Handler
		//============================================================================	
		private function initHandler(evt:Event):void
		{
			_defaultFormat = _textField.defaultTextFormat; 
		}
		private function unloadHandler(evt:Event):void
		{
			_textField.removeEventListener(MouseEvent.CLICK, clickHandler);
			_textField.removeEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			_textField.removeEventListener(Event.CHANGE, changeHandler);
			_textField.removeEventListener(Event.SCROLL , scrollHandler);
			
			_this.removeChild(_textField);
			_this.removeChild(_spriteContainer);
			_this.removeChild(_spriteMask);
		}
		
		private function clickHandler(evt:Event):void
		{
			setTextInfo();
		}
		
		private function keyHandler(evt:KeyboardEvent):void
		{
			setDefaultFormat();
			setTextInfo();
		}	
		
		private function scrollHandler(evt:Event):void
		{
			if(_textField.htmlText ==null || _textField.htmlText =="") return;
			controlManager(STATUS_SCROLL);
		}
		private function changeHandler(evt:Event):void
		{
			controlManager(STATUS_CHANGE);	
		}
		//============================================================================
		// control function
		//============================================================================		
		private function controlManager($eventStr:String):void
		{
			if ($eventStr == STATUS_CONVERT) {
				convert();
			}else if ($eventStr == STATUS_CHANGE) {	
				setDefaultFormat();
				change();
				refresh();
				convert();
				setTextInfo();
			}else if ($eventStr == STATUS_SCROLL) {
				refresh();
			}
			
		}
			
		//============================================================================
		// convert & revert
		//============================================================================	
		
		private function convert():void
		{
			var $_replaceStr:String = PLACEHOLDER;
			var $_strLen:int;
			var $_id:int;
			var $_index:int;
			var $_iconStr:String ;
			var $_iconInfo:Object;
			
			while ($_index != -1) {	
				
				$_iconInfo = getInfoFormXML(_textField.text);
				$_index = $_iconInfo.index;
				
				if ($_index != -1) {
					refreshArr($_index, $_replaceStr.length - $_iconInfo.iconStr.length);
					
					$_strLen = $_iconInfo.iconStr.length;
					_textField.replaceText($_iconInfo.index, $_iconInfo.index + $_strLen, $_replaceStr);
					
					addIcon($_iconInfo);
				}
				
			}
			//trace(_textField.caretIndex);
		}
		
		private function change():void
		{
			var $_textInfo:Object = getTextInfo();
			var $_cursorIndex:int = $_textInfo.cursorIndex < _txtInfo.cursorIndex ? $_textInfo.cursorIndex : _txtInfo.cursorIndex;
			var $_gap:int = $_textInfo.firstPartLength - _txtInfo.firstPartLength + $_textInfo.lastPartLength - _txtInfo.lastPartLength;
			if ($_textInfo.cursorIndex > _txtInfo.cursorIndex)  checkTxtFormat(_txtInfo.cursorIndex, $_textInfo.cursorIndex);
			refreshIcon($_cursorIndex,$_gap);
		}
		
		private function revert():String
		{
			var $_replaceStr :String= PLACEHOLDER;
			var $_placeHolderLen:int = $_replaceStr.length;
			
			var $_arr:Array = _spriteMap;
			var $_len:int = _spriteMap.length;
			
			var $_index:int;
			
			var $_info:Object;
			var $_item:Sprite;
			
			var $_returnStr:String ="";
			
			_cacheTextField.htmlText = _textField.htmlText;
			
			$_arr.sortOn(["index"], 16);
			
			while ($_len--) {
				$_info  = $_arr[$_len];
				//trace("iconstr:"+$_info.iconStr);
				if($_info){
					$_index = $_info.index;
					_cacheTextField.replaceText($_index, $_index + $_placeHolderLen, $_info.iconStr);
				}
			}
			$_returnStr = _cacheTextField.htmlText;	
			
			return $_returnStr;
		}
		
		//-------------------------------------------------------------------------
		// refresh
		//-------------------------------------------------------------------------
		
		private function refreshArr($index:int,$num:int, $isSetSelection:Boolean = true):void
		{
			var $_arr:Array = _spriteMap;
			var $_len:int = $_arr.length;
			var $_info:Object;
			for (var i:int = 0; i < $_len; i++) {
				$_info = $_arr[i];
				if ($_info) {
					if ($_info.index >= $index) {
						$_info.index += $num;
					}
				}
			}
			if ($num != 0) {
				if($isSetSelection) _textField.setSelection(_textField.caretIndex + $num, _textField.caretIndex + $num);
				setTextInfo();
			}
		}
		
		private function refresh():void
		{
			var $_arr:Array = _spriteMap;
			var $_len:int = $_arr.length;
			
			var $_info:Object;
			var $_item:Sprite;
			var $_rect:Rectangle;
			
			var $_txtLineMetrics :TextLineMetrics ;
			var $_lineHeight:int;
			
			while ($_len--) 
			{
				$_info = $_arr[$_len];
				if($_info){
					$_item = $_info.item;
					if($_item){
						$_rect = _textField.getCharBoundaries($_info.index);
						if ($_rect) {
							$_txtLineMetrics = _textField.getLineMetrics(_textField.getLineIndexOfChar($_info.index));
							$_lineHeight = $_rect.height *0.5 > $_item.height? $_txtLineMetrics.ascent- $_item.height  : ($_rect.height - $_item.height)*0.5;// $_txtLineMetrics.ascent ;// + $_txtLineMetrics.descent * 0.5;
							$_item.visible = true;
							$_item.x =  $_rect.x + ($_rect.width - $_item.width)*0.5;
							$_item.y =  $_rect.y + $_lineHeight;
						}else {
							$_item.visible = false;
						}
					}
				}
			}
			
			setContainerPos();
			
		}
		
		//-------------------------------------------------------------------------
		// TextFormat
		//-------------------------------------------------------------------------
		
		private function setFormat($id:int):void
		{
			var $_format:TextFormat;
			var $_item:Sprite;
			var $_rec:Rectangle;
			var $_info:Object = _spriteMap[$id];
			
			$_item = $_info.item;
			$_format = new TextFormat();
			$_format.size = $_item.height;
			$_format.font = $_info.iconStr + SEPARATOR + $_info.iconType + SEPARATOR + $_item.name;
			$_format.letterSpacing = $_item.width - getTxtWidth($_item.height);
			_textField.setTextFormat($_format, $_info.index);
			
			$_info.textFormat = $_format;
			$_info.status = STATUS_NORMAL;
		}
		
		private function getTxtWidth($size:int):int
		{
			var $_txt:TextField = new TextField();
			var $_format:TextFormat = new TextFormat();
			$_txt.text = PLACEHOLDER;
			$_format.size = $size;
			$_txt.setTextFormat($_format);
			return $_txt.textWidth-2;
		}
		
		private function checkTxtFormat($beginIndex:int, $endIndex:int):void
		{
			var $_gap :int = $endIndex - $beginIndex;
			var $_textFormat:TextFormat;
			var $_str:String;
			var $_index:int;
			var $_arr:Array;
			var $_txtInfo:Object;
			var $_iconUrl:String;
			
			while ($_gap--) {
				$_index = $endIndex - $_gap - 1;
				$_textFormat = _textField.getTextFormat($_index);
				$_str = $_textFormat.font;
				
				if ($_str.indexOf(SEPARATOR)!=-1) {
					$_arr = $_str.split(SEPARATOR);
					$_iconUrl =  findIconUrl($_arr[0]);
					//trace($_arr[0],$_arr[1]);
					$_txtInfo = {
						iconStr : $_arr[0],
						iconType : $_arr[1],
						iconUrl : $_iconUrl,
						index: $_index
					}
					if ($_iconUrl == null) {
						_textField.replaceText($_index, $_index+1, $_arr[0]);
						refreshArr($_index, $_arr[0].length- PLACEHOLDER.length);
					}else {
						addIcon($_txtInfo);
					}
				}
			}
		}
		private function setDefaultFormat():void
		{
			_textField.defaultTextFormat = _defaultFormat;
		}
		//-------------------------------------------------------------------------
		// textInfo
		//-------------------------------------------------------------------------
		private function setTextInfo():void
		{
			_txtInfo = {
				cursorIndex : _textField.caretIndex,
				firstPartLength : _textField.caretIndex,
				lastPartLength : _textField.length - _textField.caretIndex
			}
		}
		private function getTextInfo():Object
		{
			var $_obj:Object = {
				cursorIndex : _textField.caretIndex,
				firstPartLength : _textField.caretIndex,
				lastPartLength : _textField.length - _textField.caretIndex
			};
			return  $_obj;
		}
		//-------------------------------------------------------------------------
		// position
		//-------------------------------------------------------------------------

		private function getTextFieldPos():Object
		{
			var $_xpos:Number = _textField.scrollH;
			var $_n:int = _textField.scrollV-1;
			var $_ypos:Number = 0;
			while ($_n--) {
				$_ypos += _textField.getLineMetrics($_n).height;
			}
			return { x:-$_xpos, y:-$_ypos };
		}
		
		private function setContainerPos():void
		{
			var $_txtPos:Object = getTextFieldPos();
			_spriteContainer.x = _textField.x + $_txtPos.x;
			_spriteContainer.y = _textField.y + $_txtPos.y;
		}
		//-------------------------------------------------------------------------
		// configXML
		//-------------------------------------------------------------------------
		private function getInfoFormXML($str:String):Object
		{
			var $_xml:XML = _configXML;
			var $_len:int = $_xml.icon.length();
			var $_index:int = -1;
			var $_id:int = -1;
			if ($_len <= 0) return null;
			
			var $_info:Object = {
				index: -1,
				iconStr:"",
				iconUrl:"",
				iconType:""
			}
			
			for (var i:int = 0; i < $_len; i++ ) {
				
				$_index = $str.indexOf(getIconStr(i));
				
				if ($_id == -1 || ($_index != -1 && $_id > $_index)) {
					$_id = $_index;
					$_info.index = $_index;
					$_info.iconStr = getIconStr(i);
					$_info.iconUrl = getIconUrl(i);
					$_info.iconType = getIconType(i);
				}
			}
			return $_info; 
		}
		
		private function findIconUrl($iconStr:String):String
		{
			var $_xml:XML = _configXML;
			var $_len:int = $_xml.icon.length();
			
			for (var i:int = 0; i < $_len; i++) {
				if (getIconStr(i) == $iconStr) {
					return getIconUrl(i);
				}
			}
			return null;
		}
		
		private function getIconStr($index:int):String
		{
			var $_xml:XML = _configXML;
			return $_xml.icon[$index].@iconStr;
		}
		
		private function getIconUrl($index:int):String
		{
			var $_xml:XML = _configXML;
			return $_xml.icon[$index].@iconUrl;
		}
		
		private function getIconType($index:int):String
		{
			var $_xml:XML = _configXML;
			return $_xml.icon[$index].@iconType;
		}
		
		//-------------------------------------------------------------------------
		// addIcon & removeIcon
		//-------------------------------------------------------------------------
		
		private function addIcon($iconInfo:Object):void
		{
			var $_id:int ;
			
			var $_onItemLoaded:Function = function($item:Sprite):void 
			{
				_spriteMap.push( { 
					item: $item,
					iconStr : $iconInfo.iconStr,
					iconType : $iconInfo.iconType,
					iconUrl : $iconInfo.iconUrl, 
					index : $iconInfo.index,
					textFormat : null,
					status: STATUS_INIT
				});
				//trace($item.width);
				$_id = _spriteMap.length-1;
				
				_spriteContainer.addChild($item);
				setFormat($_id);
				refresh();
			}
			
			if ($iconInfo.iconType == TYPE_MOVIECLIP) {
				addMovieClip($iconInfo, $_onItemLoaded); 
			}else if ($iconInfo.iconType == TYPE_JPG) { 
				addJpg($iconInfo, $_onItemLoaded);
			}else if ($iconInfo.iconType == TYPE_GIF) { 
				addGif($iconInfo, $_onItemLoaded);
			}
		}
		
		private function refreshIcon($index:int, $gap:int):void
		{
			var $_arr:Array = _spriteMap;
			var $_len:int = $_arr.length;
			
			var $_info:Object;
			var $_item:Sprite;
			
			var $_textFormat:TextFormat;
			
			while ($_len--) 
			{
				$_info = $_arr[$_len];
				if($_info){
					$_item = $_info.item;
					if($_item){
						
						if ($_info.index >= $index) $_info.index += $gap;
						if ( $_info.index < 0 || $_info.index >= _textField.length) {
							_spriteContainer.removeChild($_item);
							$_arr[$_len] = null;
							$_info = null;
							//trace("remove1");
						}else{
							$_textFormat = _textField.getTextFormat($_info.index);
							if ($_info.status == STATUS_NORMAL && $_textFormat.font != $_info.textFormat.font) {	
								_spriteContainer.removeChild($_item);
								$_arr[$_len] = null;
								$_info = null;
								//trace("remove2");
							}
						}
					}
				}
			}
		}
		
		private function addMovieClip($info:Object, $onComplete:Function = null):void
		{
			var $_sprite:Sprite = new Sprite();
			var $_class:Class ;
			var $_item:MovieClip ;
			
			if ($info.iconUrl == null  || $info.iconUrl == "" ) {
				drawErrGraphics($_sprite); 
			}else {
				try{
					$_class= getDefinitionByName($info.iconUrl) as Class;
					$_item = new $_class();
					$_sprite.addChild($_item);
				}catch($e:Error){
					drawErrGraphics($_sprite); 
					//trace($e);
				}
			}
			if($onComplete !=null ) $onComplete($_sprite);
		}
		
		private function addJpg($info:Object, $onComplete:Function = null):void
		{
			var $_sprite:Sprite = new Sprite();
			var $_imgLoader:Loader = new Loader();
			var $_onComplete:Function = function(evt:Event):void
			{
				if ($onComplete != null ) $onComplete($_sprite); 
			}
			var $_onError:Function = function(evt:Event):void
			{
				drawErrGraphics($_sprite); 
				if($onComplete !=null ) $onComplete($_sprite);
			}
			if ($info.iconUrl == null || $info.iconUrl == "" ) {
				drawErrGraphics($_sprite); 
				if($onComplete !=null ) $onComplete($_sprite);
			}else {
				$_sprite.addChild($_imgLoader);
				$_imgLoader.load(new URLRequest($info.iconUrl));
				$_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, $_onComplete);
				$_imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, $_onError );
			}
		}
		private function addGif($info:Object, $onComplete:Function = null):void
		{
			var $_sprite:Sprite = new Sprite();
			var $_onComplete:Function = function(evt:Object):void
			{
				var $_frameRect:Rectangle = evt.rect;
				drawRectGraphics($_sprite, $_frameRect.width, $_frameRect.height, false, 0);
				if ($onComplete != null ) $onComplete($_sprite); 
			}
			var $_onError:Function = function(evt:Event):void
			{
				drawErrGraphics($_sprite); 
				if($onComplete !=null ) $onComplete($_sprite);
			}
			if ($info.iconUrl == null  || $info.iconUrl == "") {
				drawErrGraphics($_sprite); 
				if($onComplete !=null ) $onComplete($_sprite);
			}else{
				_gifPlayer.createGif($_sprite, $info.iconUrl, $_onComplete, $_onError);
			}
		}
		
		//-------------------------------------------------------------------------
		// draw graphics
		//-------------------------------------------------------------------------
		
		private function drawErrGraphics($container:Sprite):void 
		{
			$container.graphics.clear();
			$container.graphics.lineStyle(1,0xff0000);
			$container.graphics.beginFill(0xffffff);
			$container.graphics.drawRect(0, 0, 10, 10);
			
			$container.graphics.moveTo(0, 0);
			$container.graphics.lineTo(10, 10);
			$container.graphics.moveTo(0, 10);
			$container.graphics.lineTo(10, 0);
			
			$container.graphics.endFill();
		}
		
		private function drawRectGraphics($container:Sprite, $w:int = 10, $h:int = 10, $isClear:Boolean = false,  $alpha:int = 1):void 
		{
			if($isClear) $container.graphics.clear();
			$container.graphics.beginFill(0x0,$alpha);
			$container.graphics.drawRect(0, 0, $w, $h);
			$container.graphics.endFill();
		}
		
		//============================================================================
		//setter & getter
		//============================================================================
		
		public function get textField():TextField
		{
			return _textField;
		}
		public function set richText($str:String):void
		{
			clear();
			_richTxt = $str;
			_textField.htmlText = $str;	
			
			if ($str == null || $str == "" || _configXML == null ) return;
			
			controlManager(STATUS_CONVERT);
		}
		public function get richText():String
		{
			return revert();
		}
		
		public function set configXML($xml:XML):void
		{
			_configXML = $xml;
		}
		public function get configXML():XML
		{
			return _configXML;
		}
		public function set defaultTextFormat($textFormat:TextFormat):void
		{
			_defaultFormat = $textFormat;
		}
	}
	
}