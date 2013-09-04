package anlei.debug
{
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class ApplicationStats extends Sprite
	{
		private static const _WIDTH:Number = 400;
		private static const _MEAN_DATA_LENGTH:int = 100;
		public static var DEBUG:Boolean = true;
		
		protected var index:int;
		protected var _msgArr:Vector.<String>;
		
		protected var _timer:Timer;
		protected var _last_frame_timestamp:Number;
		protected var _mean_data:Array;
		protected var _minisize : Boolean;
		
		//var logo_tf : TextField;
		protected var _markers : Shape;
		protected var _label_tf_fps:TextField;
		protected var _label_tf_afps : TextField;
		protected var _label_tf_ram : TextField;
		protected var _label_tf_poly : TextField;
		protected var _label_format:TextFormat = new TextFormat('_sans', 9, 0xffffff, true);
		
		protected var _fps:uint;
		protected var _fps_min:uint;
		protected var _fps_max:uint;
		protected var _fps_sum : uint;
		protected var _fps_avg:Number;
		protected var _ram:Number;
		protected var _ram_max:Number;
		
		protected var _mem_graph:Shape;
		protected var _mem_points : Array;
		
		protected var _topContainer:Sprite;
		
		protected var _bar_top:Sprite;
		protected var _btn_close:Sprite;
		protected var _btn_minmax:Sprite;
		protected var _btn_last:Sprite;
		protected var _btn_nnext:Sprite;
		protected var _btn_next:Sprite;
		protected var _btn_per:Sprite;
		protected var _btn_pper:Sprite;
		protected var _btn_first:Sprite;
		protected var _tf_fps:TextField;
		protected var _tf_afps:TextField;
		protected var _tf_ram:TextField;
		protected var _tf_poly:TextField;
		
		protected var _diagram:Sprite;
		protected var _dia_bmp:BitmapData;
		
		protected var _tf_box:TextField;
		protected var _dragRect:Rectangle 
		protected var _scrollBar:Sprite;
		protected var _scrollBar_up:Sprite;
		protected var _scrollBar_sc:Sprite;
		protected var _scrollBar_dn:Sprite;
		protected var _btnContainer:Sprite;
		protected var _ischange:Boolean;
		
		/**
		 * 单例
		 * @return 
		 * 
		 */       	
		private static var _instance:ApplicationStats;
		public static function getInstance() :ApplicationStats 
		{
			if (_instance == null) {
				_instance=new ApplicationStats();
			}
			return _instance;
		}
		
		
		/**
		 * 初始化 
		 * @param _stage
		 * @param _debug
		 * 
		 */		
		public function init(stage:Sprite):void
		{
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
			stage.stage.addChild(this);
			
			this.x = 5;
			this.y = 5;
			
			_ram_max = 0;
			_mean_data = [];
			_mem_points = [];
			for (i=0; i<_WIDTH; i++) _mem_points[i]=0;
			for (var i:int=0; i<_MEAN_DATA_LENGTH; i++) _mean_data[i] = 0.0;
			
			_timer = new Timer(200, 0);
			_timer.addEventListener('timer', _onTimer);
			_timer.start();
			
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		
		/**
		 * 构造
		 * 
		 */		
		public function ApplicationStats()
		{
			super();
			visible = false;
			
			_msgArr = new Vector.<String>();
			_draw();
		}
		
		
		/**
		 * 输出
		 * @param str
		 * 
		 */
		public function push(str:String):void
		{
			if(!DEBUG || !_msgArr) return;
			
			_msgArr.push(str);
			if(_msgArr.length > 200) _msgArr.shift();
			if(index >= _msgArr.length - 2) showLast(null)
			else showIndex();
			//ExternalInterface.call("onApplicationStats", "\n\n"+str);  
		}
		
		
		/**
		 * 显示首条
		 * 
		 */		
		protected function showFirst(e:MouseEvent):void
		{
			index = 0;
			showIndex()
		}
		
		/**
		 * 显示上一条
		 * 
		 */		
		protected function showPPre(e:MouseEvent):void
		{
			index -= 5;
			showIndex()
		}	
		
		/**
		 * 显示上一条
		 * 
		 */		
		protected function showPre(e:MouseEvent):void
		{
			index--;
			showIndex()
		}
		
		/**
		 * 显示下一条
		 * 
		 */		
		protected function showNext(e:MouseEvent):void
		{
			index++;
			showIndex()
		}
		/**
		 * 显示下一条
		 * 
		 */		
		protected function showNNext(e:MouseEvent):void
		{
			index += 5;
			showIndex()
		}
		/**
		 * 显示末条
		 * 
		 */		
		protected function showLast(e:MouseEvent):void
		{
			index = _msgArr.length - 1;
			showIndex()
		}
		
		/**
		 * 
		 * @param index
		 * 
		 */		
		protected function showIndex():void
		{
			if(index < 0) index = 0;
			if(index >= _msgArr.length) index = _msgArr.length - 1;
			_ischange = true;
		}
		
		/**
		 * 
		 * 
		 */		
		protected function _renderIndex() : void
		{
			if(!_ischange || !visible) return;
			var msg:String ="调试信息("+(index+1)+"/"+_msgArr.length+")\n\n" + _msgArr[index]
			_tf_box.text = msg;
			_undateScrollBar();
			_ischange = false;
		}
		
		/**
		 * 键盘事件
		 * @param e
		 * 
		 */		
		protected function onkeyDown(e:KeyboardEvent):void
		{
			if(e.ctrlKey && e.shiftKey && e.altKey && e.keyCode == Keyboard.D)
			{
				visible = !visible;
				if(visible)
				{
					_timer.start();
					addEventListener(Event.ENTER_FRAME, _onEnterFrame);
				}
				else
				{
					_timer.stop();
					removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				}
			}
			else if(visible)
			{
				if(e.keyCode == Keyboard.LEFT)
				{
					showPre(null);
				}
				else if(e.keyCode == Keyboard.RIGHT)
				{
					showNext(null);
				}
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function _onEnterFrame(event:Event):void
		{
			var time : Number = getTimer() - _last_frame_timestamp;
			_fps = Math.floor(1000/time);
			_fps_sum += _fps;
			
			if (_fps > _fps_max) _fps_max = _fps;
			else if (_fps!=0 && _fps < _fps_min) _fps_min = _fps;
			
			_mean_data.push(_fps);
			_fps_sum -= Number(_mean_data.shift());
			_fps_avg = _fps_sum/_MEAN_DATA_LENGTH;
			
			_last_frame_timestamp = getTimer();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function _onTimer(event:TimerEvent):void
		{
			_ram = System.totalMemory;
			if (_ram > _ram_max) _ram_max = _ram;
			
			_mem_points.unshift(_ram/1024);
			_mem_points.pop();
			
			_redrawStats();
			_renderIndex();//延迟显示消息
		}
		
		/**
		 * 更新视图
		 * 
		 */		
		protected function _redrawStats() : void
		{
			var dia_y : int;
			
			// Redraw counters
			_tf_fps.text = _fps.toString().concat('/', stage.frameRate);
			_tf_afps.text = Math.round(_fps_avg).toString();
			_tf_ram.text = _getRamString(_ram).concat(' / ', _getRamString(_ram_max));
			
			// Move entire diagram
			_dia_bmp.scroll(1, 0);
			
			// Plot current framerate
			dia_y = _dia_bmp.height - Math.floor(_fps * _dia_bmp.height / 100);
			_dia_bmp.setPixel32(1, dia_y, 0xffffffff);
			
			// Plot average framerate
			dia_y = _dia_bmp.height - Math.floor(_fps_avg * _dia_bmp.height / 100);
			_dia_bmp.setPixel32(1, dia_y, 0xff33bbff);
			
			_redrawMemGraph();
		}
		
		/**
		 * 绘制内存
		 * 
		 */		
		protected function _redrawMemGraph() : void
		{
			var i : int;
			var g : Graphics;
			var max_val : Number = 0;
			
			// Redraw memory graph (only every 5th update)
			_mem_graph.scaleY = 1;
			g = _mem_graph.graphics;
			g.clear();
			g.lineStyle(.5, 0xffcc00, 1, true, LineScaleMode.NONE);
			g.moveTo(_mem_points.length-1, -_mem_points[_mem_points.length-1]);
			for (i=_mem_points.length-1; i>=0; --i) {
				if (_mem_points[i+1]==0 || _mem_points[i]==0) {
					g.moveTo(i, -_mem_points[i]);
					continue;
				}
				
				g.lineTo(i, -_mem_points[i]);
				
				if (_mem_points[i] > max_val)
					max_val = _mem_points[i];
			}
			_mem_graph.scaleY = _dia_bmp.height / max_val;
		}
		
		/**
		 * 绘制 
		 * 
		 */		
		protected function _draw():void
		{
			_topContainer = null;
			_topContainer = new Sprite();
			_topContainer.graphics.lineStyle(1,0x2A2320);
			_topContainer.graphics.beginFill(0x2A2320);
			_topContainer.graphics.drawRect(0, 0, _WIDTH, 60);
			_topContainer.graphics.endFill();
			this.addChild(_topContainer);
			
			_drawTopBar();
			
			_dia_bmp = null;
			_dia_bmp = new BitmapData(_WIDTH, 40, true, 0);
			
			_diagram = null;
			_diagram = new Sprite;
			_diagram.graphics.beginBitmapFill(_dia_bmp);
			_diagram.graphics.drawRect(0, 0, _dia_bmp.width, _dia_bmp.height);
			_diagram.graphics.endFill();
			_diagram.y = 17;
			_topContainer.addChild(_diagram);
			
			_diagram.graphics.lineStyle(1, 0xffffff, 0.2);
			_diagram.graphics.moveTo(0, 0);
			_diagram.graphics.lineTo(_WIDTH, 0);
			_diagram.graphics.moveTo(0, Math.floor(_dia_bmp.height/2));
			_diagram.graphics.lineTo(_WIDTH, Math.floor(_dia_bmp.height/2));
			_diagram.graphics.moveTo(0, Math.floor(_dia_bmp.height));
			_diagram.graphics.lineTo(_WIDTH, Math.floor(_dia_bmp.height));
			
			_mem_graph = null;
			_mem_graph = new Shape;
			_mem_graph.y = _diagram.y + _diagram.height;
			_topContainer.addChildAt(_mem_graph, 0);
			
			_drawBtnBar();
			
			_msgArr.push("debug panel init complete !");
			showFirst(null);
		}
		
		/**
		 * 绘制底部 
		 * 
		 */		
		protected function _drawBtnBar():void
		{
			_btnContainer = null;
			_btnContainer = new Sprite();
			_btnContainer.graphics.lineStyle(1,0x2A2320);
			_btnContainer.graphics.beginFill(0x3A3330);
			_btnContainer.graphics.drawRect(0, 0, _WIDTH, 500);
			_btnContainer.graphics.endFill();
			_btnContainer.y = 60;
			this.addChild(_btnContainer);
			
			
			_tf_box = _newTextArea("", 2, 2, _WIDTH-14, _btnContainer.height-4);
			_tf_box.defaultTextFormat = _label_format;
			_btnContainer.addChild(_tf_box);
			
			_drawScrollBar(_tf_box);
		}
		
		/**
		 * 
		 * 
		 */		
		protected function _drawScrollBar(textfield:TextField) : void
		{
			_scrollBar = new Sprite;
			_scrollBar.graphics.lineStyle(1,0xefefef);
			_scrollBar.graphics.beginFill(0x3A3330);
			_scrollBar.graphics.drawRect(0, 0, 8, _btnContainer.height-4);
			_scrollBar.graphics.endFill();
			_scrollBar.x = textfield.x + textfield.width + 2;
			_scrollBar.y = textfield.y;
			_btnContainer.addChild(_scrollBar);
			
			_scrollBar_up = new Sprite;
			_scrollBar_up.x = 4;
			_scrollBar_up.y = 4;
			_scrollBar_up.graphics.beginFill(0, 0);
			_scrollBar_up.graphics.lineStyle(1, 0xefefef, 1, true);
			_scrollBar_up.graphics.drawRect(-4, -4, 8, 8);
			_scrollBar_up.graphics.moveTo(-2, 2);
			_scrollBar_up.graphics.lineTo(0, -2);
			_scrollBar_up.graphics.moveTo(2, 2);
			_scrollBar_up.graphics.lineTo(0, -2);
			_scrollBar_up.buttonMode = true;
			_scrollBar_up.addEventListener(MouseEvent.CLICK, _scrollUp);
			_scrollBar.addChild(_scrollBar_up);
			
			_scrollBar_dn = new Sprite;
			_scrollBar_dn.x = 4;
			_scrollBar_dn.y = _scrollBar.height - 4;
			_scrollBar_dn.graphics.beginFill(0, 0);
			_scrollBar_dn.graphics.lineStyle(1, 0xefefef, 1, true);
			_scrollBar_dn.graphics.drawRect(-4, -4, 8, 8);
			_scrollBar_dn.graphics.moveTo(2, -2);
			_scrollBar_dn.graphics.lineTo(0, 2);
			_scrollBar_dn.graphics.moveTo(-2, -2);
			_scrollBar_dn.graphics.lineTo(0, 2);
			_scrollBar_dn.buttonMode = true;
			_scrollBar_dn.addEventListener(MouseEvent.CLICK, _scrollDown);
			_scrollBar.addChild(_scrollBar_dn);
			
			_scrollBar_sc = new Sprite;
			_scrollBar.addChild(_scrollBar_sc);
			_undateScrollBar();
		}
		protected function _scrollUp(event:MouseEvent):void
		{
			_tf_box.scrollV --;
			var allheight:int = _scrollBar.height - _scrollBar_sc.height - 16;
			_scrollBar_sc.y = (_tf_box.scrollV/_tf_box.maxScrollV)*allheight
		}
		protected function _scrollDown(event:MouseEvent):void
		{
			_tf_box.scrollV ++;
			var allheight:int = _scrollBar.height - _scrollBar_sc.height - 16;
			_scrollBar_sc.y = (_tf_box.scrollV/_tf_box.maxScrollV)*allheight
		}
		protected function _undateScrollBar():void
		{
			var scrollBarHeight:int = (_tf_box.bottomScrollV/_tf_box.numLines)*(_scrollBar.height-16);
			var scrollBarAlpha:Number =  (_tf_box.bottomScrollV/_tf_box.numLines)==1?0:0.5
			_scrollBar_sc.graphics.clear();
			_scrollBar_sc.graphics.beginFill(0xefefef,scrollBarAlpha);
			_scrollBar_sc.graphics.lineStyle(1, 0xefefef, 1, true);
			_scrollBar_sc.graphics.drawRect(0, 8, 8, scrollBarHeight);
			_scrollBar_sc.buttonMode = true;     
			_dragRect = new Rectangle(0, 0, 0, _scrollBar.height - _scrollBar_sc.height - 16);
			_scrollBar_sc.addEventListener(MouseEvent.MOUSE_DOWN, _scrollDragDown);

		}
		protected function _scrollDragDown(event:MouseEvent):void
		{
			_scrollBar_sc.startDrag(false,_dragRect);
			_scrollBar_sc.addEventListener(Event.ENTER_FRAME, _scrollDragOnScroll);
			_scrollBar_sc.removeEventListener(MouseEvent.MOUSE_DOWN, _scrollDragDown);
			_scrollBar_sc.stage.addEventListener(MouseEvent.MOUSE_UP, _scrollDragUp);
		}
		protected function _scrollDragOnScroll(event:Event):void
		{
			var allheight:int = _scrollBar.height - _scrollBar_sc.height - 16;
			_tf_box.scrollV=Math.round((_scrollBar_sc.y/allheight)*_tf_box.maxScrollV);
		}
		protected function _scrollDragUp(event:MouseEvent):void
		{
			_scrollBar_sc.stopDrag();
			_scrollBar_sc.addEventListener(MouseEvent.MOUSE_DOWN, _scrollDragDown);
			_scrollBar_sc.removeEventListener(Event.ENTER_FRAME, _scrollDragOnScroll);
			_scrollBar_sc.stage.removeEventListener(MouseEvent.MOUSE_UP, _scrollDragUp);
		}
		
		/**
		 * 绘制顶部 
		 * 
		 */		
		protected function _drawTopBar() : void
		{
			_bar_top = null;
			_bar_top = new Sprite;
			_bar_top.graphics.beginFill(0, 0);
			_bar_top.graphics.drawRect(0, 0, _WIDTH, 20);
			_topContainer.addChild(_bar_top);
			
			_btn_first = new Sprite;
			_btn_first.x = _WIDTH-92;
			_btn_first.y = 8;
			_btn_first.graphics.beginFill(0, 0);
			_btn_first.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_first.graphics.drawRect(-4, -4, 8, 8);
			_btn_first.graphics.moveTo(2, -2);
			_btn_first.graphics.lineTo(-2, 0);
			_btn_first.graphics.moveTo(2, 2);
			_btn_first.graphics.lineTo(-2, 0);
			_btn_first.graphics.moveTo(-2, -2);
			_btn_first.graphics.lineTo(-2, 2);
			_btn_first.buttonMode = true;
			_btn_first.addEventListener(MouseEvent.CLICK, showFirst);
			_topContainer.addChild(_btn_first);
			
			_btn_pper = new Sprite;
			_btn_pper.x = _WIDTH-80;
			_btn_pper.y = 8;
			_btn_pper.graphics.beginFill(0, 0);
			_btn_pper.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_pper.graphics.drawRect(-4, -4, 8, 8);
			_btn_pper.graphics.moveTo(2, -2);
			_btn_pper.graphics.lineTo(0, 0);
			_btn_pper.graphics.moveTo(2, 2);
			_btn_pper.graphics.lineTo(0, 0);
			_btn_pper.graphics.moveTo(0, -2);
			_btn_pper.graphics.lineTo(-2, 0);
			_btn_pper.graphics.moveTo(0, 2);
			_btn_pper.graphics.lineTo(-2, 0);
			_btn_pper.buttonMode = true;
			_btn_pper.addEventListener(MouseEvent.CLICK, showPPre);
			_topContainer.addChild(_btn_pper);
			
			_btn_per = new Sprite;
			_btn_per.x = _WIDTH-68;
			_btn_per.y = 8;
			_btn_per.graphics.beginFill(0, 0);
			_btn_per.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_per.graphics.drawRect(-4, -4, 8, 8);
			_btn_per.graphics.moveTo(2, -2);
			_btn_per.graphics.lineTo(-2, 0);
			_btn_per.graphics.moveTo(2, 2);
			_btn_per.graphics.lineTo(-2, 0);
			_btn_per.buttonMode = true;
			_btn_per.addEventListener(MouseEvent.CLICK, showPre);
			_topContainer.addChild(_btn_per);
			
			_btn_next = new Sprite;
			_btn_next.x = _WIDTH-56;
			_btn_next.y = 8;
			_btn_next.graphics.beginFill(0, 0);
			_btn_next.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_next.graphics.drawRect(-4, -4, 8, 8);
			_btn_next.graphics.moveTo(-2, -2);
			_btn_next.graphics.lineTo(2, 0);
			_btn_next.graphics.moveTo(-2, 2);
			_btn_next.graphics.lineTo(2, 0);
			_btn_next.buttonMode = true;
			_btn_next.addEventListener(MouseEvent.CLICK, showNext);
			_topContainer.addChild(_btn_next);
			
			_btn_nnext = new Sprite;
			_btn_nnext.x = _WIDTH-44;
			_btn_nnext.y = 8;
			_btn_nnext.graphics.beginFill(0, 0);
			_btn_nnext.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_nnext.graphics.drawRect(-4, -4, 8, 8);
			_btn_nnext.graphics.moveTo(-2, -2);
			_btn_nnext.graphics.lineTo(0, 0);
			_btn_nnext.graphics.moveTo(-2, 2);
			_btn_nnext.graphics.lineTo(0, 0);
			_btn_nnext.graphics.moveTo(0, -2);
			_btn_nnext.graphics.lineTo(2, 0);
			_btn_nnext.graphics.moveTo(0, 2);
			_btn_nnext.graphics.lineTo(2, 0);
			_btn_nnext.buttonMode = true;
			_btn_nnext.addEventListener(MouseEvent.CLICK, showNNext);
			_topContainer.addChild(_btn_nnext);
			
			_btn_last = new Sprite;
			_btn_last.x = _WIDTH-32;
			_btn_last.y = 8;
			_btn_last.graphics.beginFill(0, 0);
			_btn_last.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_last.graphics.drawRect(-4, -4, 8, 8);
			_btn_last.graphics.moveTo(2, -2);
			_btn_last.graphics.lineTo(2, 2);
			_btn_last.graphics.moveTo(-2, -2);
			_btn_last.graphics.lineTo(2, 0);
			_btn_last.graphics.moveTo(-2, 2);
			_btn_last.graphics.lineTo(2, 0);
			_btn_last.buttonMode = true;
			_btn_last.addEventListener(MouseEvent.CLICK, showLast);
			_topContainer.addChild(_btn_last);
			
			_btn_minmax = new Sprite;
			_btn_minmax.x = _WIDTH-20;
			_btn_minmax.y = 8;
			_btn_minmax.graphics.beginFill(0, 0);
			_btn_minmax.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_minmax.graphics.drawRect(-4, -4, 8, 8);
			_btn_minmax.graphics.moveTo(-3, 2);
			_btn_minmax.graphics.lineTo(3, 2);
			_btn_minmax.buttonMode = true;
			_btn_minmax.addEventListener(MouseEvent.CLICK, _onMinMaxBtnClick);
			_topContainer.addChild(_btn_minmax);
			
			_btn_close = null;
			_btn_close = new Sprite;
			_btn_close.x = _WIDTH-8;
			_btn_close.y = 8;
			_btn_close.graphics.beginFill(0, 0);
			_btn_close.graphics.lineStyle(1, 0xefefef, 1, true);
			_btn_close.graphics.drawRect(-4, -4, 8, 8);
			_btn_close.graphics.moveTo(-3, 3);
			_btn_close.graphics.lineTo(3, -3);
			_btn_close.graphics.moveTo(3, 3);
			_btn_close.graphics.lineTo(-3, -3);
			_btn_close.buttonMode = true;
			_btn_close.addEventListener(MouseEvent.CLICK, _onCloseBtnClick);
			_topContainer.addChild(_btn_close);
			
			
			// Color markers 
			_markers = null;
			_markers = new Shape;
			_markers.graphics.beginFill(0xffffff);
			_markers.graphics.drawRect(5, 7, 4, 4);
			_markers.graphics.beginFill(0x3388dd);
			_markers.graphics.drawRect(65, 7, 4, 4);
			_markers.graphics.beginFill(0xffcc00);
			_markers.graphics.drawRect(125, 7, 4, 4);
			_bar_top.addChild(_markers);
			
			// CURRENT FPS
			_label_tf_fps = null;
			_label_tf_fps = new TextField();
			_label_tf_fps.defaultTextFormat = _label_format;
			_label_tf_fps.autoSize = TextFieldAutoSize.LEFT; 
			_label_tf_fps.text = 'FPS:';
			_label_tf_fps.x = 10;
			_label_tf_fps.y = 2;
			_label_tf_fps.selectable = false;
			_bar_top.addChild(_label_tf_fps);
			
			_tf_fps = null;
			_tf_fps = new TextField;
			_tf_fps.defaultTextFormat = _label_format;
			_tf_fps.autoSize = TextFieldAutoSize.LEFT;
			_tf_fps.x = _label_tf_fps.x + 22;
			_tf_fps.y = _label_tf_fps.y;
			_tf_fps.selectable = false;
			_bar_top.addChild(_tf_fps);
			
			// AVG FPS
			_label_tf_afps = null;
			_label_tf_afps = new TextField;
			_label_tf_afps.defaultTextFormat = _label_format;
			_label_tf_afps.autoSize = TextFieldAutoSize.LEFT;
			_label_tf_afps.text = 'AVG:';
			_label_tf_afps.x = 70;
			_label_tf_afps.y = 2;
			_label_tf_afps.selectable = false;
			_bar_top.addChild(_label_tf_afps);
			
			_tf_afps = null;
			_tf_afps = new TextField;
			_tf_afps.defaultTextFormat = _label_format;
			_tf_afps.autoSize = TextFieldAutoSize.LEFT;
			_tf_afps.x = _label_tf_afps.x + 22;
			_tf_afps.y = _label_tf_afps.y;
			_tf_afps.selectable = false;
			_bar_top.addChild(_tf_afps);
			
			// CURRENT RAM
			_label_tf_ram = null;
			_label_tf_ram = new TextField;
			_label_tf_ram.defaultTextFormat = _label_format;
			_label_tf_ram.autoSize = TextFieldAutoSize.LEFT;
			_label_tf_ram.text = 'RAM:';
			_label_tf_ram.x = 130;
			_label_tf_ram.y = 2;
			_label_tf_ram.selectable = false;
			_label_tf_ram.mouseEnabled = false;
			_bar_top.addChild(_label_tf_ram);
			
			_tf_ram = null;
			_tf_ram = new TextField;
			_tf_ram.defaultTextFormat = _label_format;
			_tf_ram.autoSize = TextFieldAutoSize.LEFT;
			_tf_ram.x = _label_tf_ram.x + 22;
			_tf_ram.y = _label_tf_ram.y;
			_tf_ram.selectable = false;
			_tf_ram.mouseEnabled = false;
			_bar_top.addChild(_tf_ram);
		}
		
		/**
		 * 添加到舞台
		 * 
		 */		
		protected function _onAddedToStage(ev : Event) : void
		{
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,onkeyDown);
			
			_topContainer.addEventListener(MouseEvent.MOUSE_DOWN,_onMouseDown);
			_topContainer.addEventListener(MouseEvent.MOUSE_UP,_onMouseUp);
		}
		
		/**
		 * 移除
		 * 
		 */		
		protected function _onRemovedFromStage(ev : Event) : void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onkeyDown);
			
			_topContainer.removeEventListener(MouseEvent.MOUSE_DOWN,_onMouseDown);
			_topContainer.removeEventListener(MouseEvent.MOUSE_UP,_onMouseUp);
			
		}
		
		/**
		 * 关闭 
		 * @param event
		 * 
		 */		
		protected function _onCloseBtnClick(event:MouseEvent):void
		{
			this.visible = false;
		}
		
		/**
		 * 最小化最大化 
		 * @param event
		 * 
		 */		
		protected function _onMinMaxBtnClick(event:MouseEvent):void
		{
			_minisize = !_minisize;
			_btn_minmax.rotation = _minisize ? 180 : 0;
			_btnContainer.visible = !_minisize;
		}		
		
		/**
		 * 拖动 
		 * @param e
		 * 
		 */		
		protected function _onMouseDown(e:MouseEvent):void
		{
			this.startDrag()
		}
		
		/**
		 * 停止拖动
		 * @param e
		 * 
		 */		
		protected function _onMouseUp(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		/**
		 * 
		 * @param ram
		 * @return 
		 * 
		 */		
		protected function _getRamString(ram : Number) : String
		{
			var ram_unit : String = 'B';
			if (ram > 1048576) {
				ram /= 1048576;
				ram_unit = 'M'; 
			}
			else if (ram > 1024) {
				ram /= 1024;
				ram_unit = 'K'; 
			}
			return ram.toFixed(1) + ram_unit;
		}
		
		/**
		 * 
		 * @param str
		 * @param _x
		 * @param _y
		 * @param _w
		 * @param _h
		 * @param _input
		 * @param _pass
		 * @param _color
		 * @param _restrict
		 * @return 
		 * 
		 */		
		protected function _newTextArea(str:String="", _x:int=0, _y:int=0, _w:int=120, _h:int=18, _input:Boolean=false, _pass:Boolean=false, _color:uint=0xCCCCCC, _restrict:String=""):TextField
		{
			var _txt:TextField = new TextField()
			_txt.text=str;
			_txt.x=_x;
			_txt.y=_y;
			_txt.width=_w;
			_txt.height=_h;
			_txt.border=false;
			_txt.wordWrap=true;
			_txt.textColor=_color;
			_txt.borderColor=_color
			_txt.displayAsPassword=_pass
			if (_input)_txt.type = TextFieldType.INPUT
			if (_restrict != "")_txt.restrict=_restrict
			return _txt;
		}
	}
}