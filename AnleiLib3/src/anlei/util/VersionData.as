package anlei.util
{
	import anlei.util.PublicProperty;
	
	/**
	 * 编译版本号的XML文件记录
	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
 	<version app="OolongkidsMain" ofp="bin-release">
		<build count="2" time="2010-05-25 02:14:32"/>
		<release count="1" time="2010-05-25 02:05:25"/>
	</version>
	 * 
	 */	
	
	public class VersionData
	{
		
		private var versionXml:XML;
		
		//如果versionXml外部资源未编译成功，则使用该对象
		/**private const tempVersion:XML =
			<version app="未定义" ofp="bin-release">
				<build count="00" time="2010-05-25 02:14:32"/>
				<release count="00" time="2010-05-25 02:05:25"/>
			</version>;**/
		
		private var build:int;//编译版次数
		private var release:int;//发行版次数
		
		private var buildTime:String;
		private var releaseTime:String;
		
		private var appname:String;//项目名称
		private var apptype:String;//编译类型
		
//		private static var _instance:VersionData;
		
		/**
		 * 编译版本号的XML文件记录
		 */
		public function VersionData($versionXml:XML)
		{
			versionXml = $versionXml;
			inits();
		}
		private function inits():void
		{
			var vers:* = versionXml;
			build = int(XML(vers).build.@count);
			release = int(XML(vers).release.@count);
			buildTime = String(XML(vers).build.@time);
			releaseTime = String(XML(vers).release.@time);
			appname = String(XML(vers).@app);
			apptype = String(XML(vers).@ofp);
			PublicProperty.BUILDER_VERSION = build.toString();
		}
		
		/** 编译测试的次数 */		
		public function get BuildCount():int{
			return build;
		}
		
		/** 发行版的次数 */		
		public function get ReleaseCount():int{
			return release;
		}
		
		/** 最后编译测试的时间 */		
		public function get BuildTime():String{
			return buildTime;
		}
		
		/** 最后发行版的时间 */		
		public function get ReleaseTime():String{
			return releaseTime;
		}
		
		/** 项目名称 */		
		public function get AppName():String{
			return appname;
		}
		
		/** 编译类型(Debug/Release) */		
		public function get AppType():String{
			return apptype;
		}
		
		public function toString():String{
			return "[编译测试次数:" + BuildCount
					+ " " + "发行版次数:" + ReleaseCount
					+ " " + "项目名称:" + AppName
					+ " " + "编译类型:" + AppType
					+ "]";
		}
	}
}
class signle{}