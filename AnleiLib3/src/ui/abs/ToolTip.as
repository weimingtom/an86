/**
 *************************************
 * ToolTip
 * http://www.FlepStudio.org         
 * © Author: Filippo Lughi 
 * 用法:
 
	var _tip:ToolTip;
	mc1.addEventListener(MouseEvent.MOUSE_OVER, onOver);
	mc1.addEventListener(MouseEvent.MOUSE_OUT, onOut);
	
	function onOver(e:MouseEvent):void{
		//文字提示
		_tip = new ToolTip(0xFFCC00,0x000000,12,"Arial",'<b>Lorem ipsum</b> .');
		//剪辑提示
		//_tip = new ToolTip(0xFFCC00,0x000000,12,"Arial",new star_mc());
		addChild(_tip);
		_tip.mouseEnabled = false;
	}
	function onOut(e:MouseEvent):void{
		if(_tip != null){
			_tip.destroy();
			_tip = null;
		}
	}
 *************************************
 */
package ui.abs
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	
	import ui.component.MyTextField;
	import ui.component.MyTextFormat;
	
	public class ToolTip extends Sprite
	{
		//背景色
		private var BG_COLOR:uint;
		//文字色
		private var TEXT_COLOR:uint;
		//文字大小
		private var TEXT_SIZE:int;
		//字体
		private var FONT:String;
		//文字或剪辑
		public var TOOL_TEXT:*;
		
		private var field_txt:MyTextField;
		
		private var ratio:int=5;
		
		private var holder_mc:Sprite;
		private var bg_mc:Sprite;
//		private var father:Sprite;
		
		private var left_point:Number;
		private var top_point:Number;
		private var right_point:Number;
		private var bottom_point:Number;
		
		private static var _instance:ToolTip;
		private var tween:TweenLite;
		
		public function ToolTip(){
			
//			father=Entrance.getInstance().Root;
//			father.addChild(this);
			this.mouseEnabled = false;
			this.mouseChildren= false;
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public static function getInstance():ToolTip
		{
			if(!_instance) _instance = new ToolTip();
			return _instance;
		}
		
		/**
		 * @param bc	背景色
		 * @param tc	文字色
		 * @param tt	文字或剪辑
		 * @param ts	文字大小
		 * @param f		字体
		 */		
		public function setTip(bc:uint, tc:uint, tt:*):void{
			if(tween) tween.kill();
			tween = TweenLite.delayedCall(0.4, delay_setTip, [bc, tc, tt]);
		}
		
		private function delay_setTip(bc:uint, tc:uint, tt:*):void {
			BG_COLOR=bc;
			TEXT_COLOR=tc;
			TOOL_TEXT=tt;
			
			TEXT_SIZE = 12;
			FONT = MyTextFormat.FONT;
			
			field_txt.htmlText = "<textformat leading='4'>" + TOOL_TEXT + "</textformat>";
			holder_mc.addChild(field_txt);
			createBackground();
			fixPosition();
		}
		
		public function dispose():void
		{
//			if(father!=null){
			if(tween) tween.kill();
			tween = null;
				if(TOOL_TEXT is String){
					TOOL_TEXT = "";
					field_txt.htmlText = "<textformat leading='4'>" + TOOL_TEXT + "</textformat>";
					if(holder_mc.contains(field_txt)) holder_mc.removeChild(field_txt);
					bg_mc.graphics.clear();
				}else if(TOOL_TEXT is DisplayObject){
					if(bg_mc.contains(TOOL_TEXT)) bg_mc.removeChild(TOOL_TEXT);
					TOOL_TEXT = null;
				}else{
					TOOL_TEXT = null;
				}
//			}
		}
		
		/**********-------------------------------***********/
		
		private function init(evt:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			mouseEnabled = false;
			
			left_point=0;
			top_point=0;
			right_point=stage.stageWidth;
			bottom_point=stage.stageHeight;
			
			holder_mc=new Sprite();
			addChild(holder_mc);
			createTextField();
			fixPosition();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, addMovement);
		}
		
		private function createTextField():void
		{
			field_txt=new MyTextField();
			field_txt.mouseEnabled = false;
			field_txt.wordWrap = false;
			field_txt.multiline=true;
			field_txt.selectable=false;
			field_txt.autoSize = TextFieldAutoSize.LEFT;
//			field_txt.defaultTextFormat = MyTextField.format;
			//field_txt.textColor = 0x0;
//			field_txt.border = true;
			field_txt.antiAliasType=AntiAliasType.ADVANCED;
		}
		
		private function createBackground():void
		{
			if(bg_mc==null)	bg_mc=new Sprite();
			holder_mc.addChild(bg_mc);
			
			bg_mc.graphics.clear();
			
			if(TOOL_TEXT is DisplayObject){
				if(TOOL_TEXT!=null){
					if(bg_mc.contains(TOOL_TEXT)) bg_mc.removeChild(TOOL_TEXT);
				}
				TOOL_TEXT.x = -ratio/2;
				TOOL_TEXT.y = -ratio/2;
				bg_mc.addChild(TOOL_TEXT);
				if(holder_mc.contains(field_txt)){
					holder_mc.removeChild(field_txt);
				}
			}else if(TOOL_TEXT is String){
				bg_mc.graphics.lineStyle(1,0, 1,true);
				bg_mc.graphics.beginFill(BG_COLOR, 1);
				bg_mc.graphics.drawRoundRect(-ratio, -ratio, field_txt.width+ratio * 2 - 1, field_txt.height+ratio * 2 - 2, 0, 0);
				holder_mc.swapChildren(field_txt,bg_mc);
			}
			
		}
		//位置
		private function fixPosition():void
		{
			if(stage){
				const _off:Number = 16;
				if(stage.mouseX < stage.stageWidth / 2){
					//鼠标在左边时
					x = stage.mouseX + _off/2;
				}else{
					//鼠标在右边时
					x = stage.mouseX - width + _off/2;
				}
				
				if(stage.mouseY < stage.stageHeight / 2){
					//鼠标在上面时
					y = stage.mouseY + ratio * 2 + _off;
				}else{
					//鼠标在下面时
					y = stage.mouseY - height - _off/2;
				}
				//Tip超出右边时
				if(x > stage.stageWidth - width)
				{
					x = stage.stageWidth - width + _off;
				}
				//Tip超出左边
				if(x < ratio * 2){
					x = ratio * 2;
				}
			}
		}

		private function addMovement(evt:MouseEvent):void
		{
			fixPosition();
			evt.updateAfterEvent();
		}
		
	}
}