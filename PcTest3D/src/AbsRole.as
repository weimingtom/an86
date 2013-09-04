package
{
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.data.Skeleton;
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.animators.transitions.CrossfadeTransition;
	import away3d.core.base.SubMesh;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.parsers.MD5AnimParser;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.utils.Cast;

	public class AbsRole
	{
		[Embed(source="assets/role/role.MD5MESH", mimeType="application/octet-stream")]
		private var roleMesh:Class;
		[Embed(source="assets/role/role.MD5ANIM", mimeType="application/octet-stream")]
		private var roleAnim:Class;
		
		[Embed(source="assets/role/Warrior_1.jpg")]
		private var Warrior_1:Class;
		[Embed(source="assets/role/Warrior_2.jpg")]
		private var Warrior_2:Class;
		[Embed(source="assets/role/Warrior_3.jpg")]
		private var Warrior_3:Class;
		[Embed(source="assets/role/Warrior_4.jpg")]
		private var Warrior_4:Class;
		[Embed(source="assets/role/Warrior_5.jpg")]
		private var Warrior_5:Class;
		[Embed(source="assets/role/Warrior_6.jpg")]
		private var Warrior_6:Class;
		
		private var Warrior_arr:Array = [Warrior_3, Warrior_4, Warrior_2, Warrior_1, Warrior_5, Warrior_6];
		
		private const IDLE_NAME:String = "idle2";
		private const WALK_NAME:String = "walk7";
		
		private var animator:SkeletonAnimator;
		private var animationSet:SkeletonAnimationSet;
		private var stateTransition:CrossfadeTransition = new CrossfadeTransition(0.5);
		private var skeleton:Skeleton;
		private var bodyMaterial:TextureMaterial;
		private var mesh:Mesh;
		
		private var isMoving:Boolean;
		private var onceAnim:String;
		private var currentAnim:String;
		private var movementDirection:Number=1;
		private var isRunning:Boolean;
		private const RUN_SPEED:Number = 2;
		private const WALK_SPEED:Number = 1;
		private const IDLE_SPEED:Number = 1;
		
		public function AbsRole()
		{
			inits();
		}
		
		private function inits():void {
			
			
			
			AssetLibrary.enableParser(MD5MeshParser);
			Parsers.enableAllBundled();
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetsComp);
			AssetLibrary.loadData(new roleMesh(), null, null, new MD5MeshParser());
			//AssetLibrary.load(new URLRequest("assets/role/role.AWD"));
		}
		
		private function onAssetsComp(event:AssetEvent):void {
			//trace(event.asset.name);
			if (event.asset.assetType == AssetType.ANIMATION_NODE) {
				var node:SkeletonClipNode = event.asset as SkeletonClipNode;
				var name:String = event.asset.assetNamespace;
				node.name = name;
				if(!animationSet.hasAnimation(name))
					animationSet.addAnimation(node);
				
				if (name == IDLE_NAME || name == WALK_NAME) {
					node.looping = true;
				} else {
					node.looping = false;
					node.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onPlaybackComplete);
				}
				
				if (name == IDLE_NAME) stop();
				
			} else if (event.asset.assetType == AssetType.ANIMATION_SET) {
				animationSet = event.asset as SkeletonAnimationSet;
				animator = new SkeletonAnimator(animationSet, skeleton);
				AssetLibrary.loadData(new roleAnim(), null, IDLE_NAME, new MD5AnimParser());
				mesh.animator = animator;
			} else if (event.asset.assetType == AssetType.SKELETON) {
				skeleton = event.asset as Skeleton;
			} else if (event.asset.assetType == AssetType.MESH) {
				//if(!mesh){
					//grab mesh object and assign our material object
					mesh = event.asset as Mesh;
					//mesh.material = bodyMaterial;
					for (var i:int = 0; i < mesh.subMeshes.length; i++) 
					{
						var _material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(Warrior_arr[i]));
						mesh.subMeshes[i].material = _material;
					}
					
					mesh.castsShadows = true;
					mesh.y = -300;
					mesh.scale(0.3);
					PcTest3D._view.camera.lookAt(mesh.upVector);
					PcTest3D._view.scene.addChild(mesh);
					
					//add our lookat object to the mesh
					//mesh.addChild(placeHolder);
				//}
			}
		}
		
		private function onPlaybackComplete(event:AnimationStateEvent):void
		{
			if (animator.activeState != event.animationState)
				return;
			
			onceAnim = null;
			
			animator.play(currentAnim, stateTransition);
			animator.playbackSpeed = isMoving? movementDirection*(isRunning? RUN_SPEED : WALK_SPEED) : IDLE_SPEED;
		}
		
		private function stop():void
		{
			isMoving = false;
			
			if (currentAnim == IDLE_NAME)
				return;
			
			currentAnim = IDLE_NAME;
			
			if (onceAnim)
				return;
			
			//update animator
			animator.playbackSpeed = IDLE_SPEED;
			animator.play(currentAnim, stateTransition);
		}
		
	}
}