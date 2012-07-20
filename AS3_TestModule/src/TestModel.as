package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import global.util.ModuleManage;
	
	import module.config.ModuleConfig;
	import module.iface.IUiSystem;
	
	import ui.component.MyBorderText;
	import ui.component.MyHVBox;
	import ui.component.MyTextButton;
	import ui.component.MyTextField;
	import ui.component.MyWin;
	
	[SWF(width="600", height="600", frameRate="30", backgroundColor="0xFFFFFF")]
	public class TestModel extends Sprite
	{
		public function TestModel()
		{
			this.graphics.beginFill(0xcccccc);
			this.graphics.lineStyle(1);
			this.graphics.drawRect(0,0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			
			var hvbox:MyHVBox = new MyHVBox();
			addChild(hvbox);
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			function onClick(e:MouseEvent):void{
				stage.removeEventListener(MouseEvent.CLICK, onClick);
				
				ModuleManage.getInstance().getModule(ModuleConfig.UiModule.swfUrl, ModuleConfig.UiModule.moduleUrl, onCreateModule);
			}
			return;
			/*var _b1:MyImage = new MyImage("abg.gif");new MyImage("abg.gif");new MyImage("abg.gif");new MyImage("abg.gif");
			var _b2:MyImage = new MyImage("hero_0.jpg");
			var _b3:MyImage = new MyImage("honor.png");
			
			_b2.x = 100;
			_b3.x = 200;
			
			addChild(_b1);
			addChild(_b2);
			addChild(_b3);
			*/
			var _btn:MyTextButton = new MyTextButton("弹窗");
			_btn.setFontColor(0xFF0000);
			addChild(_btn);
			
			var c_btn:MyTextButton = new MyTextButton("关窗");
			c_btn.setFontColor(0x00FFFF);
			c_btn.x = 50;
			addChild(c_btn);
			
			var d_btn:MyTextButton = new MyTextButton("释放");
			d_btn.setFontColor(0x00FFFF);
			d_btn.x = 100;
			addChild(d_btn);
			
			var _titleImg:MyImage;
			var _win:MyWin;
			var _text:MyBorderText;
			_btn.addEventListener(MouseEvent.CLICK, function(e:*):void{
				
				_win = new MyWin("我的人民", null, 300, 300);
				_win.addChild(new MyImage("lose.png", null, 30, 30));
				var _txt:MyTextField = new MyTextField();
				_txt.isStroke();
				_txt.text = "BBBAAA";
				_win.addChild(_txt);
				_win.pop();
				//_win.move(0, 0);
				
				if(_titleImg == null){
					_titleImg = new MyImage("title.png", function():void{
						_win.title_txt.setConfig(_titleImg.getBitmapData(), new Rectangle(60, 0, 6, 29));
						_win.resetTitleText_X();
					});
				}
				
				
				_text = new MyBorderText("AAA hero_0.jpg");
				//_text.size(10, _text.height);
				_text.move(11, 200);
				//addChild(_text);
			});
			
			c_btn.addEventListener(MouseEvent.CLICK, function(e:*):void{
				_win.removePop();
			});
			
			d_btn.addEventListener(MouseEvent.CLICK, function(e:*):void{
				//_win.dispose();
				//_win.size(Math.random()*200, Math.random()*200);
				_win.pop();
			});
			
			MyWin.Window = this;
			var _img:MyImage = new MyImage("win001.png", function():void{
				MyWin.BIT_DATA = _img.getBitmapData();
			});
			
			var _img2:MyImage = new MyImage("border.png", function():void{
				MyBorderText.BIT_DATA = _img2.getBitmapData();
			});
		}
		
		private function onCreateModule(event:IUiSystem):void {
			addChild(event as DisplayObject);
			event.update();
			event['addEventListener'](MouseEvent.CLICK, function(e:*):void{
				ModuleManage.getInstance().unloadModule(ModuleConfig.UiModule.swfUrl);
				removeChild(event as DisplayObject);
			});
		}
		
		
		
	}
}