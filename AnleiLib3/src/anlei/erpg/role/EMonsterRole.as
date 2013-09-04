package anlei.erpg.role
{
import flash.geom.Point;
import flash.utils.getTimer;

import anlei.erpg.EGame;
import anlei.erpg.utils.Actions;
import anlei.util.CoorAway;
import anlei.util.EnterFrame;

public class EMonsterRole extends ERole
{
    /**
     * 怪物视野距离
     */
    public static const SIGHT_RANGE:int = 350;
	/**
	 * 追踪的极限距离 
	 */	
	public static const CHANSE_RANGE:int = 450;
    /**
     * 追逐玩家的移动速度
     */
    public static const CHASE_MOVE_SPEED:int = 15;
    /**
     * 普通移动速度
     */
    public static const MOVE_SPEED:int = 5;
    /**
     * 最大行动时间
     */
    public static const MAX_ACTION_INTERVAL:int = 5000;
    /**
     * 最小行动时间
     */
    public static const MIN_ACTION_INTERVAL:int = 2000;
    /**
     * 最大移动范围
     */
    public static const MOVE_RANGE:int = 200;

    public function EMonsterRole($isNPC:Boolean, $skinId:Number, $uid:Number, $resourceURL:String = "asset/role/")
    {
        super($isNPC, $skinId, $uid, $resourceURL);
        roleCtrl.speed = MOVE_SPEED;
		isBattleRole=true;
		action = Actions.BattleStop;
		randomMoveEnabled=true;
		interactable=true;
    }

    private var _player:ERole;
    private var _moveTimer:int;
    private var _nextMove:int;
    private var _nextPos:Point;
	private var _interactable:Boolean;
	private var _randomMoveEnabled:Boolean;
	private var _isRetreating:Boolean;

	public function get randomMoveEnabled():Boolean
	{
		return _randomMoveEnabled;
	}

	public function set randomMoveEnabled(value:Boolean):void
	{
		_randomMoveEnabled = value;
	}

	/**
	 * 当怪物触碰到玩家以后执行的方法(接受1参数,类型MonsterRole)
	 */	
	public var onTouchedPlayer:Function;
	
	private var __lastTimer:int;
	
	/**
	 * 下个目标
	 */	
	public function get nextPos():Point
	{
		return _nextPos;
	}

	/**
	 * 是否可以开始追逐英雄
	 */	
	public function get interactable():Boolean
	{
		return _interactable;
	}

	public function set interactable(value:Boolean):void
	{
		_interactable = value;
	}
    private var _inAction:Boolean;

	/**
	 * 是否在随机移动
	 */
	public function get inAction():Boolean
	{
		return _inAction;
	}

    private var _chasing:Boolean;

	/**
	 * 是否在追逐玩家
	 */
	public function get chasing():Boolean
	{
		return _chasing;
	}
	
	public function get isOutOfChanceRange():Boolean
	{
		var xDiff:Number = this.x-monster_init_x;
		var yDiff:Number = this.y-monster_init_y;
		
		return Math.sqrt(xDiff*xDiff+yDiff*yDiff)>CHANSE_RANGE;
	}

    private function get player():ERole
    {
        if (!_player)
        {
            _player = EGame.camera.game.scene.playRole;
        }
        return _player;
    }

    /**
     * 玩家是否在视线内
     */
    private function get isPlayerInSight():Boolean
    {
        var diffX:int = player.x - this.x;
        var diffY:int = player.y - this.y;
        var range:int = Math.sqrt(diffX * diffX + diffY * diffY);
        return range < SIGHT_RANGE;
    }

    public function aiStart():void
    {
		__lastTimer=getTimer();
		if(EnterFrame.hasFunction(aiLoop)==null)
			EnterFrame.enterFrame = aiLoop;
		action = Actions.BattleStop;
    }

    public function aiStop():void
    {
		if(EnterFrame.hasFunction(aiLoop)!=null)
			EnterFrame.removeEnterFrame = aiLoop;
		action = Actions.BattleStop;
    }
	
	/**
	 * 重置怪物位置
	 */
	public function resetPosition():void
	{
		roleCtrl.clearPath();
		this.x = this.monster_init_x;
		this.y = this.monster_init_y;
		_chasing = false;
		_inAction = false;
	}

    private function aiLoop():void
    {
		if(!this.visible)
			return;
		var timer:int = getTimer();
		var interval:int = timer-__lastTimer;
		__lastTimer = timer;
        if (_chasing)
        {
			if(!interactable)
			{
				roleCtrl.clearPath();
				idle();
				return;
			}
			if(isOutOfChanceRange)
			{
				retreat();
			}
			else
			{
            	moveToPlayer();//如果怪物触碰到玩家
				if (isPlayerInSight && CoorAway.getToTargetDistance(_nextPos, this.getPos()) <= this.roleCtrl.speed * 2)
				{
					if(onTouchedPlayer!=null)
						onTouchedPlayer(this);
					resetPosition();
				}
			}
        }
		else if(_isRetreating)
		{
			var p:Point = new Point(this.monster_init_x,this.monster_init_y);
			if(CoorAway.getToTargetDistance(p, this.getPos()) <= this.roleCtrl.speed * 2)
			{
				_isRetreating=false;
			}
		}
        else if (isPlayerInSight&&interactable)
        {
			if(!_isRetreating)
           	 moveToPlayer();
        }
        //行动时间结束
        else if (_nextMove <= _moveTimer)
        {
            randomAction();
            _moveTimer = 0;
            _nextMove = Math.random() * (MAX_ACTION_INTERVAL - MIN_ACTION_INTERVAL) + MIN_ACTION_INTERVAL;
        }
        else
        {
            if (_inAction)
            {
                if (CoorAway.getToTargetDistance(_nextPos, this.getPos()) <= this.roleCtrl.speed * 2 / 3)
                {
                    _inAction = false;
					this.action = Actions.BattleStop;
                }
            }
            else
                _moveTimer += interval;
        }
    }

    /**
     * 开始随机移动
     */
    private function randomAction():void
    {
		if(randomMoveEnabled)
		{
	        if (Math.random() > .5)
	            idle();
	        else
	            moveToRandomPlace();
		}
		else
		{
			idle();
		}
    }

    /**
     * 开始随机移动
     */
    private function moveToRandomPlace():void
    {
        this.roleCtrl.speed = MOVE_SPEED;
        _nextPos = new Point(int(-MOVE_RANGE + Math.random() * MOVE_RANGE * 2) + this.monster_init_x,
            int(-MOVE_RANGE + Math.random() * MOVE_RANGE * 2) + this.monster_init_y);

        if (_nextPos.y > EGame.H - 20)
            _nextPos.y = EGame.H - 20;
        else if (_nextPos.y < 330)
            _nextPos.y = 330;

        if (_nextPos.x > EGame.W - 20)
            _nextPos.x = EGame.W - 20;
        else if (_nextPos.x <= 20)
            _nextPos.x = 20;
        this.roleCtrl.clearPath();
        this.roleCtrl.setPath(_nextPos.x, _nextPos.y);
        _inAction = true;
        _chasing = false;
    }

    /**
     * 进入发呆状态
     */
    private function idle():void
    {
        this.action = Actions.BattleStop;;
        _inAction = false;
        _chasing = false;
    }


    private function moveToPlayer():void
    {
        this.roleCtrl.speed = CHASE_MOVE_SPEED;
        _nextPos = new Point(player.x, player.y);
        //this.roleCtrl.clearPath();
        this.roleCtrl.setPath(_nextPos.x, _nextPos.y);
        _chasing = true;
        _inAction = false;
    }
	
	private function retreat():void
	{
		this.roleCtrl.speed = CHASE_MOVE_SPEED;
		_nextPos = new Point(monster_init_x, monster_init_y);
		this.roleCtrl.setPath(_nextPos.x, _nextPos.y);
		_chasing = false;
		_inAction = false;
		_isRetreating=true;
	}

    public override function dispose():void
    {
		_nextPos=null;
        aiStop();
		EnterFrame.removeEnterFrame = aiLoop;
        _player = null;
		onTouchedPlayer=null;
		super.dispose();
    }
}
}
