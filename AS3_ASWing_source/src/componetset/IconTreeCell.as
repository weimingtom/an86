package componetset
{
	import org.aswing.Icon;
	import org.aswing.LoadIcon;
	import org.aswing.tree.DefaultTreeCell;

	public class IconTreeCell extends DefaultTreeCell
	{
		public function IconTreeCell()
		{
			super();
		}
		override public function getCollapsedFolderIcon():Icon{
			return new LoadIcon("images/icon/46.png",16,16,false,null);
		}
		override public function getExpandedFolderIcon():Icon{
			return new LoadIcon("images/icon/47.png",16,16,false,null);
		}
		override public function getLeafIcon():Icon{
			if(Math.random()>0.5){
				return new LoadIcon("images/icon/20_m.jpg",16,16,false,null);
			}else{
				return new LoadIcon("images/icon/28_m.jpg",16,16,false,null);
			}
			
		}
	}
}