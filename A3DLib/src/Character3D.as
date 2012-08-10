package
{
	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.animation.AnimationController;
	import alternativa.engine3d.animation.AnimationSwitcher;
	import alternativa.engine3d.loaders.ParserCollada;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.resources.BitmapTextureResource;
	
	import flash.display.BitmapData;

	public class Character3D
	{
		//蒙皮名字
		private var ChildSkin_name:String = "character";
		/**播放动作的时间间隔*/
		public var timeScale:Number = 0.7;
		
		//3D模型文件
		private var dae:XML;
		//贴图
		private var Skin_bitmapData:BitmapData;
		//3D模型文件处理器
		public var characterParser:ParserCollada;
		/**蒙皮或面的视图*/
		public var character:Mesh;
		//材质源
		private var characterResource:BitmapTextureResource;
		//材质
		private var characterMaterial:TextureMaterial;
		/**动画控制器*/
		public var animationController:AnimationController = new AnimationController();
		/**动作装载器*/
		public var animationSwitcher:AnimationSwitcher = new AnimationSwitcher();
		
		public function Character3D($dae:XML, $Skin_bitmapData:BitmapData, $ChildSkin_name:String = "character")
		{
			dae = $dae;
			Skin_bitmapData = $Skin_bitmapData;
			ChildSkin_name = $ChildSkin_name;
			inits();
		}
		
		private function inits():void
		{
			animationSwitcher.speed = timeScale;
			animationController.root = animationSwitcher;
			
			characterParser = new ParserCollada();
			characterParser.parse(dae);
			character = characterParser.getObjectByName(ChildSkin_name) as Mesh;// as Skin;
			characterResource = new BitmapTextureResource(Skin_bitmapData);
			characterMaterial = new TextureMaterial(characterResource);
			character.setMaterialToAllSurfaces(characterMaterial);
			
			A3DLib.getInstance().scene.addChild(character);
			
			uploadGPU_characterResource();
			uploadGPU_character();
			
			character.mouseEnabled = false;
		}
		
		private function uploadGPU_characterResource():void{
			characterResource.upload(A3DLib.getInstance().stage3D.context3D);
		}
		
		private function uploadGPU_character():void{
			character.geometry.upload(A3DLib.getInstance().stage3D.context3D);
		}
		
		/**更新贴图*/
		public function updateTexture($bitmapData:BitmapData):void{
			Skin_bitmapData = $bitmapData;
			characterResource.data = Skin_bitmapData;
			uploadGPU_characterResource();
		}
		/**获取整个模型的剪辑
		 * 注：分隔动作idle = animation.slice(0, 40/30);从第0帧到第40帧(在源文件中以每秒播放30帧的频率)
		 * */
		public function getAnimationByObject():AnimationClip{
			return characterParser.getAnimationByObject(character);
		}
		
		/**添加一个动画剪辑*/
		public function addAnimation(ac:AnimationClip):void{
			animationSwitcher.addAnimation(ac);
		}
		/**播放一个动画剪辑
		 * @param ac	已添加过的剪辑
		 * @param time	缓冲播放时间
		 */
		public function activate(ac:AnimationClip, time:Number=0):void{
			animationSwitcher.activate(ac, time);
		}
		
		/**渲染*/
		public function update():void{
			animationController.update();
		}
		
	}
}