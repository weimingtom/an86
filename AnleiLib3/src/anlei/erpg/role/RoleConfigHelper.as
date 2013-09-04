package anlei.erpg.role
{
import anlei.erpg.utils.Actions;

import flash.geom.Point;
import flash.utils.Dictionary;

public class RoleConfigHelper
{
    private static var _actions:Array;

    public static function get dict():Array
    {
        if (!_actions)
        {
            init();
        }
        return _actions;
    }

    private static function init():void
    {
        _actions = new Array(12);
        _actions[0] = "attack1";
        _actions[1] = "attack2";
        _actions[2] = "attack3";
        _actions[3] = "stand";
        _actions[4] = "run";
        _actions[5] = "hit";
        _actions[6] = "battle_stand";
        _actions[7] = "skiatk";
        _actions[8] = "skiatk_summ";
        _actions[9] = "skiatk_stop";
        _actions[10] = "zj_run";
        _actions[11] = "zj_stand";
    }

    public static function getActionNameList(actionArr:Array):Array
    {
        if (!actionArr)
            return [];
        var arr:Array = [];

        for (var i:int = 0; i < actionArr.length; i++)
        {
            if (actionArr[i] == 1)
                arr.push(actionArr[i]);
        }
        return arr;
    }

    public static function convertFromXML(xml:XML):RoleConfig
    {
        var c:RoleConfig = new RoleConfig();

        if (!xml)
            return c;
        c.actionArr = (xml.actionArr).toString().split(",");
        c.chestHeight = int(xml.chestHeight);
        c.height = int(xml.height);
		c.mountHeight = int(xml.mountHeight);
        c.hitFrame = int(xml.hitFrame);
		c.skinId = xml.skinId.toString();
		c.sn = int(xml.sn);
		c.splHitFrame = int(xml.splHitFrame);
		c.splThrowItemID = xml.splThrowItemID.toString();
		c.splThrowPoint = strToPt(xml.splThrowPoint.toString());
		c.throwItemID = xml.throwItemID.toString();
		c.throwPoint = strToPt(xml.throwPoint.toString());
		return c;
    }
	
	public static function getActionIndex(action:int):int
	{
		var r:int = -1;
		switch(action)
		{
			case Actions.Attack1:
				r=0;
				break;
			case Actions.Attack2:
				r=1;
				break;
			case Actions.Attack3:
				r=2;
				break;
			case Actions.Stop:
				r=3;
				break;
			case Actions.Run:
				r=4;
				break;
			case Actions.BeAtk:
			case Actions.Die:
				r=5;
				break;
			case Actions.BattleStop:
				r=6;
				break;
			case Actions.SKIATK:
				r=7;
				break;
			case Actions.SKIATK_SUMMONING:
				r=8;
				break;
			case Actions.SKIATK_STOP:
				r=9;
				break;
			case Actions.ZJ_Run:
				r=10;
				break;
			case Actions.ZJ_Stop:
				r=11;
				break;
		}
		return r;	
	}

    public static function defaultActionArr():Array
    {
        return [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    }
	
	private static function strToPt(str:String):Point
	{
		var pt:Point = new Point();
		var strArr:Array = str.split(",");
		if(strArr.length>0)
			pt.x=Number(strArr[0]);
		if(strArr.length>1)
			pt.y=Number(strArr[1]);
		return pt;
	}
}
}
