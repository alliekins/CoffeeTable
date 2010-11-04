package {

import flash.geom.Point;
import flash.display.MovieClip;
import fl.motion.*
import flash.geom.ColorTransform;

	public class Settlement extends MovieClip {
		
		public var myname:String = "";
		public var player:CatanPlayer;
		public var myColor:String;
		
		public function Settlement(p:Point, name:String, pl:CatanPlayer) {
			this.scaleX = .5;
			this.scaleY = .5;
			this.x = p.x;
			this.y = p.y;
			this.myname = name;
			this.player = pl;
			this.myColor = pl.playerColor;
			var colorTransform:ColorTransform = this.colorFill.transform.colorTransform;
			colorTransform.color = parseInt(this.player.playerColor);
			this.colorFill.transform.colorTransform = colorTransform;

		}
	}
}