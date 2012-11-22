package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import net.an86.tile.ATConfig;
	import net.an86.tile.ATGame;
	import net.an86.tile.role.ATRoleBasic;
	
	[SWF(width="300",height="300",frameRate="30",backgroundColor="#CCCCCC")]
	public class AnleiTile extends Sprite
	{
		
		public function AnleiTile()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var _sp:Sprite = new Sprite();
			_sp.graphics.beginFill(0x00CCFF, 0.5);
			_sp.graphics.drawRect(0, 0, 300, 300);
			_sp.graphics.endFill();
			addChild(_sp);
			this.addEventListener(MouseEvent.CLICK, onStart_click);
		}
		
		private function onStart_click(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.CLICK, onStart_click);
			ATGame.init(this);
			//Alert.show('Anlei\n8349\naskflsldkfsldf', 100, 200);
			//
			var role:ATRoleBasic = new ATRoleBasic();
			role.setBitmapData(new Role_0(0, 0));
			ATGame.addRole(role);
			ATGame.setPos(role, 4, 5);
			ATGame.change(ATConfig.getConfig(1001));
			/*
			var npc:ATNpcBasic = new ATNpcBasic(1001);
			npc.setBitmapData(new Role_1(0, 0));
			ATGame.addNpc(npc, 6, 6);
			
			*/
			//////////////
			/*ApplicationStats.getInstance().init(this);
			ApplicationStats.getInstance().visible = true;
			addChild(ApplicationStats.getInstance());*/
			//////////////
			
		}
	}
}