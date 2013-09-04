package anlei.erpg.role
{

import flash.geom.Point;

public class RoleConfig
{
    public function RoleConfig()
    {
        actionArr = RoleConfigHelper.defaultActionArr();
    }

    public var sn:int = 0;

    public var skinId:String = "";

    public var chestHeight:int;
	
	public var mountHeight:int;

    public var height:int;

    private var _actionArr:Array;
	
    private var _actionList:Array = [];

    /**
     * 动作列表
     */
    public function get actionArr():Array
    {
        return _actionArr;
    }

    /**
     * @private
     */
    public function set actionArr(value:Array):void
    {
        _actionArr = value;
        _actionList = RoleConfigHelper.getActionNameList(_actionArr);
    }

    /**
     * 投掷点
     */
    public var throwPoint:Point = new Point();
    /**
     * 技能投掷点
     */
    public var splThrowPoint:Point = new Point();
    /**
     * 击中帧
     */
    public var hitFrame:int;
    /**
     * 技能击中帧
     */
    public var splHitFrame:int;
    /**
     * 投掷物ID
     */
    public var throwItemID:String = "";
    /**
     * 技能投掷物ID
     */
    public var splThrowItemID:String = "";

    /**
     * 动作名称大小
     */
    public function get actionList():Array
    {
        return _actionList;
    }
	
	public function dispose():void{
		throwPoint = null;
		splThrowPoint = null;
		_actionList = null;
		_actionArr = null;
	}
}
}
