package net.an86.tile.peo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.ui.MyBitmapText;
	import net.an86.ui.menu.ATMenuItem;

	public class PeoItem extends Sprite
	{
		private var _role:ATRoleBasic;
		private var bg:Bitmap = new Bitmap();
		
		private var name_txt:MyBitmapText = new MyBitmapText();
		private var info_txt:MyBitmapText = new MyBitmapText();
		
		private var face_bit:Bitmap;
		private var name_bit:Bitmap;
		private var info_bit:Bitmap;
		
		public var at_bit:ATMenuItem = new ATMenuItem();
		public var dp_bit:ATMenuItem = new ATMenuItem();
		public var ahp_bit:ATMenuItem = new ATMenuItem();
		
		public function PeoItem($role:ATRoleBasic)
		{
			if($role){
				role = $role;
			}
			inits();
		}
		
		private function inits():void
		{
			//name_txt.border = true;
			name_txt.width = 55;
			name_txt.height = 34;
			//info_txt.border = true;
			info_txt.width = 110;
			info_txt.height = 90;
			
			var bd:BitmapData = new PeoPng(0, 0);
			bg.bitmapData = bd;
			addChildAt(bg, 0);
			
			at_bit.x = 180;
			at_bit.y = 15;
			
			dp_bit.x = 180;
			dp_bit.y = 45;
			
			ahp_bit.x = 180;
			ahp_bit.y = 75;
			
			
			addChild(at_bit);
			addChild(dp_bit);
			addChild(ahp_bit);
			
		}

		public function get role():ATRoleBasic { return _role; }
		public function set role(value:ATRoleBasic):void {
			_role = value;
			HeroData.get(role);
			
			name_txt.text = "Lv"+ role.roleData.level + ' ' + role.roleData.name;
			info_txt.text = "Exp:\t" + role.roleData.exp + '/' + role.roleData.maxExp + '\n'
				+ "HP:\t" + role.roleData.hp + '\n'
				+ '攻击:\t' + role.roleData.at + '\n'
				+ '防御:\t' + role.roleData.dp + '\n';
			
			if(name_bit == null){
				name_bit = name_txt.bitmap;
				name_bit.x = 12;
				name_bit.y = 83;
				addChild(name_bit);
			}
			
			if(info_bit == null){
				info_bit = info_txt.bitmap;
				info_bit.x = 80;
				info_bit.y = 22;
				addChild(info_bit);
			}
			
			name_bit.bitmapData = name_txt.getBitmapData();
			info_bit.bitmapData = info_txt.getBitmapData();
			
			at_bit.data = role.roleData.equip_at;
			dp_bit.data = role.roleData.equip_dp;
			ahp_bit.data = role.roleData.equip_ahp;
			
			if(!face_bit){
				face_bit = new Bitmap();
				addChild(face_bit);
				face_bit.x = 17;
				face_bit.y = 26;
			}
			
			if(!face_bit.bitmapData){
				var _cls:Class = ApplicationDomain.currentDomain.getDefinition('RoleFace_' + role.roleData.id) as Class;
				face_bit.bitmapData = new _cls(0, 0);
			}
			
		}
		
		public function clear():void{
			name_txt.clear();
			info_txt.clear();
			at_bit.clear();
			dp_bit.clear();
			ahp_bit.clear();
			if(face_bit.bitmapData){
				face_bit.bitmapData = null;
			}
		}

	}
}