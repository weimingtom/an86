package anlei.away.d3d
{
	import anlei.away.Anlei3D;
	import anlei.away.utils.AnimActions;
	import anlei.loading.AnleiLoader;
	import anlei.loading.events.ALoaderProgressEvent;
	import anlei.loading.utils.ALoaderUtil;
	
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.data.Skeleton;
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.animators.transitions.CrossfadeTransition;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.AWD2Parser;
	import away3d.loaders.parsers.MD5AnimParser;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.loaders.parsers.ParserBase;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;

	public class AbsMesh
	{
		protected var path:String;
		protected var fileName:String;
		protected var key:String;
		private var textureList:Array;
		private var animList:Array;
		private var meshList:Array;
		
		public var uid:Number;
		public var skinId:String;
		public var isPlayer:Boolean = false;
		
		public var mesh:Mesh;
		public var skeleton:Skeleton;
		public var animationSet:SkeletonAnimationSet;
		public var animator:SkeletonAnimator;
		
		private var stateTransition:CrossfadeTransition = new CrossfadeTransition(.5);
		private var Parent:ObjectContainer3D;
		private var onComplete:Function;
		
		private var _This:AbsMesh;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function AbsMesh($fileName:String, $path:String = "assets/role/") {
			fileName = $fileName;
			path = $path;
			key = path + fileName;
			_This = this;
		}
		
		public function load($Parent:ObjectContainer3D, $fileNameList:Array, $onComplete:Function):void{
			Parent = $Parent;
			onComplete = $onComplete;
			textureList = $fileNameList[0];
			animList = $fileNameList[1];
			meshList = $fileNameList[2];
			startLoad();
		}
		
		private function startLoad():void
		{
			Parsers.enableAllBundled();
			loadAnim();
			loadTexture();
			loadMesh();
		}
		
		private function loadAnim():void{//1
			var arr:Array = [];
			for (var i:int = 0; i < animList.length; i++) {
				var _ku:String;
				var _key:String;
				if(String(animList[i]).indexOf("/") == -1){
					_ku = key + "/" + animList[i];
				}else{
					_ku = animList[i];
				}
				_key = _ku;
				arr.push([_ku, _key, '', true]);
			}
			if(arr.length > 0){
				AnleiLoader.getInstance().start(ALoaderUtil.c(arr), function():void{}, onAnimProg);
			}
		}
		
		private function loadTexture():void{//2
			var arr:Array = [];
			for (var i:int = 0; i < textureList.length; i++) {
				var _ku:String;
				var _key:String;
				if(String(textureList[i]).indexOf("/") == -1){
					_ku = key + "/" + textureList[i];
				}else{
					_ku = textureList[i];
				}
				_key = _ku;
				arr.push([_ku, _key, '', false]);
			}
			
			if(arr.length > 0){
				AnleiLoader.getInstance().start(ALoaderUtil.c(arr), onTextureComp, onAnimProg);
			}
		}
		
		private function loadMesh():void{//3
			var arr:Array = [];
			for (var i:int = 0; i < meshList.length; i++) {
				var _ku:String;
				var _key:String;
				if(String(meshList[i]).indexOf("/") == -1){
					_ku = key + "/" + meshList[i];
				}else{
					_ku = meshList[i];
				}
				_key = _ku;
				arr.push([_ku, _key, '', true]);
			}
			
			if(arr.length > 0){
				AnleiLoader.getInstance().start(ALoaderUtil.c(arr), onMeshComp, onAnimProg);
			}
			
		}
		
		private function onAnimComp():void {
			function onAssetCom(event:AssetEvent):void{
				if (event.asset.assetType == AssetType.ANIMATION_NODE) {
					var node:SkeletonClipNode = event.asset as SkeletonClipNode;
					node.name = node.assetNamespace;
					animationSet.addAnimation(node);
					if (node.name == AnimActions.stand) stop();
					j++;
					if(j > animList.length-1){
						if(onComplete) onComplete(_This);
					}
				}
			}
			var j:int = 0;
			for (var i:int = 0; i < animList.length; i++) {
				var _ku:String;
				if(String(animList[i]).indexOf("/") == -1){
					_ku = key + "/" + animList[i];
				}else{
					_ku = animList[i];
				}
				var _data:Object = AnleiLoader.getInstance().getData(_ku);
				var _arr:Array = animList[i].split(".");
				var _n:String = _arr[0];
				var _load3d:Loader3D = new Loader3D(false);
				_load3d.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetCom);
				_load3d.loadData(_data, null, _n, new MD5AnimParser());
			}
		}
		
		private function onTextureComp():void {
			
		}
		
		private function onMeshComp():void {
//			var _ku:String = key + "/" + meshList[0];
			var _ku:String;
			if(String(meshList[0]).indexOf("/") == -1){
				_ku = key + "/" + meshList[0];
			}else{
				_ku = meshList[0];
			}
			var _data:Object = AnleiLoader.getInstance().getData(_ku);
			var _load3d:Loader3D = new Loader3D(false);
			_load3d.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetsComp);
			_load3d.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComp);
			var _kzm:String = _ku.split(".")[1];
			var CLS:ParserBase;
			if(_kzm == "AWD"){
				CLS = new AWD2Parser();
			}else if(_kzm == "MD5MESH"){
				CLS = new MD5MeshParser();
			}
			_load3d.loadData(_data, null, null, CLS);
		}
		
		
		private function onAnimProg(event:ALoaderProgressEvent):void {
			
		}
		
		private function onResourceComp(event:LoaderEvent):void {
			
		}
		
		private function onAssetsComp(event:AssetEvent):void {
			if (event.asset.assetType == AssetType.MESH) {//3
				mesh = event.asset as Mesh;
				resetCoor();
				mesh.scale(0.5);
				for (var i:int = 0; i < textureList.length; i++) {
//					var _ku:String = key + "/" + textureList[i];
					var _ku:String;
					if(String(textureList[i]).indexOf("/") == -1){
						_ku = key + "/" + textureList[i];
					}else{
						_ku = textureList[i];
					}
					var bitmap:BitmapTexture = new BitmapTexture(AnleiLoader.getInstance().getBitmap(_ku).bitmapData);
					var _material:TextureMaterial = new TextureMaterial(bitmap);//Cast.bitmapTexture(bitmap.bitmapData));
					mesh.subMeshes[i].material = _material;
				}
				if(!Parent) Anlei3D.ins().add(mesh);
				else Parent.addChild(mesh);
				if(!animList || animList.length <= 0){
					if(onComplete){
						onComplete(_This);
						onComplete = null;
					}
				}
			} else if (event.asset.assetType == AssetType.SKELETON) {
				skeleton = event.asset as Skeleton;
			} else if (event.asset.assetType == AssetType.ANIMATION_SET) {
				animationSet = event.asset as SkeletonAnimationSet;
				animator = new SkeletonAnimator(animationSet, skeleton);
				onAnimComp();
				mesh.animator = animator;
			}
		}
		
		public function stop():void {
			if(animator){
				animator.playbackSpeed = 1;
				play(AnimActions.stand);
			}
		}

		public function play(action:String):void{
			if(animator){
				if(action == AnimActions.walk) animator.playbackSpeed = 0.6;
				if(animator.getAnimationStateByName(action))
					animator.play(action, stateTransition);
			}
		}
		
		public function move($x:Number, $y:Number, $z:Number):void{
			_x = $x;
			_y = $y;
			_z = $z;
			resetCoor();
		}
		
		private function resetCoor():void{
			if(mesh){
				mesh.position.x = _x;
				mesh.position.y = _y;
				mesh.position.z = _z;
			}
		}
		
	}
}