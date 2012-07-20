package componetset
{
	import org.aswing.*;

	public class IconListCell extends DefaultListCell
	{
		public function IconListCell()
		{
			super();
		}
		
		override public function setCellValue(value:*) : void {
			if(this.value != value){
				this.value = value;
				getJLabel().setText(value.toString());
				//修改进入条件可以更换图标
				if(Math.random() > 0.5){
					getJLabel().setIcon(new LoadIcon("images/face/Vista_icons_01.png",20,20,false,null));
					//getJLabel().setIcon(new ColorIcon(new ASColor(Math.random()*0xFFFFFF), 10+Math.random()*30, 10+Math.random()*30));
				}else{
					getJLabel().setIcon(new LoadIcon("images/face/Vista_icons_02.png",20,20,false,null));
					//getJLabel().setIcon(new CircleIcon(new ASColor(Math.random()*0xFFFFFF), 10+Math.random()*30, 10+Math.random()*30));
				}
			}
		}
		
	}
}