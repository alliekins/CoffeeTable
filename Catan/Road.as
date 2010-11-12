package {

import flash.geom.Point;
import flash.display.MovieClip;
import fl.motion.*
import flash.geom.ColorTransform;
import BoardPiece;

	public class Road extends MovieClip {
		
		public var myname:String = "";
		public var player:CatanPlayer;
		public var myColor:String;
		
		public function Road(p:Point, r:Number, name:String, pl:CatanPlayer) {
			this.x = p.x;
			this.y = p.y;
			this.width = BoardPiece.SIDE*2/3;
			//this.width = BoardPiece.SIDE*1/8;
			this.height = BoardPiece.SIDE*1/8;
			this.rotation = r;
			this.myname = name;
			this.player = pl;
			this.myColor = pl.playerColor;
			var colorTransform:ColorTransform = this.colorFill.transform.colorTransform;
			colorTransform.color = parseInt(this.player.playerColor);
			this.colorFill.transform.colorTransform = colorTransform;

		}
	}
}