package
{
	import ctrl.DymainLoaderSource;
	import ctrl.DymainLoaderVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import ui.UIConfig;
	import ui.component.MyCheckBox;
	import ui.component.MyDropMenu;
	import ui.component.MyList;
	import ui.component.MyScrollBar;
	import ui.component.MyTextArea;
	import ui.component.MyTree;
	import ui.data.DPModel;
	
	[SWF(width="960", height="560", frameRate="30", backgroundColor="#F1F2F6", creator="梁大少")]
	public class AS3_ASWing extends Sprite
	{
		[Embed(source="../.version",mimeType='application/octet-stream')]
		private var versionXml:Class;
		private const CONFIG_XML:String='config.xml';
		
		public function AS3_ASWing()
		{
			Entrance.getInstance().inits(CONFIG_XML, XML(new versionXml()), this, onComplete);
		}
		private function onComplete():void{
			var list:Vector.<DymainLoaderVO> = new Vector.<DymainLoaderVO>();
			
			var vo:DymainLoaderVO = new DymainLoaderVO();
			vo.desc = "Aswing";
			vo.keyID = UIConfig.Source_Key;
			vo.path = "assets/AS3_ASWing_source.swf";
			list.push(vo);
			
			
			DymainLoaderSource.getInstance().execLoadCompleteFunction = onLoadComplete;
			DymainLoaderSource.getInstance().loadMainSource(list);
		}
		
		private function onLoadComplete():void{
			var cbb:MyList = new MyList();
			addChild(cbb);
			cbb.data = [
				new DPModel("B", 1),
				new DPModel("C", 2),
				new DPModel("A", 0),
				new DPModel("B", 1),
				new DPModel("C", 2),
				new DPModel("C", 2),
				new DPModel("A", 0),
				new DPModel("B", 1),
				new DPModel("C", 2)
			];
			
			cbb.setSelectedIndex(0);
			cbb.addEvent(function(e:*):void{
				trace(cbb.getSelectedItem().label);
			});
			
			var _txt:MyTextArea = new MyTextArea();
			_txt.setSize(200, 200);
			_txt.isStroke();
			//_txt.textField.border = true;
			_txt.isInput = true;
			_txt.align = TextFieldAutoSize.CENTER;
			
			var _sb:MyScrollBar = new MyScrollBar();
			_sb.move(200, 200);
			_sb.source = _txt.UI;//PublicProperty.CreateAlphaSP(false, 200, 200, 0, 0, 0xff0000, 0.5);
			addChild(_sb);
			_sb.horizontalScrollPolicy = 1;
			
			_sb.stage.addEventListener(MouseEvent.CLICK, function(e:*):void{
				_txt.align = TextFieldAutoSize.RIGHT;
			});
			
			stage.focus = _txt.textField;
			
			var _xml:XML =
				<root label="" data="">
					<node label="节点1" data="1000">
						<node label="A_x" data="1100">
							<node label="A_1" data="1101"/>
							<node label="A_2" data="1102"/>
							<node label="A_3" data="1103"/>
							<node label="A_4" data="1104"/>
						</node>
						<node label="B" data="1001"/>
					</node>

					<node label="节点2" data="2000">
						<node label="C_1" data="2001"/>
						<node label="C_2" data="2002"/>
						<node label="C_3" data="2003"/>
						<node label="C_4" data="2004"/>
					</node>
					<node label="节点3" data="3000">
						<node label="C_1" data="2001"/>
						<node label="C_2" data="2002"/>
					</node>
				</root>;
			
			var tree:MyTree = new MyTree();
			addChild(tree);
			tree.addSelectionListener(function():void{
				trace(tree.getSelectedItem().label, tree.getSelectedItem().data);
			});
			tree.data = _xml;
			
			
			
			var xml:XML = 
				<menu>
					<item label="AA" data="0" />
					<item label="BB" data="1" />
				</menu>
			var menu:MyDropMenu = new MyDropMenu(xml, null);
			menu.addEventListener(MyDropMenu.DROPMENU_CLICK, function(e:*):void{
				trace(e.OBJECT.label,e.OBJECT.data);
			});
			menu.move(400,200);
			addChild(menu);
			menu.pop();
			
			
			var _check:MyCheckBox = new MyCheckBox();
			_check.label = "Anananana";
			_check.selected = true;
			_check.addEvent(function(e:Event):void{
				trace(_check.selected);
			});
			_check.resize();
			_check.move(200,200);
			
			addChild(_check);
			
		}
	}
}