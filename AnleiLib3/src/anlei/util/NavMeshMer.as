package anlei.util
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import org.blch.findPath.Cell;
	import org.blch.findPath.NavMesh;
	import org.blch.geom.Delaunay;
	import org.blch.geom.Polygon;
	import org.blch.geom.Triangle;
	import org.blch.geom.Vector2f;

	public class NavMeshMer
	{
		private var x:Number;
		private var y:Number;
		private var w:Number;
		private var h:Number;
		
		public var polygonV:Vector.<Polygon>;		//所有多边形
		private var triangleV:Vector.<Triangle>; 	//生成的Delaunay三角形
		private var cellV:Vector.<Cell>;		//已生成的寻路数据
		
		public var drawPath:Vector.<Vector2f> = new Vector.<Vector2f>();
		
		public function NavMeshMer($x:Number = 0, $y:Number = 0, $w:Number = 800, $h:Number = 500) {
			x = $x;
			y = $y;
			w = $w;
			h = $h;
			recreatepolygonV();
		}
		
		private function recreatepolygonV():void{
			polygonV = new Vector.<Polygon>();//边框多边形
			var v0:Vector.<Vector2f> = new Vector.<Vector2f>();
			v0.push(new Vector2f(x, y));
			v0.push(new Vector2f(w, y));
			v0.push(new Vector2f(w, h));
			v0.push(new Vector2f(x, h));
			var poly0:Polygon = new Polygon(v0.length, v0);
			polygonV.push(poly0);
		}
		
		/**画个多边形(不可行走地)
		 * @param $x	x
		 * @param $y	y
		 * @param $end	是否包闭多边形
		 * 
		 */
		public function pushPath($x:Number, $y:Number, $end:Boolean = false):void{
			var vt:Vector2f = new Vector2f($x, $y);
			if (drawPath.length == 0) {
				drawPath.push(vt);
			}else{
				if($end){
					vt = drawPath[0];
					var pl:Polygon = new Polygon(drawPath.length, drawPath);
					pl.cw();
					polygonV.push(pl);
					drawPath = new Vector.<Vector2f>();
				}else{
					drawPath.push(vt);
				}
			}
		}
		
		/**合并*/		
		private function unionAll():void {
			for (var n:int=1; n<polygonV.length; n++) {
				var p0:Polygon = polygonV[n];
				for (var m:int=1; m<polygonV.length; m++) {
					var p1:Polygon = polygonV[m];
					//					trace("p0", p0.isCW(), p0);
					//					trace("p1", p1.isCW(), p1);
					if (p0 != p1 && p0.isCW() && p1.isCW()) {
						var v:Vector.<Polygon> = p0.union(p1);	//合并
						
						if (v != null && v.length > 0) {
							trace("delete");
							polygonV.splice(polygonV.indexOf(p0), 1);
							polygonV.splice(polygonV.indexOf(p1), 1);
							
							for each (var pv:Polygon in v) {
								polygonV.push(pv);
							}
							
							n = 1;	//重新开始
							break;
						}
					}
				}
			}
			//绘图
			/*polySp.graphics.lineStyle(3, 0xaaaaaa);
			for (var k:int=1; k<polygonV.length; k++) {
				var ptmp:Polygon = polygonV[k];
				ptmp.draw(polySp.graphics);
			}*/
		}
		
		/**搜索单元网格的邻接网格，并保存链接数据到网格中，以提供给寻路用*/		
		private function linkCells(pv:Vector.<Cell>):void {
			for each (var pCellA:Cell in pv) {
				for each (var pCellB:Cell in pv) {
					if (pCellA != pCellB) {
						pCellA.checkAndLink(pCellB);
					}
				}
			}
		}
		
		/**构建网格*/		
		public function buildTriangle():void {
			unionAll();
			
			var d:Delaunay = new Delaunay();
			triangleV = d.createDelaunay(polygonV);
			
			//构建寻路数据
			cellV = new Vector.<Cell>();
			var trg:Triangle;
			var cell:Cell;
			for (var j:int=0; j<triangleV.length; j++) {
				trg = triangleV[j];
				cell = new Cell(trg.getVertex(0), trg.getVertex(1), trg.getVertex(2));
				cell.index = j;
				cellV.push(cell);
				
				//cell.drawIndex(spgri);
			}
			linkCells(cellV);
		}
		
		/**从压缩的字节数组生成网络*/
		public function a2p(arrORbyte:*, exec:Function = null):void{
			recreatepolygonV();
			var _byte:ByteArray = new ByteArray();
			if(arrORbyte is Array){
				var _len:int = arrORbyte.length;
				for (var i:int = 0; i < _len; i++) {
					_byte.writeByte(arrORbyte[i]);
				}
			}
			if(arrORbyte is ByteArray) _byte = arrORbyte;
			//////////
			//_byte.uncompress();
			_byte.position = 0;
			arrORbyte = _byte.readObject();
			_len = arrORbyte.length;
			var _onf:Boolean = false;
			for (i = 0; i < _len; i++) {
				var _lr:int = arrORbyte[i].length;
				for (var j:int = 0; j < _lr; j++){
					var _mj:Array = arrORbyte[i][j];
					if(j == _lr-1){
						_onf = true;
						_mj = arrORbyte[i][0];
					}else{
						_onf = false;
					}
					if(exec)
						exec(_mj[0], _mj[1]);
					else
						pushPath(_mj[0], _mj[1], _onf);
				}
			}
			buildTriangle();
		}
		
		/**生成压缩的字节数组*/
		public function p2a():ByteArray{
			//polygonV.splice(0,1);
			var _arr:Array = [];
			
			var i_len:int = polygonV.length;
			for (var i:int = 0; i < i_len; i++) {
				_arr.push([]);
				var _velist:Vector.<Vector2f> = polygonV[i].vertexV;
				var j_len:int = polygonV[i].vertexV.length;
				for (var j:int = 0; j < j_len; j++) {
					_arr[_arr.length-1].push([_velist[j].x, _velist[j].y]);
				}
				if(_arr.length > 0)
					_arr[_arr.length-1].push(_arr[_arr.length-1][0]);
			}
			var _byte:ByteArray = new ByteArray();
			_byte.writeObject(_arr);
			//_byte.compress();
			return _byte;
		}
		
		private var startPtSign:Boolean = false;
		private var startPt:Point;
		private var endPt:Point;
		public function setFindPath($x:Number, $y:Number, lineSp:Sprite):void {
			if (startPtSign) {
				endPt = new Point($x, $y);
				startPtSign = false;
				
				lineSp.graphics.beginFill(0xff0000);
				lineSp.graphics.drawCircle(endPt.x, endPt.y, 3);
				lineSp.graphics.endFill();
				
				var nav:NavMesh = new NavMesh(cellV);
				lineSp.addChild(nav);
				nav.findPath(startPt, endPt);
			} else {
				startPt = new Point($x, $y);
				startPtSign = true;
				
				lineSp.graphics.beginFill(0x00ff00);
				lineSp.graphics.drawCircle(startPt.x, startPt.y, 3);
				lineSp.graphics.endFill();
			}
		}
		
		public function findPath($sx:Number, $sy:Number, $ex:Number, $ey:Number, $Root:Sprite = null):Array{
			if(!startPt) startPt = new Point($sx, $sy);
			if(!endPt) endPt = new Point($ex, $ey);
			startPt.x = $sx;
			startPt.y = $sy;
			endPt.x = $ex;
			endPt.y = $ey;
			var nav:NavMesh = new NavMesh(cellV);
			if($Root) $Root.addChild(nav);
			return nav.findPath(startPt, endPt);
		}
			
	}
}