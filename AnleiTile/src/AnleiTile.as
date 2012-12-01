package
{
	import anlei.debug.ApplicationStats;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.utils.ATSceneConfig;
	import net.an86.utils.ImportClass;
	
	[SWF(width="400",height="300",frameRate="30",backgroundColor="#CCCCCC")]
	public class AnleiTile extends Sprite
	{
		
		public function AnleiTile()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			/*var _sp:Sprite = new Sprite();
			_sp.graphics.beginFill(0x00CCFF, 0.5);
			_sp.graphics.drawRect(0, 0, 300, 300);
			_sp.graphics.endFill();
			addChild(_sp);*/
			stage.addEventListener(MouseEvent.CLICK, onStart_click);
		}
		
		private function onStart_click(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.CLICK, onStart_click);
			
			new ImportClass();
			
			ATGame.init(this);
			//Alert.show('Anlei\n8349\naskflsldkfsldf', 100, 200);
			//
			var role:ATRoleBasic = new ATRoleBasic();
			role.setBitmapData(new Role_0(0, 0));
			ATGame.addRole(role);
			ATGame.setPos(role, 4, 5);
			ATGame.change(ATSceneConfig.getConfig(1001));
			
			role.roleData.equip_at.id = 2;
			role.roleData.equip_at.name = '水果刀';
			role.roleData.equip_at.data = 7;
			role.roleData.equip_at.price = 50;
			role.roleData.equip_at.type = 'zb,at';
			
			role.roleData.equip_dp.id = 13;
			role.roleData.equip_dp.name = '旅人之服';
			role.roleData.equip_dp.data = 3;
			role.roleData.equip_dp.price = 100;
			role.roleData.equip_dp.type = 'zb,dp';
			/*
			role.roleData.equip_ahp.id = 24;
			role.roleData.equip_ahp.name = '祈祷戒指';
			role.roleData.equip_ahp.data = 40;
			role.roleData.equip_ahp.price = 1000;
			role.roleData.equip_ahp.type = 'zb,ahp';
			*/
			/*
			var npc:ATNpcBasic = new ATNpcBasic(1001);
			npc.setBitmapData(new Role_1(0, 0));
			ATGame.addNpc(npc, 6, 6);
			
			*/
			//////////////
			ApplicationStats.getInstance().init(this);
			ApplicationStats.getInstance().visible = false;
			addChild(ApplicationStats.getInstance());
			//////////////
			
		}
	}
}