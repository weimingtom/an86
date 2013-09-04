package anlei.erpg.role
{
import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextFieldAutoSize;
import flash.utils.Dictionary;

import Events.GlobalEvent;

import anlei.db.AccessDB;
import anlei.debug.ApplicationStats;
import anlei.erpg.EGame;
import anlei.erpg.utils.Actions;
import anlei.erpg.utils.AssetsPool;
import anlei.erpg.utils.RndAction;

import ui.component.MyHVBox;
import ui.component.MyLoader;
import ui.component.MySprite;
import ui.component.MyTextField;

/**基础角色类*/
public class AbsERole extends MySprite
{
    [Embed(source = "/asset/role/shadow.png")]
    public static const DEF_SHADOW:Class;

    /**排序ID*/
    public var SORT_ID:int = 0;

    /**路点KEY ID*/
    public static const ROAD_ID:int = 1;

    public var _W:Number;
    public var _H:Number;
    /**各个动作的记录*/
    public var action_dict:Dictionary = new Dictionary();
    /**各个动作是否循环的记录,默认全部循环*/
    protected var actionLoopDict:Dictionary = new Dictionary();

    /**名字文本*/
    private var nameText:MyTextField;

    /**名字文本转成位图*/
    public var _textBitmap:Bitmap;
    /**预加载的假人图片*/
    protected var offShadow:Bitmap;

    /**当前动作*/
    public var _action:int;
    /**动作资源路径*/
    private var resourceURL:String = EGame.HTTP + "asset/role/";

    /**动作加载完成方法*/
    public var onActiveComplete:Function;
    /**名字色彩*/
    public var nameTextColor:Number;
    /**坐骑ID*/
    private var _mounts:int = 0;

    public var mountRes:EMount;

    private var _skinId:Number = 0;

    public var title:MyHVBox = new MyHVBox();
    /**动作MC层*/
    public var render:MySprite = new MySprite();
    public var uid:Number;
    /**是否是远程对话(跑到NPC跟前说话)*/
    public var remote:Boolean = false;
    public var isNPC:Boolean;
    public var iconLoad:MyLoader;
    /**每次播入完后执行*/
    public var onActionCompleted:Function;

    /**ID转皮肤ID*/
    public static var coveSkinId:Function;
    /** 战斗动作是否重复 */
    public var isActionLoop:Boolean;
    /** 是否是战斗角色 */
    public var isBattleRole:Boolean;
    /** 动作是否暂停 */
    public var pauseAnimation:Boolean;
    /** 单次动作是否执行完成 */
    private var actionComplete:Boolean;

    private var rndAction:RndAction;
    /**玩家的控制方法*/
    public var roleCtrl:ERoleCtrl;
    private var tween:TweenLite;

    /**怪是否死了，默认是活的*/
    public var isDie:Boolean = false;
    /**
     * 是否显示假人图片
     */
    public var isShowShadow:Boolean = true;
    /**
     * 战士随机动作
     */
    public var showRandomAction:Boolean = true;

    public function AbsERole($isNPC:Boolean, $skinId:Number, $uid:Number, $resourceURL:String)
    {
        isNPC = $isNPC;
        uid = $uid;
        skinId = $skinId;
        resourceURL = $resourceURL;

        offShadow = new DEF_SHADOW();
        offShadow.x = -offShadow.width / 2;
        offShadow.y = -offShadow.height;

        addChild(render);
        addChild(title);

        //mountRes = new EMount(this);

//			title.width = title.height = 200;
//			title.updateSize();
//			title.isBG = true;
        title.HAlign = MyHVBox.H_CENTER;
        title.VAlign = MyHVBox.V_BOT;
        title.x = -title.width / 2;

        //监视动作行为
        render.addEventListener(Event.ENTER_FRAME, onLoopEnter);

//			render.graphics.clear();
//			render.graphics.beginFill(0xFF0000, 0.5);
//			render.graphics.drawRect(-5, -5, 10, 10);
//			render.graphics.endFill();

//			graphics.beginFill(0xCCCCCC, 0.5);
//			graphics.drawRect(-10, -10, 20, 20);
//			graphics.endFill();
        rndAction = new RndAction(this);
        this.mouseChildren = false;
        this.useHandCursor = true;
        this.buttonMode = true;
    }

    private var _skinConfig:RoleConfig = new RoleConfig();

    /** 角色配置  */
    public function get skinConfig():RoleConfig
    {
        return _skinConfig;
    }

    protected function clearActionDict():void
    {
        for (var _item:String in action_dict)
        {
            delete action_dict[_item];
        }
        action = 0;
    }

    /**角色皮肤ID*/
    public function get skinId():Number  { return _skinId; }

    public function set skinId(value:Number):void
    {
        if (_skinId == value)
            return;
        clearActionDict();
        _skinId = value;
        _skinId = coveSkin();

        //////////////////////////
        getSkinConfig();
    }

    /**ID转皮肤ID*/
    public function coveSkin():int
    {
        var _sid:int = skinId;

        if (coveSkinId && ERole.isMonster(uid))
            _sid = coveSkinId(_sid);
        return _sid;
    }

    override public function set x(value:Number):void
    {
        super.x = value;
    }

    override public function set y(value:Number):void
    {
        super.y = value;
    }

    /**获取名字图形文本
    public function getBitmapText():Bitmap{ return _textBitmap; }*/

    /**获取名字文本*/
    public function getNameText():MyTextField
    {
        if (nameText == null)
        {
            nameText = new MyTextField();
            nameText.wordWrap = false;
            nameText.autoSize = TextFieldAutoSize.LEFT;
			nameText.format.color = nameTextColor;
			//nameText.border = true;
			//nameText.format.bold = true;
        }
        return nameText;
    }

    /**角色的名字*/
    public function setName(value:String, $color:Number = 0xFFFFFF):void
    {
        nameTextColor = $color;

        if (value)
        {
            createBitmapText(value);
        }
        else
        {
            if (_textBitmap && title.contains(_textBitmap))
            {
                title.removeChild(_textBitmap);
            }
        } 
    }
	
	public function getName():String
	{
		return getNameText().text;
	}

    private function _trace(value:int):void
    {
        if (isNPC)
            return;
        var _str:String = "主角坐骑:" + value;
        trace(_str);
        ApplicationStats.getInstance().push(_str);
    }

    /**坐骑ID*/
    public function get mounts():int  { return _mounts; }

    public function set mounts(value:int):void
    {
        if (!value)
        {//释放资源
            //mountRes.disposeRes();
            if (mountRes)
            {
                mountRes.remove();
                mountRes.dispose();
                mountRes = null;
            }
        }
        _mounts = value;

        //if(_mounts > 0) _mounts = 103;
        if (mounts > 0)
        {//如果有坐骑，则把待机和跑的动作设成坐骑状态
            if (!mountRes)
            {
                mountRes = new EMount(this);
            }

            if (action == Actions.Run)
            {
                action = Actions.ZJ_Run;
            }

            if (action == Actions.Stop)
            {
                action = Actions.ZJ_Stop;
            }
            getZJSource(action);
        }
        else
        {//否则把坐骑移除掉，并且设回正常待机和跑的动作
            if (mountRes)
            {
                mountRes.remove();
                mountRes.dispose();
                mountRes = null;
            }

            if (action == Actions.ZJ_Run)
            {
                action = Actions.Run;
            }
            else if (action == Actions.ZJ_Stop)
            {
                action = Actions.Stop;
            }
            ///恢复没有坐骑的坐标
            render.x = 0;
            render.y = 0;
            _W = width;
            _H = height;
        }
        setNameY();
    }

//		public function getActionLoop($action:int):int{ return actionLoopDict[$action]; };
//		public function setActionLoop($action:int, $loop:Boolean):void{
//			if($loop){
//				actionLoopDict[$action] = $loop;
//			}else{
//				delete actionLoopDict[$action];
//			}
//			setActionLoopFunc($action);
//		}

    /**预加载显示*/
    public function showShadow():void
    {
        if (!isShowShadow)
            return;

        if (!contains(offShadow))
            addChild(offShadow);
    }

    public function hideShadow():void
    {
        if (offShadow.parent)
			offShadow.parent.removeChild(offShadow);
    }

    /**当前动作*/
    public function get action():int
    {
        return _action;
    }

    /**设置当前动作(Actions.Run)*/
    public function set action(n:int):void
    {
        if (action == n)
            return;
        //////////////
        var _oldAction:int = _action;

        if (mounts)
        {//如果有坐骑，则把角色动作的坐标进行相应配置
            if (n == Actions.ZJ_Run)
            {
                _action = Actions.ZJ_Run;
                n = _action;

                //return;
                if (mountRes)
                    mountRes.addRunX();
                    //if(mountRes.mounts_run_mc) mountRes.mounts_run_mc.gotoAndPlay(2);
            }
            else if (n == Actions.Stop)
            {
                _action = Actions.ZJ_Stop;
                n = _action;

                //return;
                if (mountRes)
                    mountRes.addStandX();
                    //if(mountRes.mounts_stand_mc) mountRes.mounts_stand_mc.gotoAndPlay(2);
            }
		}
        //trace(render.height);
        //移除上一个动作MC
        render.removeAllChild();
        _action = n;

        showShadow();

        //确定当前的动作是否是循环动作
        isActionLoop = !(Actions.OnePlay.indexOf(_action) >= 0);
        ///预加载显示

        var actionIdx:int = RoleConfigHelper.getActionIndex(_action);

        if (actionIdx >= 0 && actionIdx < skinConfig.actionArr.length && skinConfig.actionArr[actionIdx] == 1
            || _action == Actions.Stop1)
        {
            loadSource(getURL(Actions.cove(_action)));
        }

        //若有坐骑则加载
        if (action == Actions.Run || action == Actions.ZJ_Run
            || action == Actions.Stop || action == Actions.ZJ_Stop)
        {
            if (mounts)
                getZJSource(action);
        }
    }

    /*
    private function _trace(value:int):void{
        var _str:String = "NPC:" + isNPC + ", UID:" + dataCustom.uid + ", action:" + value;
        trace(_str);
        ApplicationStats.getInstance().push(_str);
    }
    */
    private function delay_hitest():void
    {
        if (!tween)
        {
            tween = TweenLite.delayedCall(0.5, onDelay_hitest);
        }
    }

    private function onDelay_hitest():void
    {
        if (tween)
            tween.kill();
        tween = null;
        onActiveComplete();
    }

    /**加载角色新动作*/
    public function loadSource(url:String):void
    {
        //if(onActiveComplete == null){
        onActiveComplete = function():void {
            if (!title)return;
            if (onActiveComplete == null)return;

            var _acInt:int = onActiveComplete['action'];
            var _ac:String = Actions.cove(_acInt);
            if (action_dict[_ac] == null) {
                action_dict[_ac] = AssetsPool.getInstance().getSource("res", getKEY(_ac));

                if (!AssetsPool.getInstance().hasSource(getKEY(_ac))) {
                    delay_hitest();
                    return;
                }

            }
            if (_ac == Actions.STAND && showRandomAction) {//如果是待机动作，去取随机动作（目前NPC才有）
                var _s1:String = Actions.cove(Actions.Stop1);
                if (action_dict[_s1] == null) {
                    action_dict[_s1] = AssetsPool.getInstance().getSource("res1", getKEY(_ac));
                    if (action_dict[_s1]) {
                        rndAction.inits();
                    }
                }
            }



            if (action_dict[_ac]) {
                action_dict[_ac]['onActiveComplete'] = onActiveComplete;
                hideShadow();
                if (!render.contains(action_dict[_ac])) {
                    action_dict[_ac].gotoAndPlay(1);
                    render.addChild(action_dict[_ac]);
                }
                if (_acInt == Actions.Run) {
                    if (mountRes && mountRes.mounts_run_mc)mountRes.mounts_run_mc.gotoAndPlay(2);
                }
                if (_acInt == Actions.Stop) {
                    if (mountRes && mountRes.mounts_stand_mc)mountRes.mounts_stand_mc.gotoAndPlay(2);
                }
                    //if(mounts_run_mc) mounts_run_mc.gotoAndPlay(2);
                    //setActionLoopFunc(onActiveComplete['action']);
            }

            setNameY();
            _W = width;
            _H = height;
            if (isNPC)dispatchEvent(new GlobalEvent(Event.COMPLETE, onActiveComplete['action']));
            actionComplete = false;
            ///getZJSource_run();
        }
        //}
        onActiveComplete['action'] = _action;

        if (_action == Actions.Stop1)
        {
            onActiveComplete();
        }
        else
        {
            if (!action_dict[Actions.cove(_action)])
            {//若之前没有加载过动作
                //则试图去资源池中获取
                var onf:Boolean = AssetsPool.getInstance().hasSource(getKEY(Actions.cove(_action)));

                if (!onf)
                {//若资源池中没有该资源,则去加载
                    AssetsPool.getInstance().loadSource(getKEY(Actions.cove(_action)), url, this, onActiveComplete);
                }
                else
                {//若有，则直接执行完成方法
                    onActiveComplete();
                }
            }
            else
            {//若有，则直接执行完成方法
                action_dict[Actions.cove(_action)]['onActiveComplete']();
            }
        }
        setNameY();
    }

    /**坐骑色彩*/
    public function get ZJColor():int  { return 0; }

    public function set ZJColor($ctu:int):void  {}

    /**加载坐骑资源方法*/
    private function getZJSource($action:int):void
    {
        if (mountRes)
            mountRes.add(action, mounts, onMountComplete);
        setNameY();
    }

    private function onMountComplete():void
    {
        _W = width;
        _H = height;
        setNameY();
    }

    private function setNameY():void
    {
        /*if(_textBitmap){
            //trace(this.getRect(render));
            _textBitmap.y = -(render.height + _textBitmap.height - render.y);
        }*/
//			if(title){
//				title.y = -(render.height + title.height - render.y);
//			}
        if (title)
        {
            if (mountRes && mounts)
                title.y = -mountRes.offsetY - _skinConfig.mountHeight;
            else
                title.y = -_skinConfig.height;
        }
    }

//		private function setActionLoopFunc($action:int):void
//		{
//			if(		action_dict.hasOwnProperty(Actions.cove($action))
//				&&	action_dict[Actions.cove($action)]
//				&&	!action_dict[Actions.cove($action)].hasEventListener(Event.ENTER_FRAME)
//			){
//				var _mc:MovieClip = action_dict[Actions.cove($action)];
//				_mc['action'] = $action;
//				_mc.addEventListener(Event.ENTER_FRAME, onLoopEnter)
//			}
//		}

    private function onLoopEnter(e:Event):void
    {
        var actionLen:int = render.numChildren;

        for (var i:int = 0; i < actionLen; i++)
        {
            var c:*;

            if (actionLen != render.numChildren)
            {
                c = render.getChildAt(0);
            }
            else
            {
                c = render.getChildAt(i);
            }
//				if(c&&c==offShadow)
//					continue;
            var mc:MovieClip = c as MovieClip;
			if(!mc) continue;

            if (pauseAnimation)
            {
                mc.stop();
            }
            else if (mc.currentFrame < mc.totalFrames)
            {
                mc.play();
            }

            if (mc.currentFrame == mc.totalFrames)
            {
                if (!isActionLoop)
                {
                    mc.stop();

                    if (Actions.StopToWait.indexOf(_action) >= 0)
                        action = isBattleRole ? Actions.BattleStop : Actions.Stop;

                    if (!actionComplete)
                    {
                        if (onActionCompleted != null)
                            onActionCompleted();
                        actionComplete = true;
                    }
                }
                else if (onActionCompleted != null)
                    onActionCompleted();
            }
        }
//			var _mc:MovieClip = MovieClip(e.currentTarget);
//			if(_mc.currentFrame == _mc.totalFrames){
//				//_mc.removeEventListener(Event.ENTER_FRAME, onLoopEnter);
//				//_mc.stop();
//				//action = Actions.Stop;
//				if(Actions.OnePlay.indexOf(_action)>=0)
//					_mc.stop();
//				if(Actions.StopToWait.indexOf(_action)>=0)
//					action = Actions.Stop;
//				if(actionLoopDict.hasOwnProperty(_mc['action'])
//					&& actionLoopDict[_mc['action']] == true){
//					_mc.gotoAndStop(_mc.totalFrames-1);
//				}
//				if(onActionCompleted!=null) onActionCompleted();
//			}
    }

    /**角色的加载KEY*/
    private function getKEY($action:String):String  { return skinId + '_' + $action; }

    /**角色的加载URL*/
    private function getURL($action:String):String  { return EGame.HTTP + resourceURL + skinId + "/" + $action + '.swf'; }

    /**创建位图式的文本显示*/
    private function createBitmapText(value:String):void
    {
        getNameText();

        if (nameText.text == value&&nameText.format.color == nameTextColor)
            return;
		
		nameText.format.color = nameTextColor;
        nameText.text = value;
		//if(_textBitmap && _textBitmap.bitmapData) _textBitmap.bitmapData.dispose();
		_textBitmap = nameText.bitmap;
		title.addChild(_textBitmap);
		title.reset();
		setNameY();
    }


    /** 读取角色配置 */
    private function getSkinConfig():void
    {
        var xml:XML = AccessDB.getInstance().zip.getFieldList("ae_skin_config", "skinId", String(_skinId));

        if (xml)
            _skinConfig = RoleConfigHelper.convertFromXML(xml);
    }

    public function hasAction(action:int):Boolean
    {
        return _skinConfig.actionArr[RoleConfigHelper.getActionIndex(action)] == 1;
    }

	protected function disposeAssets($action:int):void{
		AssetsPool.getInstance().dispose(getURL(Actions.cove($action)), getKEY(Actions.cove($action)));
	}
	
    override public function dispose():void
    {
        render.removeEventListener(Event.ENTER_FRAME, onLoopEnter);
		if (this.parent)
			this.parent.removeChild(this);
		
		rndAction.dispose();
		rndAction = null;

		disposeAssets(Actions.Run);
		disposeAssets(Actions.Stop);
		var _s1:String = Actions.cove(Actions.Stop1);
		if (action_dict[_s1]) {
			disposeAssets(Actions.Stop);
		}
		disposeAssets(Actions.ZJ_Run);
		disposeAssets(Actions.ZJ_Stop);
		disposeAssets(Actions.Attack1);
		disposeAssets(Actions.Attack2);
		disposeAssets(Actions.Attack3);
		disposeAssets(Actions.BattleStop);
		disposeAssets(Actions.BeAtk);
		disposeAssets(Actions.Die);
		disposeAssets(Actions.SKIATK);
		disposeAssets(Actions.SKIATK_STOP);
		disposeAssets(Actions.SKIATK_SUMMONING);
		
		
        title.removeAllChild();

        if (title.parent)
            title.parent.removeChild(title);
        title = null;

        if (nameText)
        {
            nameText.dispose();
            nameText = null;
        }

        if (action_dict)
        {
            for (var _item:Object in action_dict)
            {
                if (action_dict[_item])
                {
                    action_dict[_item].stop();
                    action_dict[_item].removeEventListener(Event.ENTER_FRAME, onLoopEnter);
                    delete action_dict[_item]['action'];
                }
                delete action_dict[_item];
            }
        }
        action_dict = null;
        actionLoopDict = null;

        if (_textBitmap && _textBitmap.bitmapData)
            _textBitmap.bitmapData.dispose();

        if (offShadow && offShadow.bitmapData)
            offShadow.bitmapData.dispose();

        _action = 0;
        onActiveComplete = null;

        if (mountRes)
        {
            mountRes.dispose();
            mountRes = null;
        }

        if (render)
        {
            render.removeAllChild();

            if (render.parent)
                render.parent.removeChild(render);
            render = null;
        }

        if (iconLoad)
        {
            if (iconLoad.parent)
                iconLoad.parent.removeChild(iconLoad);
            iconLoad.dispose();
        }
        iconLoad = null;

        onActionCompleted = null;

        if (tween)
        {
            tween.kill();
            tween = null;
        }

        if (_skinConfig)
        {
            _skinConfig.dispose();
            _skinConfig = null;
        }
		
		resourceURL = null;
		
        super.dispose();
    }

}
}
