package componetset
{
	import org.aswing.ASFont;
	import org.aswing.BorderLayout;
	import org.aswing.Component;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTree;
	import org.aswing.LayoutManager;
	import org.aswing.tree.DefaultMutableTreeNode;
	import org.aswing.tree.DefaultTreeModel;
	import org.aswing.tree.GeneralTreeCellFactory;
	import org.aswing.tree.TreeModel;

	public class Tree extends JPanel
	{
		var tree:Component;
		public function Tree(layout:LayoutManager=null)
		{
			super(new BorderLayout);
			
			tree=creatTree();
			
			append(tree);
		}
		private function creatTree():Component{
			var tree:JTree=new JTree(treeNode());
			tree.setRootVisible(false);
			tree.setRowHeight(20);
			tree.setCellFactory(new GeneralTreeCellFactory(IconTreeCell));
			return new JScrollPane(tree);
		}
		private function treeNode():TreeModel{
			var root:DefaultMutableTreeNode=new DefaultMutableTreeNode("");
			var child:DefaultMutableTreeNode=new DefaultMutableTreeNode("好友");
			for(var i:uint=0;i<40;i++){
				var next:DefaultMutableTreeNode=new DefaultMutableTreeNode(i+":天天笑");
				child.append(next)
			}			
			root.append(child);
			var child:DefaultMutableTreeNode=new DefaultMutableTreeNode("同事");
			for(var i:uint=0;i<40;i++){
				var next:DefaultMutableTreeNode=new DefaultMutableTreeNode(i+":笑天天");
				child.append(next)
			}
			root.append(child);
			
			return new DefaultTreeModel(root);
		}
	}
}