package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.aswing.*;
	import org.aswing.event.TreeSelectionEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.skinbuilder.orange.OrangeLookAndFeel;
	import org.aswing.tree.DefaultMutableTreeNode;
	import org.aswing.tree.DefaultTreeModel;
	import org.aswing.tree.GeneralTreeCellFactory;
	
	
	[SWF(width="960", height="560", frameRate="30", backgroundColor="#F1F2F6", creator="梁大少")]
	public class AS3_ASWing_source extends Sprite
	{
		public function AS3_ASWing_source()
		{
			AsWingManager.initAsStandard(this);
			
			UIManager.setLookAndFeel(new OrangeLookAndFeel());
			AsWingUtils.updateAllComponentUIInMemory();
			/*
			var _btn:JButton = new JButton("Anlei");
			addChild(_btn);
			
			_btn.setLocation(new IntPoint(181, 187));
			_btn.setSize(new IntDimension(63, 31));
			_btn.setText("labellabellabellabellabel");
			*/
			
			
			
//			var _com:JFrame = new JFrame(new JPanel());
//			_com.show();
			
			var layout0:BoxLayout = new BoxLayout();
			layout0.setAxis(AsWingConstants.VERTICAL);
			layout0.setGap(4);
			var _panel:Container = new Container();
			_panel.setSizeWH(500, 500);
			addChild(_panel);
			//_panel.setLayout(layout0);
			_panel.setLocationXY(100, 100);
			
			
			
			var list:Array = [
				new ListDataModel("A", 0),
				new ListDataModel("B", 1),
				new ListDataModel("C", 2),
				new ListDataModel("A", 0),
				new ListDataModel("B", 1),
				new ListDataModel("C", 2),
				new ListDataModel("A", 0),
				new ListDataModel("B", 1),
				new ListDataModel("C", 2),
				new ListDataModel("A", 0),
				new ListDataModel("B", 1),
				new ListDataModel("C", 2),
				new ListDataModel("A", 0),
				new ListDataModel("B", 1),
				new ListDataModel("C", 2)
			];
			var cbb:JComboBox = new JComboBox();
			cbb.setListData(list);
			//cbb.getModel()['clear']();
			cbb.setSelectedIndex(0);
			cbb.getSelectedIndex();
			cbb.setLocationXY(250, 100);
			cbb.setSizeWH(250, 24);
			//cbb.addActionListener(onSelected);
			_panel.append(cbb);
			cbb.setListCellFactory(new GeneralListCellFactory(Item, true, true, 40));
			
			var jlist:JList = new JList();//null, new GeneralListCellFactory(Item, true, true, 40));
			jlist.setListData(list);
			jlist.addSelectionListener(function(e:*):void{
				//trace(jlist.getSelectedValue()['label'], jlist.getSelectedValue()['data']);
			});
			var jp:JScrollPane = new JScrollPane();
			jp.setView(jlist);
			//jp.setViewportView(jlist);
			jp.setSizeWH(100, 100);
			_panel.append(jp);
			
			var _a:Component = new Component();
			_a.setSizeWH(200, 10);
			_a.addChild(CreateAlphaSP(false, 200, 10, 0, 0, 0xff0000, 0.5));
			var jp1:JScrollPane = new JScrollPane();
			jp1.setViewportView(_a);
			jp1.setSizeWH(100, 100);
			//jp1.setX(200);
			//jp1.setY(200);
			_panel.append(jp1);
			
			var label:JTextArea = new JTextArea();
			var _tf:TextFormat = new TextFormat("宋体", 12, 0xFFFFFF);
			_tf.letterSpacing = 3;
			_tf.align = TextFieldAutoSize.CENTER;
			label.setSizeWH(100, 48);
			label.setHtmlText("la\nA<b>Ab\nel</b>1\n23\n4\n56");
			label.setTextFormat(_tf);
			label.setDefaultTextFormat(_tf);
			label.getTextField().filters = TextFilter();
			//label.setEditable(false);
			//label.getTextField().selectable = false;
			label.setWordWrap(true);
			_tf = label.getTextFormat();
			//_tf.align = TextFieldAutoSize.RIGHT;
			label.setTextFormat(_tf);
			label.setDefaultTextFormat(_tf);
			label.getUI();
			label.getBackground();
			label.pack();
			
			var jp3:JScrollPane = new JScrollPane();
			jp3.setView(label);
			jp3.setSizeWH(80, 80);
			jp3.setLocationXY(0, 120);
			_panel.append(jp3);
			
			
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
				</root>;
			function createTreeNode(xml:XML):DefaultTreeModel{
				var root:DefaultMutableTreeNode = new DefaultMutableTreeNode(new ListDataModel(xml.@label, xml.@data));
				loopTreeNode(xml, root);
				return new DefaultTreeModel(root);
			}
			
			var _tree:JTree = new JTree();
			_tree.addSelectionListener(function(e:TreeSelectionEvent):void{
				var _arr:Array = e.getNewLeadSelectionPath().getPath();
				var _len:int = _arr.length;
				var _mi:Object = DefaultMutableTreeNode(_arr[_len - 1]).getUserObject();
				if(_mi is String){
					trace(_mi);
				}else{
					trace(_mi.data, _mi.label);
				}
			});
//			var _ui:ComponentUI = _tree.getUI();
//			_ui.putDefault("Tree.folderExpandedIcon", FolderIconExpanded);
//			_ui.putDefault("Tree.folderCollapsedIcon", FolderIconExpanded);
			
			_tree.setModel(createTreeNode(_xml));
			//_tree.setCellFactory(new GeneralTreeCellFactory(CustomTreeCell));
//			_tree.expandRow(1);
//			_tree.collapseRow(0);
//			_tree.expandRow(0);
			_tree.setRootVisible(false);
//			_tree.setSizeWH(100, 200);
//			_tree.setLocationXY(500, 500);
			_tree.setDragEnabled(true);
			_tree.setDropTrigger(true);
			
			
			
			var jp4:JScrollPane = new JScrollPane();
			jp4.setView(_tree);
			//jp4.setViewport(_tree);
			//jp4.setViewportView(_tree);
			jp4.setSizeWH(120, 150);
			jp4.setLocationXY(100, 0);
			_panel.append(jp4);
			jp4.doubleClickEnabled = true;
			jp4.addEventListener(MouseEvent.DOUBLE_CLICK, function(e:MouseEvent):void{
				jp4.setWidth(44);
				jp4.setHeight(44);
				jp4.validate();
			});
			
			
			var _check:JCheckBox = new JCheckBox();
			_check.setSelected(true);
			_check.setLocationXY(200, 300);
			_check.setText("Anlei");
			_check.pack();
			_check.addActionListener(function(e:Object):void{
				trace(_check.isSelected());
			});
			_panel.append(_check);
			
			
			
			new JButton();
			new JSlider();
			new JAccordion();
			
			
			var tab_0:Component = new Component();
			var tab_0_btn:JButton = new JButton("A");
			tab_0_btn.setSizeWH(100, 24);
			tab_0_btn.setLocationXY(30, 30);
			tab_0.addChild(tab_0_btn);
			
			var _tab:JTabbedPane = new JTabbedPane();
			_tab.setSizeWH(300, 200);
			_tab.setLocationXY(140, 180);
			_tab.appendTab(new JButton("Aaaa2"), "Anlei2",null,"大朋2");
			_tab.appendTab(tab_0, "Tab_0",null,"大朋3");
			_tab.appendTab(new JButton("Aaaa3"), "Anlei3",null,"大朋3");
			_tab.setTabPlacement(JTabbedPane.LEFT);
			_tab.setSelectedIndex(1, true);
			_tab.setSelectedIndex(0, true);
//			_tab.removeTabAt(
			
			_panel.append(_tab);
			
			
			
			this.addChild(_panel);
		}
		private function TextFilter(_color:uint = 0x000000, _alpha:Number = 1):Array
		{
			return [new GlowFilter(_color,_alpha,2,2,10,1)];
		}
		private function onSelected(e:*):void
		{
			trace(e.currentTarget.getSelectedItem().label);
		}
		
		private function CreateAlphaSP(_mouseEnabled:Boolean,
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
		
		private function loopTreeNode(nodeXML:XML, nodeTree:DefaultMutableTreeNode):void
		{
			var sonTree:DefaultMutableTreeNode;
			//var strXML:String;
			for each (var elementXML:XML in nodeXML.elements())
			{
				sonTree = null;
				//strXML = "";
				/*for each (var attributeXML:XML in elementXML.attributes())
				{
					strXML += attributeXML.toString() + " ";
				}*/
				sonTree = new DefaultMutableTreeNode(new ListDataModel(String(elementXML.@label), String(elementXML.@data)));
				loopTreeNode(elementXML, sonTree);
				
				nodeTree.append(sonTree);
			}
		}
		
	}
}

