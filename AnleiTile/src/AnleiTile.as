package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.ATMapConfig;
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.utils.ApplicationStats;
	import net.an86.utils.MyImage;
	
	[SWF(width="600",height="600",frameRate="30",backgroundColor="#CCCCCC")]
	public class AnleiTile extends Sprite
	{
		
		public function AnleiTile()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var _sp:Sprite = new Sprite();
			_sp.graphics.beginFill(0x00CCFF, 0.5);
			_sp.graphics.drawRect(0, 0, 600, 600);
			_sp.graphics.endFill();
			addChild(_sp);
			
			ApplicationStats.getInstance().init(this);
			ApplicationStats.getInstance().visible = true;
			addChild(ApplicationStats.getInstance());
			
			ATGame.init(this);
			//
			var role:ATRoleBasic = new ATRoleBasic();
			role.cartoon.setGapTime(100);
			ATGame.addRole(role);
			
			var img:MyImage = new MyImage('assets/char/role.png', function():void{
				role.setBitmapData(img.bitmapData);
				ATGame.setPos(role, 4, 5);
				ATGame.change(ATMapConfig.getMap(1001));
			});
			
		}
	}
}