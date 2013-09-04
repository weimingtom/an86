package ui.component
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import ui.event.MyDragEvent;

	/**
	 * 在某个容器中可以拖出一个图标跟随鼠标
	 * 当在其他容器中松开鼠标时，检测这个容器中是否有setDragDataFunctionName方法，有就执行该方法，并代入参数_data数据
	 * @author Anlei
	 */
	public class MyDrag {
		
		private var containe:Sprite;
		private var _icon:Bitmap;
		private var _bd:BitmapData
		
		private var mddt:MyDragDistanceTrigger;
		private var _dragIcon:DisplayObject;
		
		private var _initPoint:Point = new Point();
		
		public var _targetType:String;
		
		public function MyDrag($containe:Sprite){
			containe = $containe;
			_icon = new Bitmap();
			mddt = new MyDragDistanceTrigger(containe, onMD, onMU, onMV);
			mddt.addMouseEvent();
		}
		
		public function dispose():void{
			mddt.dispose();
			mddt = null;
			
			if(containe.stage.contains(_icon)) containe.stage.removeChild(_icon);
			
			if(_bd){
				_bd.dispose();
				_bd = null;
			}
			_icon = null;
			containe = null;
			
		}
		
		public function setDragIcon(dod:DisplayObject):void{
			_dragIcon = dod;
		}
		
		public function addMouseEvent():void{
			mddt.addMouseEvent();
		}
		
		public function removeMouseEvent():void{
			mddt.removeMouseEvent();
		}
		
		private function get stage():Stage{
			return Entrance.getInstance().Root.stage;
		}
		
		private function onMD(e:* = null):void{
			_initPoint.x = stage.mouseX;
			_initPoint.y = stage.mouseY;
			containe.dispatchEvent(new MyDragEvent(MyDragEvent.DRAG_START));
		}
		private function onMU(e:* = null):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMU);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMV);
			
			if(mddt.CURR_MOUSE_STATE == mddt.CURR_MOUSE_STATE_SELECT){
				var _tar:MySprite;
				if(_targetType=="currentTarget")
					_tar = e.currentTarget as MySprite;
				else
					_tar = e.target as MySprite;
				if(_tar && _tar.isAccept && _tar != containe){
					var _evt:MyDragEvent = new MyDragEvent(MyDragEvent.DRAG_COMPLETE);
					_evt.sender = containe;
					_tar.dispatchEvent(_evt);
					TweenLite.to(_icon, 0.5, 
						{	alpha:0,
							x:_tar.stage.mouseX,
							y:_tar.stage.mouseY,
							scaleX:0, scaleY:0,
							onComplete:onRemoveIcon});
					//return;
				}else{
					TweenLite.to(_icon, 0.5, 
						{	alpha:0,
							x:_initPoint.x,
							y:_initPoint.y,
							onComplete:onRemoveIcon});
				}
				
			}
			
			containe.dispatchEvent(new MyDragEvent(MyDragEvent.DRAG_END));
		}
		
		private function onMV(e:* = null):void{
			if(!stage.contains(_icon)){
				stage.addChild(_icon);
				if(!_bd){
					var _con:DisplayObject = _dragIcon == null ? containe: _dragIcon;
					if(_con.width > 0 && _con.height > 0){
						_bd = new BitmapData(_con.width, _con.height,true,0);
						_bd.draw(_con);
						_icon.bitmapData = _bd;
					}
				}
			}
			_icon.x = stage.mouseX - _icon.width /2;
			_icon.y = stage.mouseY - _icon.height/2;
		}
		
		/////////////////////
		
		private function onRemoveIcon():void{
			if(_bd){
				_bd.dispose();
				_bd = null;
			}
			
			if(stage.contains(_icon))
				stage.removeChild(_icon);
			_icon.scaleX = _icon.scaleY = 1;
			_icon.alpha = 1;
		}
	}
}

