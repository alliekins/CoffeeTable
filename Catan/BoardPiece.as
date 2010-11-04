package {
	import flash.display.MovieClip;
	
	public class BoardPiece extends MovieClip {
		
		public var numtoken:NumberToken;
		public var resource:String;
		public var num:Number;
		public static var numPieces:Object = {
			wheat:4,
			sheep:4,
			wood:4,
			brick:3,
			ore:3,
			desert:1
		}
		public static var SIZE:Number = 120;
		public static var LONGSIZE:Number = Math.round(SIZE*(2/Math.sqrt(3)));
		public static var SIDE:Number = Math.round(LONGSIZE/2);
		
		public function BoardPiece(num:Number, resource:String) {
			this.resource = resource;
			this.num = num;
			this.height = LONGSIZE;
			this.width = SIZE;
			//this.rotation = 60;
			var rot:Number = Math.floor(Math.random()*6);
			if (resource == "wheat") {
				var whfacade:WheatFacade = new WheatFacade();
				whfacade.rotation += 60*rot;
				this.addChild(whfacade);
			} else if (resource == "ore") {
				var orfacade:OreFacade = new OreFacade();
				orfacade.rotation += 60*rot;
				this.addChild(orfacade);
			} else if (resource == "wood") {
				var wofacade:WoodFacade = new WoodFacade();
				wofacade.rotation += 60*rot;
				this.addChild(wofacade);
			} else if (resource == "sheep") {
				var shfacade:SheepFacade = new SheepFacade();
				shfacade.rotation += 60*rot;
				this.addChild(shfacade);
			} else if (resource == "brick") {
				var brfacade:BrickFacade = new BrickFacade();
				brfacade.rotation += 60*rot;
				this.addChild(brfacade);
			} else {
				var dfacade:DesertFacade = new DesertFacade();
				dfacade.rotation += 60*rot;
				this.addChild(dfacade);
			}
			
		}
		
		public function addToken(numToken:NumberToken) {
			this.numtoken = numToken;
			this.addChild(numToken);
		}
	}
}