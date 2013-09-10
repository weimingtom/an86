package anlei.away.d3d
{
	import anlei.away.Anlei3D;
	import anlei.loading.AnleiLoader;
	import anlei.loading.utils.ALoaderUtil;
	
	import away3d.extrusions.Elevation;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;

	public class AbsScene
	{
		public var terrain:Elevation;
		private var heightMaterial:TextureMaterial;
		private var heightLandKey:String = "heightland";
		private var mapSkinTextureKey:String = "mapskintexture";
		
		public var mapId:int;
		
		public function AbsScene() { }
		
		public function add($mapId:int, $onComplete:Function = null):void{
			clear();
			mapId = $mapId;
			var path:String = "assets/scene/map" + mapId + "/";
			AnleiLoader.getInstance().start(ALoaderUtil.c([[path + "heightland.png", heightLandKey],[path + "mapskin.jpg", mapSkinTextureKey]]), function():void{
				var _textureBitmap:BitmapTexture = new BitmapTexture(AnleiLoader.getInstance().getBitmap(mapSkinTextureKey).bitmapData);
				var _textureMaterial:TextureMaterial = new TextureMaterial(_textureBitmap);
				var _heightBitmap:BitmapTexture = new BitmapTexture(AnleiLoader.getInstance().getBitmap(heightLandKey).bitmapData);
				heightMaterial = new TextureMaterial(_heightBitmap);
				terrain = new Elevation(_textureMaterial, BitmapTexture(heightMaterial.texture).bitmapData,3000, 2000, 3000);
				Anlei3D.ins().add(terrain);
				if($onComplete) $onComplete();
			}, null);
		}
		
		private function clear():void{
			if(terrain){
				Anlei3D.ins().remove(terrain);
				terrain.dispose();
				terrain = null;
			}
			if(heightMaterial){
				heightMaterial.dispose();
				heightMaterial = null;
			}
			//////////
			AnleiLoader.getInstance().remove(heightLandKey);
			AnleiLoader.getInstance().remove(mapSkinTextureKey);
			
		}
		
	}
}