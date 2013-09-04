package
{
import flash.display.Sprite;
import flash.events.Event;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;

import anlei.debug.ApplicationStats;
import anlei.util.EnterFrame;
import anlei.util.LoaderSource;
import anlei.util.PublicProperty;
import anlei.util.VersionData;
import anlei.util.cmouse.CustomMouseIcon;

import ui.UIConfig;
import ui.component.MyTextField;

/**
 * 用法: Entrance.getInstance().inits('config.xml', null, this, initsCOMPLETE);
 * @author Anlei 常见用应包组件(及UI)框架 2.0
 */
public class Entrance
{
	/**---------------------------------- Start 单例 -------------------------------------------*/
	private static var _instance:Entrance;
	public function Entrance(signle:Signle) {
		if (signle == null) throw new Error("Entrance类为单例，不能重新new");
	}
	public static function getInstance():Entrance {
		if (_instance == null) _instance = new Entrance(new Signle());
		return _instance;
	}
	/**----------------------------------  End 单例  -------------------------------------------*/

	/**是否被初始化过(true没, false有)**/
	private var isInitOnf:Boolean = true;

	public var Root:Sprite;

	private var versionData:XML;

	/**版本信息*/
	public var version:VersionData;

	public var gameVersionItem:ContextMenuItem;
	
	public var ver_txt:MyTextField;
	
	private var onComplete:Function;
	private var isMobile:Boolean;

	public var mouse:CustomMouseIcon;
	
	/**
	 * 框架组件初始化
	 * @param $configXmlUrl	配置文件路径（参考库中的config样例.xml）
	 * @param $versionData	版本号XML数据（参考global.util.VersionData类），当然也可以设为null
	 * @param $root			项目工作舞台根目录
	 * @param $onComplete	初始化完成后回调函数
	 * @param $isMobile		是否是移动项目,如果是则没有右键菜单
	 * @return 				返回自身 Entrance
	 */
	public function inits($configXmlUrl:String, $versionData:XML, $root:Sprite, $onComplete:Function, $isMobile:Boolean = false, $isSetMouseIcon:Boolean = false):Entrance
	{
		if (isInitOnf) {
			if($isSetMouseIcon){
				mouse = new CustomMouseIcon();
				mouse.showDef();
			}
			versionData = $versionData;
			Root = $root;
			UIConfig.initsUI(Root);
			onComplete = $onComplete;
			isMobile = $isMobile;
			new UIinit($configXmlUrl, inited);
			isInitOnf = false;
		} else {
			throw new Error("已经初化过了!");
		}
		return this;
	}

	//构建游戏的层次及UI组件关系
	private function inited():void {
		//对列加载资源类
		PublicProperty.source = new LoaderSource('mainnamekey');

		//生成右键版本号信息
		version = new VersionData(versionData);
		var conxml:XML = PublicProperty.CONFIG_XML;
		var _verstr:String = PublicProperty.CONFIG_XML.version.@value + '.' + version.ReleaseCount + '.' + version.BuildCount;
		
		if(!isMobile){
			gameVersionItem = new ContextMenuItem(_verstr, false, true);
			Root.contextMenu = new ContextMenu();
			if(Root.contextMenu){
				if(Root.contextMenu.hasOwnProperty('hideBuiltInItems')){
					Root.contextMenu['hideBuiltInItems']();
				}
				if(Root.contextMenu.hasOwnProperty('customItems')){
					Root.contextMenu['customItems'].push(gameVersionItem);
				}
			}
		}
		
		ver_txt = new MyTextField();
		ver_txt.text = _verstr;
		ver_txt.mouseEnabled = false;
		ver_txt.width = 250;
		ver_txt.isStroke = true;
		ver_txt.x = PublicProperty.CONFIG_XML.version.@x;
		ver_txt.y = PublicProperty.CONFIG_XML.version.@y;
		Root.addChild(ver_txt);
		Root.stage.stageFocusRect = false;
		
		toLayer();
		if(onComplete!=null){
			onComplete();
			onComplete = null;
		}
	}

	private function toLayer(e:Event = null):void {
		EnterFrame.init(Root.stage);

		var debug_onf:Boolean = PublicProperty.CONFIG_XML.trace.@value == '0' ? false : true;
		if (debug_onf) {
			ApplicationStats.getInstance().init(Root);
//			var debug:String = Root.loaderInfo.parameters.debug;
//			if (debug == null || debug == undefined as String) debug = "false";
//			ApplicationStats.DEBUG = (debug == "true" || debug == "1");
			ApplicationStats.DEBUG = true;
		}
	}
}
}
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import anlei.util.PublicProperty;

class Signle
{
}

class UIinit
{
	private var onComplete:Function;
	public function UIinit($configXmlUrl:String, $onComplete:Function)
	{
		onComplete = $onComplete;
		var myLoader:URLLoader = new URLLoader(new URLRequest($configXmlUrl));
		myLoader.addEventListener(Event.COMPLETE, loadConfigXMLConplete);
	}

	private function loadConfigXMLConplete(e:Event):void
	{
		var myLoader:URLLoader = e.target as URLLoader;
		myLoader.removeEventListener(Event.COMPLETE, loadConfigXMLConplete);

		PublicProperty.CONFIG_XML = XML(myLoader.data);
		if(onComplete!=null){
			onComplete();
			onComplete = null;
		}
	}
}
