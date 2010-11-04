package {
	import flash.display.MovieClip;
	
	public class ResourceCard extends MovieClip {
		
		public var resource:String;
		
		public function ResourceCard(resource:String) {
			this.resource = resource;
		}
		
//		public static function newCard(res:String) {
//			if (res == "wheat") {
//				return new WheatCard();
//			} else if (res == "sheep") {
//				return new SheepCard();
//			} else if (res == "wood") {
//				return new WoodCard();
//			} else if (res == "brick") {
//				return new BrickCard();
//			} else if (res == "ore") {
//				return new OreCard();
//			} else {
//				return null;
//			}
//		}
//	class WheatCard extends MovieClip {}
//	class SheepCard extends MovieClip {}
//	class WoodCard extends MovieClip {}
//	class BrickCard extends MovieClip {}
//	class OreCard extends MovieClip {}
	}
}