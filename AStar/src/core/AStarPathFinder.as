package core
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class AStarPathFinder
	{
		//====================================
		//	Constants
		//====================================
		//横向移动一格的路径评分
		private const COST_HORIZONTAL : int = 20;
		//竖向移动一格的路径评分
		private const COST_VERTICAL : int = 5;
		//斜向移动一格的路径评分
		private const COST_DIAGONAL : int = 12;
		
		
		private var currentUseMap:Array;	//当前使用的地图
		
		private var xMapStart:int;		//地图起始网格坐标
		private var yMapStart:int;		//地图起始网格坐标
		private var wMap:int;			//地图列数（每行格点数）
		private var hMap:int;			//地图行数（每列格点数）
		private var map:Array;			//与地图行列相同的数组，存放节点

		private var openList:Array = new Array();		//开放列表
		private var closeList:Array = new Array();		//关闭列表
		
		private var isFinded:Boolean = false;		//能否找到路径，true-已找到
		
		public var runTimeInMs:int = 0; 	//寻路时间
		
		public function AStarPathFinder(useMap:Array)
		{
			var tempIndex:int;
			this.currentUseMap = useMap;
			
			
//			for(var i:int=0;i<useMap.length;i++){
//				if(useMap[i]!=null)
//				this.hMap = Math.max(useMap[i].length,hMap);
//			}
			useMap.every(isNull);
			this.hMap=useMap[tempIndex].length;
			this.wMap = useMap.length;
			this.xMapStart =tempIndex;
//			this.yMapStart = 0;
			this.initMap(useMap);
			
	   function isNull(element:*, index:int, arr:Array):Boolean {
	   		tempIndex=index;
            return (element==null);
          }

		}
		
		public function find(startPoint:Point, endPoint:Point):Array
		{
			///// 运行时间 ////////////
			var startTime:int = getTimer();
			//////////////////////////
			
			var currentNode:Node = map[startPoint.y][startPoint.x];
			var endNode:Node = map[endPoint.y][endPoint.x];
			
			openList.push(currentNode);
			
			while(openList.length>0){
				//trace("openList.length:"+openList.length);
				//取出并删除开放列表第一个元素
				currentNode = openList.shift();
				
				//加入到关闭列表
				currentNode.isInOpen = false;
				currentNode.isInClose = true;
				this.closeList.push(currentNode);	
				
				//当前节点==目标节点
				if(currentNode.x==endPoint.x && currentNode.y==endPoint.y){
					this.isFinded = true;	//能达到终点，找到路径
					break;
				}
				
				//取相邻八个方向的节点，去除不可通过和以在关闭列表中的节点
				var aroundNodes:Array = this.getAroundsNode(currentNode.x, currentNode.y);
				
				for each (var node:Node in aroundNodes) //检测相邻的八个方向的节点
				{
					//trace("node:"+node.x+"||"+node.y);
					//计算 G， H 值   
					var g:int = this.getGValue(currentNode, node);
					var h:int = this.getHValue(currentNode, endNode, node);
					
					if (node.isInOpen)	//如果节点已在播放列表中
					{
						//trace("node.isInOpen");
						//如果该节点新的G值比原来的G值小,修改F,G值，设置该节点的父节点为当前节点
						if (g < node.g)
						{
							node.g = g;
							node.h = h;
							node.f = g + h;
							node.parentNode = currentNode;
							
							this.findAndSort(node);
						}
					} 
					else //如果节点不在开放列表中
					{
						//trace("node.isNO");
						//插入开放列表中，并按照估价值排序
						node.g = g;
						node.h = h;
						node.f = g + h;
						node.parentNode = currentNode;
						
						this.insertAndSort(node);
					}
					
				}
				//trace(this+":for each end in find");
			}
			
			//trace("path find end");
			if (this.isFinded)	//找到路径
			{
				var path:Array = this.createPath(startPoint.x, startPoint.y);
				this.destroyLists();
				
				///// 运行时间 ////////////
				this.runTimeInMs = getTimer() - startTime;
				//////////////////////////
			
				return path;
			} else {	//没有找到路径
				this.destroyLists();
				
				///// 运行时间 ////////////
				this.runTimeInMs = getTimer() - startTime;
				//////////////////////////
				
				return null;
			}
		}
		
		/**
		 * 生成路径数组
		 */
		private function createPath(xStart:int, yStart:int):Array
		{
			var path:Array = new Array();
			
			var node:Node = this.closeList.pop();
			
			while (node.x != xStart || node.y != yStart)
			{
				path.unshift(new Point(node.x, node.y));
				node = node.parentNode;
			}
			path.unshift(new Point(node.x, node.y));
			
			return path;
		}
		
		/**
		 * 删除列表中原来的node，并将node放到正确顺序
		 */
		private function findAndSort(node:Node):void
		{
			//trace("findAndSort");
			var listLength:int = this.openList.length;
			
			if (listLength < 1) return;
			for (var i:int=0; i<listLength; i++)
			{
				if (node.f <= this.openList[i].f)
				{
					this.openList.splice(i, 0, node);
				}
				if (node.x == this.openList[i].x && node.y == this.openList[i].y)
				{
					this.openList.splice(i, 1);
				}
			}
			//trace("findAndSort end");
		}
		
		/**
		 * 按由小到大顺序将节点插入到列表
		 */
		private function insertAndSort(node:Node):void
		{
			//trace("insertAndSort");
			node.isInOpen = true;
			
			var listLength:int = this.openList.length;
			
			if (listLength == 0)
			{
				this.openList.push(node);
			} else {
				for (var i:int=0; i<listLength; i++)
				{
					//trace("openList.length:"+openList.length);
					if (node.f <= this.openList[i].f)
					{
						this.openList.splice(i, 0, node);
						return;
					}
				}
				this.openList.push(node);
			}
			//trace("insertAndSort end");
		}
		
		/**
		 * 计算G值
		 */
		private function getGValue(currentNode:Node, node:Node):int
		{
			var g:int = 0; 
			if (currentNode.y == node.y)			// 横向  左右
			{
				g = currentNode.g + this.COST_HORIZONTAL;
			}
			else if (currentNode.y+2 == node.y || currentNode.y-2 == node.y)// 竖向  上下
			{
				g = currentNode.g + this.COST_VERTICAL * 2;
			}
			else						// 斜向  左上 左下 右上 右下
			{
				g = currentNode.g + this.COST_DIAGONAL;
			}
			
			return g;
		}
		
		/**
		 * 计算H值
		 */
		private function getHValue(currentNode:Node, endNode:Node, node:Node):int
		{
			var dx:int;
			var dy:int;
			//节点到0，0点的x轴距离
			var dxNodeTo0:int = node.x * this.COST_HORIZONTAL + (node.y&1) * this.COST_HORIZONTAL/2;
			//终止节点到0，0点的x轴距离
			var dxEndNodeTo0:int = endNode.x * this.COST_HORIZONTAL + (endNode.y&1) * this.COST_HORIZONTAL/2; 
			dx = Math.abs(dxEndNodeTo0 - dxNodeTo0);
			dy = Math.abs(endNode.y - node.y) * this.COST_VERTICAL;
			return dx + dy;
		}
		
		/**
		 * 得到周围八方向节点
		 */
		private function getAroundsNode(x:int, y:int):Array
		{
			var aroundNodes:Array = new Array();
			
			var checkX:int;
			var checkY:int;
			/**
			 * 菱形组合的地图八方向与正常不同
			 */
			//左
			checkX = x-1
			checkY = y;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("左:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//右
			checkX = x+1;
			checkY = y;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("右:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//上
			checkX = x;
			checkY = y-2;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("上:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//下
			checkX = x;
			checkY = y+2;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("下:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//左上
			checkX = x-1+(y&1);
			checkY = y-1;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("左上:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//左下
			checkX = x-1+(y&1);
			checkY = y+1;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("左下:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//右上
			checkX = x+(y&1);
			checkY = y-1;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("右上:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			//右下
			checkX = x+(y&1);
			checkY = y+1;
			if (isWalkable(checkX, checkY) && !this.map[checkY][checkX].isInClose)
			{
				//trace("右下:::"+checkY+"##"+checkX);
				aroundNodes.push(this.map[checkY][checkX]);
			}
			
			return aroundNodes;
		}
		
		/**
		 * 检查点在地图上是否可通过
		 */
		private function isWalkable(x:int, y:int):Boolean
		{
			// 1. 是否是有效的地图上点（数组边界检查）
//			if (x < this.xMapStart || x >= this.wMap) 
//			{
//				return false;
//			}
//			if (y < this.yMapStart || y >= this.hMap)
//			{
//				return false;
//			}
			
			// 2. 是否是walkable
			return (currentUseMap[x]!=undefined&&currentUseMap[x][y]!=undefined&&currentUseMap[x][y]==0);
		}
		
		
		/**
		 * 使用节点初始化一个行列与地图格点相同的数组
		 */
		private function initMap(useMap:Array)	:void
		{
//			trace("***"+this.hMap);
//			trace("***"+this.wMap);
			this.map = [];
			var tempIndex:int;
			useMap.some(isNull);
//			this.yMapStart = tempIndex;
//			for (var y:int=this.yMapStart; y<this.hMap; y++) {
//				if (map[y] == undefined) {
//					map[y] = [];
//				}
//				for (var x:int=this.xMapStart; x<this.wMap; x++) {
//					map[y][x] = new Node(x, y);
//				}
//			}
			for(var i:int=tempIndex;i<useMap.length;i++){
				if(useMap[i]==undefined) continue;
				creatNode(useMap[i],i,useMap);
			}
			
		function isNull(element:*, index:int, arr:Array):Boolean {
	   		tempIndex=index;
            return (element!=undefined);
          }
		}
		private function creatNode(temArray:Array,index:int,temArray1:Array):void{
			var tempIndex:int;
			temArray.some(isNull);
			for(var i:int=tempIndex;i<temArray.length;i++){
				if (map[i] == undefined) {
						map[i] = [];
					}
				
					map[i][index] = new Node(index, i);
				
			}
			
			function isNull(element:*, index:int, arr:Array):Boolean {
	   		tempIndex=index;
            return (element!=undefined);
          }
		}
		
		/**
		 * 销毁数组
		 */
		private function destroyLists():void
		{
			this.closeList = null;
			this.openList = null;
			this.map = null;
			this.currentUseMap=null;
		}
		
	}//end class
	
}//end package


class Node
{
	public var x:int;
	public var y:int;
	public var isInOpen:Boolean;
	public var isInClose:Boolean;
	public var g:int;
	public var h:int;
	public var f:int;
	public var parentNode:Node;
	
	public function Node(x:int, y:int)
	{
		this.x = x;
		this.y = y;
		this.isInOpen = false;
		this.isInClose = false;
		this.g = 0;
		this.h = 0;
		this.f = 0;
		this.parentNode = null;
	}
}
