package net.an86.tile.peo
{
	import anlei.db.AccessDB;
	
	import net.an86.tile.role.ATRoleBasic;
	import net.an86.tile.role.utils.RoleData;

	public class HeroData
	{
		public static function get($role:ATRoleBasic):void {
			var _xml:XML = AccessDB.getInstance().zip.getFieldList('hero', 'level', $role.roleData.level.toString());
			var _rd:RoleData = $role.roleData;
			_rd.maxExp = _xml.maxExp;
			_rd.at = Number(_xml.heroAT) + Number(_rd.equip_at.data);
			_rd.dp = Number(_xml.heroDP) + Number(_rd.equip_dp.data);
			_rd.ahp= Number(_xml.HeroHP) + Number(_rd.equip_ahp.data);
			_rd.hp = Number(_xml.heroHP) + _rd.ahp;
			_rd.maxHP = _rd.hp;
		}
	}
}