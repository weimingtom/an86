package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.ATMapConfig;
	import net.an86.tile.role.ATNpcBasic;
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.utils.ApplicationStats;
	
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
			
			ATGame.init(this);
			//
			var role:ATRoleBasic = new ATRoleBasic();
			role.setBitmapData(new Role_0(0, 0));
			ATGame.addRole(role);
			ATGame.setPos(role, 4, 5);
			ATGame.change(ATMapConfig.getMap(1001));
			
			var npc:ATNpcBasic = new ATNpcBasic();
			npc.setBitmapData(new Role_1(0, 0));
			ATGame.addNpc(npc, 3, 2);
			
			
			//////////////
			ApplicationStats.getInstance().init(this);
			ApplicationStats.getInstance().visible = true;
			addChild(ApplicationStats.getInstance());
			//////////////
			
		}
	}
}